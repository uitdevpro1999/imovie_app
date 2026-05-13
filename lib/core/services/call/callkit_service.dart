import 'dart:async';

import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/ios_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:imovie_app/domain/entities/call/call_session.dart';

abstract interface class CallkitService {
  Stream<CallEvent?> get events;

  Future<void> showIncomingCall(CallSession call);

  Future<void> startOutgoingCall(CallSession call);

  Future<void> setCallConnected(String callId);

  Future<void> endCall(String callId);

  Future<void> endAllCalls();

  Future<String> getVoipToken();

  Future<void> requestAndroidNotificationPermission();
}

class FlutterIncomingCallkitService implements CallkitService {
  const FlutterIncomingCallkitService();

  @override
  Stream<CallEvent?> get events => FlutterCallkitIncoming.onEvent;

  @override
  Future<void> showIncomingCall(CallSession call) {
    return FlutterCallkitIncoming.showCallkitIncoming(_paramsFor(call));
  }

  @override
  Future<void> startOutgoingCall(CallSession call) {
    return FlutterCallkitIncoming.startCall(_paramsFor(call));
  }

  @override
  Future<void> setCallConnected(String callId) {
    return FlutterCallkitIncoming.setCallConnected(callId);
  }

  @override
  Future<void> endCall(String callId) {
    return FlutterCallkitIncoming.endCall(callId);
  }

  @override
  Future<void> endAllCalls() {
    return FlutterCallkitIncoming.endAllCalls();
  }

  @override
  Future<String> getVoipToken() async {
    return (await FlutterCallkitIncoming.getDevicePushTokenVoIP()).toString();
  }

  @override
  Future<void> requestAndroidNotificationPermission() {
    return FlutterCallkitIncoming.requestNotificationPermission({
      'rationaleMessagePermission':
          'Ứng dụng cần quyền thông báo để hiển thị cuộc gọi đến.',
      'postNotificationMessageRequired':
          'Vui lòng bật thông báo để nhận cuộc gọi đến.',
    });
  }

  CallKitParams _paramsFor(CallSession call) {
    return CallKitParams(
      id: call.id,
      nameCaller: call.callerName,
      appName: 'iMovie',
      avatar: call.callerAvatarUrl,
      handle: call.callerName,
      type: call.isVideo ? 1 : 0,
      duration: 30000,
      textAccept: 'Nghe',
      textDecline: 'Từ chối',
      extra: {
        'callId': call.id,
        'conversationId': call.conversationId,
        'type': call.isVideo ? 'video' : 'audio',
      },
      android: const AndroidParams(
        isCustomNotification: true,
        isShowFullLockedScreen: false,
        isImportant: true,
        isBot: false,
        isShowLogo: false,
        ringtonePath: 'system_ringtone_default',
        backgroundColor: '#111111',
        backgroundUrl: '',
        actionColor: '#F8C84B',
        textColor: '#FFFFFF',
        incomingCallNotificationChannelName: 'Cuộc gọi đến',
        missedCallNotificationChannelName: 'Cuộc gọi nhỡ',
        isShowCallID: false,
      ),
      ios: IOSParams(
        iconName: 'CallKitLogo',
        handleType: 'generic',
        supportsVideo: call.isVideo,
        maximumCallGroups: 1,
        maximumCallsPerCallGroup: 1,
        audioSessionMode: call.isVideo ? 'videoChat' : 'voiceChat',
        audioSessionActive: true,
        audioSessionPreferredSampleRate: 44100,
        audioSessionPreferredIOBufferDuration: 0.005,
        supportsDTMF: false,
        supportsHolding: false,
        supportsGrouping: false,
        supportsUngrouping: false,
        ringtonePath: 'system_ringtone_default',
      ),
      headers: const {'accent': '#F8C84B'},
    );
  }
}

class NoOpCallkitService implements CallkitService {
  const NoOpCallkitService();

  @override
  Stream<CallEvent?> get events => const Stream.empty();

  @override
  Future<void> endAllCalls() async {}

  @override
  Future<void> endCall(String callId) async {}

  @override
  Future<String> getVoipToken() async => '';

  @override
  Future<void> requestAndroidNotificationPermission() async {}

  @override
  Future<void> setCallConnected(String callId) async {}

  @override
  Future<void> showIncomingCall(CallSession call) async {}

  @override
  Future<void> startOutgoingCall(CallSession call) async {}
}
