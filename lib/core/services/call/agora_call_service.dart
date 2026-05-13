import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:imovie_app/core/error/app_exception.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/logger/app_logger.dart';
import 'package:imovie_app/domain/entities/call/call_session.dart';

class AgoraRemoteUser {
  const AgoraRemoteUser({required this.uid});

  final int uid;
}

abstract interface class AgoraCallService {
  Stream<List<AgoraRemoteUser>> get remoteUsersStream;

  Future<void> join(CallSession call);

  Future<void> leave();

  Future<void> setMuted(bool muted);

  Future<void> setCameraEnabled(bool enabled);

  Future<void> switchCamera();

  Future<void> dispose();

  RtcEngine? get engine;
}

class RtcAgoraCallService implements AgoraCallService {
  RtcAgoraCallService({required String appId}) : _appId = appId.trim();

  static const _logName = 'AgoraCall';
  static const _sdkTimeout = Duration(seconds: 20);

  final String _appId;
  final StreamController<List<AgoraRemoteUser>> _remoteUsersController =
      StreamController<List<AgoraRemoteUser>>.broadcast();
  final List<AgoraRemoteUser> _remoteUsers = <AgoraRemoteUser>[];
  RtcEngine? _engine;
  bool _joined = false;

  @override
  Stream<List<AgoraRemoteUser>> get remoteUsersStream =>
      _remoteUsersController.stream;

  @override
  RtcEngine? get engine => _engine;

  @override
  Future<void> join(CallSession call) async {
    if (_appId.isEmpty) {
      throw AppException(
        AppFailure.configuration('AGORA_APP_ID is not configured.'),
      );
    }
    if (!call.canJoin) {
      throw AppException(
        AppFailure.configuration('Agora call session is not ready.'),
      );
    }

    AppLogger.info(
      'Join call=${AppLogger.shortId(call.id)} '
      'channel=${AppLogger.shortId(call.agoraChannel)} type=${call.type.name}',
      name: _logName,
    );
    try {
      final engine = await _ensureEngine();
      if (call.isVideo) {
        await _withSdkTimeout(engine.enableVideo(), operation: 'enableVideo');
        await _withSdkTimeout(engine.startPreview(), operation: 'startPreview');
      } else {
        await _withSdkTimeout(engine.disableVideo(), operation: 'disableVideo');
      }

      await _withSdkTimeout(
        engine.joinChannel(
          token: call.agoraToken,
          channelId: call.agoraChannel,
          uid: call.agoraUid,
          options: ChannelMediaOptions(
            channelProfile: ChannelProfileType.channelProfileCommunication,
            clientRoleType: ClientRoleType.clientRoleBroadcaster,
            publishMicrophoneTrack: true,
            publishCameraTrack: call.isVideo,
            autoSubscribeAudio: true,
            autoSubscribeVideo: call.isVideo,
          ),
        ),
        operation: 'joinChannel',
      );
      _joined = true;
      AppLogger.info(
        'Join call success call=${AppLogger.shortId(call.id)}',
        name: _logName,
      );
    } catch (error, stackTrace) {
      _joined = false;
      AppLogger.error(
        'Join call failed call=${AppLogger.shortId(call.id)}.',
        name: _logName,
        error: error,
        stackTrace: stackTrace,
      );
      throw _failureFromSdkError(
        error,
        timeoutMessage:
            'Kết nối cuộc gọi Agora quá lâu. Vui lòng thử lại sau vài giây.',
        fallbackMessage: 'Không thể tham gia cuộc gọi Agora.',
      );
    }
  }

  @override
  Future<void> leave() async {
    final engine = _engine;
    if (engine == null || !_joined) {
      return;
    }

    await _withSdkTimeout(engine.leaveChannel(), operation: 'leaveChannel');
    _joined = false;
    _remoteUsers.clear();
    _remoteUsersController.add(const []);
  }

  @override
  Future<void> setMuted(bool muted) async {
    final engine = _engine;
    if (engine == null) {
      return;
    }
    await _withSdkTimeout(
      engine.muteLocalAudioStream(muted),
      operation: 'muteLocalAudioStream',
    );
  }

  @override
  Future<void> setCameraEnabled(bool enabled) async {
    final engine = _engine;
    if (engine == null) {
      return;
    }
    await _withSdkTimeout(
      engine.muteLocalVideoStream(!enabled),
      operation: 'muteLocalVideoStream',
    );
  }

  @override
  Future<void> switchCamera() async {
    final engine = _engine;
    if (engine == null) {
      return;
    }
    await _withSdkTimeout(engine.switchCamera(), operation: 'switchCamera');
  }

  @override
  Future<void> dispose() async {
    await leave();
    await _engine?.release();
    _engine = null;
    await _remoteUsersController.close();
  }

  Future<RtcEngine> _ensureEngine() async {
    final existing = _engine;
    if (existing != null) {
      return existing;
    }

    final engine = createAgoraRtcEngine();
    try {
      await _withSdkTimeout(
        engine.initialize(RtcEngineContext(appId: _appId)),
        operation: 'initialize',
      );
    } catch (error, stackTrace) {
      AppLogger.error(
        'Initialize Agora RTC failed.',
        name: _logName,
        error: error,
        stackTrace: stackTrace,
      );
      await engine.release();
      throw _failureFromSdkError(
        error,
        timeoutMessage:
            'Khởi tạo Agora Call quá lâu. Vui lòng thử lại sau vài giây.',
        fallbackMessage: 'Không thể khởi tạo Agora Call.',
      );
    }
    engine.registerEventHandler(
      RtcEngineEventHandler(
        onUserJoined: (_, uid, _) {
          if (_remoteUsers.any((user) => user.uid == uid)) {
            return;
          }
          _remoteUsers.add(AgoraRemoteUser(uid: uid));
          _remoteUsersController.add(List.unmodifiable(_remoteUsers));
        },
        onUserOffline: (_, uid, _) {
          _remoteUsers.removeWhere((user) => user.uid == uid);
          _remoteUsersController.add(List.unmodifiable(_remoteUsers));
        },
        onLeaveChannel: (_, _) {
          _remoteUsers.clear();
          _remoteUsersController.add(const []);
        },
      ),
    );
    _engine = engine;
    return engine;
  }

  Future<T> _withSdkTimeout<T>(Future<T> future, {required String operation}) {
    return future.timeout(
      _sdkTimeout,
      onTimeout: () {
        throw TimeoutException(
          'Agora RTC $operation timed out after ${_sdkTimeout.inSeconds}s.',
          _sdkTimeout,
        );
      },
    );
  }

  AppException _failureFromSdkError(
    Object error, {
    required String timeoutMessage,
    required String fallbackMessage,
  }) {
    if (error is AppException) {
      return error;
    }
    if (error is TimeoutException) {
      return AppException(
        AppFailure.network(timeoutMessage, details: error.toString()),
      );
    }
    return AppException(
      AppFailure.unknown(fallbackMessage, details: error.toString()),
    );
  }
}

class NoOpAgoraCallService implements AgoraCallService {
  const NoOpAgoraCallService();

  @override
  Stream<List<AgoraRemoteUser>> get remoteUsersStream => const Stream.empty();

  @override
  RtcEngine? get engine => null;

  @override
  Future<void> dispose() async {}

  @override
  Future<void> join(CallSession call) async {}

  @override
  Future<void> leave() async {}

  @override
  Future<void> setCameraEnabled(bool enabled) async {}

  @override
  Future<void> setMuted(bool muted) async {}

  @override
  Future<void> switchCamera() async {}
}
