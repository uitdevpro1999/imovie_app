import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/services/call/agora_call_service.dart';
import 'package:imovie_app/domain/entities/call/call_session.dart';

class ActiveCallState implements BaseState {
  const ActiveCallState({
    required this.call,
    this.pageStatus = PageStatus.initial,
    this.processing = false,
    this.failure,
    this.remoteUsers = const [],
    this.muted = false,
    this.cameraEnabled = true,
    this.shouldClose = false,
  });

  final CallSession call;
  @override
  final PageStatus pageStatus;
  @override
  final bool processing;
  @override
  final AppFailure? failure;
  final List<AgoraRemoteUser> remoteUsers;
  final bool muted;
  final bool cameraEnabled;
  final bool shouldClose;

  ActiveCallState copyWith({
    CallSession? call,
    PageStatus? pageStatus,
    bool? processing,
    AppFailure? failure,
    bool clearFailure = false,
    List<AgoraRemoteUser>? remoteUsers,
    bool? muted,
    bool? cameraEnabled,
    bool? shouldClose,
  }) {
    return ActiveCallState(
      call: call ?? this.call,
      pageStatus: pageStatus ?? this.pageStatus,
      processing: processing ?? this.processing,
      failure: clearFailure ? null : failure ?? this.failure,
      remoteUsers: remoteUsers ?? this.remoteUsers,
      muted: muted ?? this.muted,
      cameraEnabled: cameraEnabled ?? this.cameraEnabled,
      shouldClose: shouldClose ?? this.shouldClose,
    );
  }

  @override
  ActiveCallState copyWithBase({
    PageStatus? pageStatus,
    bool? processing,
    AppFailure? failure,
    bool clearFailure = false,
  }) {
    return copyWith(
      pageStatus: pageStatus,
      processing: processing,
      failure: failure,
      clearFailure: clearFailure,
    );
  }
}
