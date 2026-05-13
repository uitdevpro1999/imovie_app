import 'dart:async';

import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_exception.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/services/call/agora_call_service.dart';
import 'package:imovie_app/core/services/call/callkit_service.dart';
import 'package:imovie_app/core/services/call/call_permission_service.dart';
import 'package:imovie_app/core/services/call/call_proximity_service.dart';
import 'package:imovie_app/domain/entities/call/call_session.dart';
import 'package:imovie_app/domain/usecases/call/end_call_use_case.dart';
import 'package:imovie_app/domain/usecases/call/watch_call_use_case.dart';
import 'package:imovie_app/presentation/ui/call/active/active_call_state.dart';

class ActiveCallCubit extends BaseCubit<ActiveCallState> {
  ActiveCallCubit({
    required CallSession call,
    required AgoraCallService agoraCallService,
    required CallkitService callkitService,
    required CallPermissionService callPermissionService,
    required CallProximityService callProximityService,
    required EndCallUseCase endCallUseCase,
    required WatchCallUseCase watchCallUseCase,
  }) : _agoraCallService = agoraCallService,
       _callkitService = callkitService,
       _callPermissionService = callPermissionService,
       _callProximityService = callProximityService,
       _endCallUseCase = endCallUseCase,
       _watchCallUseCase = watchCallUseCase,
       super(ActiveCallState(call: call, cameraEnabled: call.isVideo));

  final AgoraCallService _agoraCallService;
  final CallkitService _callkitService;
  final CallPermissionService _callPermissionService;
  final CallProximityService _callProximityService;
  final EndCallUseCase _endCallUseCase;
  final WatchCallUseCase _watchCallUseCase;
  StreamSubscription<List<AgoraRemoteUser>>? _remoteUsersSubscription;
  StreamSubscription<CallStatus>? _callSubscription;
  bool _closingFromRemoteStatus = false;

  AgoraCallService get agoraCallService => _agoraCallService;

  @override
  Future<void> initData() async {
    emit(state.copyWith(pageStatus: PageStatus.loading, clearFailure: true));
    _remoteUsersSubscription = _agoraCallService.remoteUsersStream.listen(
      (users) => emit(state.copyWith(remoteUsers: users)),
    );
    _callSubscription = _watchCallUseCase(
      state.call.id,
    ).listen((status) => unawaited(_handleCallStatus(status)));
    try {
      await _callPermissionService.ensureCallPermissions(state.call.type);
      if (_closingFromRemoteStatus || state.call.isFinished) {
        emit(state.copyWith(pageStatus: PageStatus.loaded, shouldClose: true));
        return;
      }
      await _agoraCallService.join(state.call);
      if (_closingFromRemoteStatus || state.call.isFinished) {
        emit(state.copyWith(pageStatus: PageStatus.loaded, shouldClose: true));
        return;
      }
      if (!state.call.isVideo) {
        await _callProximityService.enable();
      }
      await _callkitService.setCallConnected(state.call.id);
      emit(state.copyWith(pageStatus: PageStatus.loaded, clearFailure: true));
    } catch (error) {
      final failure = _failureFromError(error);
      emit(state.copyWith(pageStatus: PageStatus.error, failure: failure));
      showFailureToast(failure);
    }
  }

  AppFailure _failureFromError(Object error) {
    return switch (error) {
      AppException() => error.failure,
      AppFailure() => error,
      _ => AppFailure.unknown(
        'Không thể tham gia cuộc gọi.',
        details: error.toString(),
      ),
    };
  }

  Future<void> toggleMute() async {
    final next = !state.muted;
    await _agoraCallService.setMuted(next);
    emit(state.copyWith(muted: next));
  }

  Future<void> toggleCamera() async {
    final next = !state.cameraEnabled;
    await _agoraCallService.setCameraEnabled(next);
    emit(state.copyWith(cameraEnabled: next));
  }

  Future<void> switchCamera() => _agoraCallService.switchCamera();

  Future<void> _handleCallStatus(CallStatus status) async {
    final updatedCall = state.call.copyWith(
      status: status,
      endedAt: status == CallStatus.declined || status == CallStatus.ended
          ? DateTime.now()
          : null,
    );
    emit(state.copyWith(call: updatedCall));

    if (!updatedCall.isFinished || _closingFromRemoteStatus) {
      return;
    }
    _closingFromRemoteStatus = true;
    await _callProximityService.disable();
    await _agoraCallService.leave();
    await _callkitService.endCall(state.call.id);
    emit(
      state.copyWith(
        call: updatedCall,
        pageStatus: PageStatus.loaded,
        processing: false,
        shouldClose: true,
      ),
    );
  }

  Future<void> endCall() async {
    emit(state.copyWith(processing: true, clearFailure: true));
    await _callProximityService.disable();
    await _agoraCallService.leave();
    await _callkitService.endCall(state.call.id);
    final result = await _endCallUseCase(EndCallParams(callId: state.call.id));
    result.map(
      success: (_) => emit(state.copyWith(processing: false)),
      failure: (failure) {
        emit(state.copyWith(processing: false, failure: failure));
        showFailureToast(failure);
      },
    );
  }

  @override
  Future<void> close() async {
    await _remoteUsersSubscription?.cancel();
    await _callSubscription?.cancel();
    await _callProximityService.disable();
    await _agoraCallService.dispose();
    return super.close();
  }
}
