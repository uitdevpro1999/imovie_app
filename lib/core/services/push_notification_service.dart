import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/services.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:imovie_app/config/flavors/app_bootstrap.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/core/services/call/callkit_service.dart';
import 'package:imovie_app/core/events/app_auth_event.dart';
import 'package:imovie_app/core/events/app_event_bus.dart';
import 'package:imovie_app/core/events/app_notification_event.dart';
import 'package:imovie_app/core/logger/app_logger.dart';
import 'package:imovie_app/core/services/notification_navigation_service.dart';
import 'package:imovie_app/core/services/supabase_data_service.dart';
import 'package:imovie_app/domain/entities/call/call_session.dart';
import 'package:imovie_app/domain/usecases/call/answer_call_use_case.dart';
import 'package:imovie_app/domain/usecases/call/decline_call_use_case.dart';

const AndroidNotificationChannel _communityNotificationChannel =
    AndroidNotificationChannel(
      'community_updates_v2',
      'Community updates',
      description: 'Community activity and social updates.',
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
    );

const MethodChannel _androidCallkitLaunchChannel = MethodChannel(
  'imovie_app/android_callkit_launch',
);

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    DartPluginRegistrant.ensureInitialized();
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }
    AppLogger.info(
      'Received background push ${message.messageId ?? '<unknown>'}.',
      name: 'PushNotification',
    );
    final endedCallId = _endedCallIdFromRemoteMessage(message);
    if (endedCallId.isNotEmpty) {
      await const FlutterIncomingCallkitService().endCall(endedCallId);
      await _showBackgroundLocalNotification(message);
      return;
    }

    final incomingCall = _callFromRemoteMessage(message);
    if (incomingCall != null) {
      await const FlutterIncomingCallkitService().showIncomingCall(
        incomingCall,
      );
    }
  } catch (error, stackTrace) {
    AppLogger.warning(
      'Background push handler failed to initialize Firebase.',
      name: 'PushNotification',
      error: error,
      stackTrace: stackTrace,
    );
  }
}

abstract interface class PushNotificationService {
  Future<void> initialize();
}

class DevicePushNotificationService implements PushNotificationService {
  DevicePushNotificationService({
    required AppBootstrap bootstrap,
    required SupabaseDataService dataService,
    required CallkitService callkitService,
    required AnswerCallUseCase answerCallUseCase,
    required DeclineCallUseCase declineCallUseCase,
  }) : _bootstrap = bootstrap,
       _dataService = dataService,
       _callkitService = callkitService,
       _answerCallUseCase = answerCallUseCase,
       _declineCallUseCase = declineCallUseCase;

  final AppBootstrap _bootstrap;
  final SupabaseDataService _dataService;
  final CallkitService _callkitService;
  final AnswerCallUseCase _answerCallUseCase;
  final DeclineCallUseCase _declineCallUseCase;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final List<StreamSubscription<dynamic>> _subscriptions = [];
  final Set<String> _answeringCallIds = {};
  final Set<String> _decliningCallIds = {};

  bool _initialized = false;
  bool _firebaseReady = false;

  @override
  Future<void> initialize() async {
    if (_initialized) {
      return;
    }
    _initialized = true;

    if (kIsWeb || !(Platform.isAndroid || Platform.isIOS)) {
      AppLogger.info(
        'Push setup skipped for unsupported platform.',
        name: 'PushNotification',
      );
      return;
    }

    _firebaseReady = await _initializeFirebase();
    if (!_firebaseReady) {
      return;
    }

    await _initializeLocalNotifications();
    await _requestPermission();
    await _requestAndroidCallPermissions();

    _subscriptions.add(
      FirebaseMessaging.onMessage.listen(_handleForegroundMessage),
    );
    _subscriptions.add(
      _callkitService.events.listen(
        (event) => unawaited(_handleCallkitEvent(event)),
      ),
    );
    _subscriptions.add(
      FirebaseMessaging.onMessageOpenedApp.listen(
        NotificationNavigationService.openRemoteMessage,
      ),
    );
    _subscriptions.add(
      FirebaseMessaging.instance.onTokenRefresh.listen(
        (token) => unawaited(_syncToken(token)),
      ),
    );
    _subscriptions.add(
      appEventBus.authStream.listen((event) {
        switch (event.status) {
          case AppAuthEventStatus.authenticated:
            unawaited(syncCurrentToken());
            break;
          case AppAuthEventStatus.unauthenticated:
            break;
        }
      }),
    );

    unawaited(syncCurrentToken());
    unawaited(_handleInitialMessage());
    unawaited(_handleInitialAndroidCallkitAction());
  }

  Future<bool> _initializeFirebase() async {
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
      }
      AppLogger.info('Firebase initialized.', name: 'PushNotification');
      return true;
    } catch (error, stackTrace) {
      AppLogger.warning(
        'Firebase initialization skipped. Add native Firebase config to enable push.',
        name: 'PushNotification',
        error: error,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  Future<void> _initializeLocalNotifications() async {
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('ic_stat_notification'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        defaultPresentAlert: true,
        defaultPresentBadge: true,
        defaultPresentBanner: true,
        defaultPresentList: true,
        defaultPresentSound: true,
      ),
    );

    await _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _handleNotificationResponse,
    );

    final androidPlugin = _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await androidPlugin?.createNotificationChannel(
      _communityNotificationChannel,
    );
  }

  Future<void> _requestPermission() async {
    try {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
            alert: true,
            badge: true,
            sound: true,
          );
      final settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );
      AppLogger.info(
        'Push permission status: ${settings.authorizationStatus.name}.',
        name: 'PushNotification',
      );
      await _requestAndroidNotificationPermission();
    } catch (error, stackTrace) {
      AppLogger.warning(
        'Push permission request failed.',
        name: 'PushNotification',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> _requestAndroidNotificationPermission() async {
    if (!Platform.isAndroid) {
      return;
    }

    try {
      final androidPlugin = _localNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      final granted = await androidPlugin?.requestNotificationsPermission();
      final enabled = await androidPlugin?.areNotificationsEnabled();
      AppLogger.info(
        'Android notification permission granted=$granted enabled=$enabled.',
        name: 'PushNotification',
      );
    } catch (error, stackTrace) {
      AppLogger.warning(
        'Android notification permission check failed.',
        name: 'PushNotification',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> _requestAndroidCallPermissions() async {
    if (!Platform.isAndroid) {
      return;
    }

    try {
      await _callkitService.requestAndroidNotificationPermission();
    } catch (error, stackTrace) {
      AppLogger.warning(
        'Android call permission request failed.',
        name: 'PushNotification',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> syncCurrentToken() async {
    if (!_firebaseReady || !_bootstrap.isSupabaseReady || !_hasActiveUser) {
      return;
    }

    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token == null || token.trim().isEmpty) {
        AppLogger.warning(
          'FCM token is empty. Skipping token sync.',
          name: 'PushNotification',
        );
        return;
      }

      await _syncToken(token);
    } catch (error, stackTrace) {
      AppLogger.warning(
        'FCM token retrieval failed. Firebase Installations or Play Services may be unavailable.',
        name: 'PushNotification',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> _syncToken(String token) async {
    if (!_firebaseReady || !_bootstrap.isSupabaseReady || !_hasActiveUser) {
      return;
    }

    final normalizedToken = token.trim();
    if (normalizedToken.isEmpty) {
      return;
    }

    try {
      final user = _dataService.requireCurrentUser(
        unauthorizedMessage: 'Unable to register push token.',
        logName: 'PushNotification',
        blockedLogMessage:
            'Push token sync skipped because there is no active user.',
      );
      await _dataService.rpc(
        function: 'upsert_user_push_token',
        params: {
          'target_token': normalizedToken,
          'target_platform': _platformName,
          'target_device_name': _deviceName,
          'target_locale_code': PlatformDispatcher.instance.locale.languageCode,
        },
      );
      AppLogger.info(
        'Synced FCM token ${AppLogger.shortId(normalizedToken)} for ${AppLogger.shortId(user.id)} on $_platformName.',
        name: 'PushNotification',
      );
    } catch (error, stackTrace) {
      AppLogger.warning(
        'Push token sync failed.',
        name: 'PushNotification',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    appEventBus.emitNotification(AppNotificationEvent.changed());

    final endedCallId = _endedCallIdFromRemoteMessage(message);
    if (endedCallId.isNotEmpty) {
      await _callkitService.endCall(endedCallId);
    }

    final incomingCall = _callFromRemoteMessage(message);
    if (incomingCall != null) {
      await _callkitService.showIncomingCall(incomingCall);
      return;
    }

    final title = _resolveTitle(message);
    final body = _resolveBody(message);
    if (title.isEmpty && body.isEmpty) {
      return;
    }

    final metadata = <String, Object?>{
      'notificationId': message.data['notificationId'],
      'entityType': message.data['entityType'],
      'entityId': message.data['entityId'],
      'notificationType': message.data['notificationType'],
    };

    await _localNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _communityNotificationChannel.id,
          _communityNotificationChannel.name,
          channelDescription: _communityNotificationChannel.description,
          importance: Importance.max,
          priority: Priority.high,
          visibility: NotificationVisibility.public,
          icon: 'ic_stat_notification',
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentBanner: true,
          presentList: true,
          presentSound: true,
        ),
      ),
      payload: jsonEncode(metadata),
    );
  }

  Future<void> _handleCallkitEvent(CallEvent? event) async {
    if (event == null) {
      return;
    }

    switch (event.event) {
      case Event.actionCallAccept:
        await _handleCallkitAccept(event.body);
        break;
      case Event.actionCallDecline:
      case Event.actionCallTimeout:
        await _handleCallkitDecline(event.body);
        break;
      case Event.actionCallIncoming:
      case Event.actionCallStart:
      case Event.actionCallEnded:
      case Event.actionCallConnected:
      case Event.actionCallCallback:
      case Event.actionCallToggleHold:
      case Event.actionCallToggleMute:
      case Event.actionCallToggleDmtf:
      case Event.actionCallToggleGroup:
      case Event.actionCallToggleAudioSession:
      case Event.actionDidUpdateDevicePushTokenVoip:
      case Event.actionCallCustom:
        break;
    }
  }

  Future<void> _handleCallkitAccept(dynamic body) async {
    final callId = _callIdFromCallkitBody(body);
    if (callId.isEmpty || !_answeringCallIds.add(callId)) {
      return;
    }

    AppLogger.info(
      'Accepting call from CallKit ${AppLogger.shortId(callId)}.',
      name: 'PushNotification',
    );
    final result = await _answerCallUseCase(AnswerCallParams(callId: callId));
    await result.map(
      success: (call) async {
        await _callkitService.setCallConnected(call.id);
        await _openActiveCall(call);
      },
      failure: (failure) async {
        AppLogger.warning(
          'Unable to accept CallKit call: ${failure.message}',
          name: 'PushNotification',
        );
        _answeringCallIds.remove(callId);
      },
    );
  }

  Future<void> _handleCallkitDecline(dynamic body) async {
    final callId = _callIdFromCallkitBody(body);
    if (callId.isEmpty || !_decliningCallIds.add(callId)) {
      return;
    }

    final result = await _declineCallUseCase(DeclineCallParams(callId: callId));
    result.map(
      success: (_) {},
      failure: (failure) {
        AppLogger.warning(
          'Unable to decline CallKit call: ${failure.message}',
          name: 'PushNotification',
        );
        _decliningCallIds.remove(callId);
      },
    );
  }

  Future<void> _openActiveCall(CallSession call) async {
    if (call.isFinished) {
      return;
    }
    if (appRouter.current.name == ActiveCallRoute.name) {
      return;
    }
    if (appRouter.current.name != MainRoute.name) {
      appRouter.replaceAll([const MainRoute()]);
    }
    await appRouter.push(ActiveCallRoute(call: call));
  }

  void _handleNotificationResponse(NotificationResponse response) {
    appEventBus.emitNotification(AppNotificationEvent.changed());
    unawaited(
      NotificationNavigationService.openLocalNotificationResponse(response),
    );
  }

  Future<void> _handleInitialMessage() async {
    try {
      final initialMessage = await FirebaseMessaging.instance
          .getInitialMessage();
      if (initialMessage == null) {
        return;
      }

      final endedCallId = _endedCallIdFromRemoteMessage(initialMessage);
      if (endedCallId.isNotEmpty) {
        await _callkitService.endCall(endedCallId);
      }

      final incomingCall = _callFromRemoteMessage(initialMessage);
      if (incomingCall != null) {
        await _callkitService.showIncomingCall(incomingCall);
        return;
      }

      await NotificationNavigationService.openRemoteMessage(initialMessage);
    } catch (error, stackTrace) {
      AppLogger.warning(
        'Unable to resolve initial push message.',
        name: 'PushNotification',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> _handleInitialAndroidCallkitAction() async {
    if (!Platform.isAndroid) {
      return;
    }

    try {
      final action = await _androidCallkitLaunchChannel
          .invokeMapMethod<String, dynamic>('takeInitialAction');
      if (action == null) {
        return;
      }

      final event = action['event']?.toString() ?? '';
      final body = action['body'];
      switch (event) {
        case 'accept':
          await _handleCallkitAccept(body);
          break;
        case 'decline':
        case 'timeout':
          await _handleCallkitDecline(body);
          break;
      }
    } catch (error, stackTrace) {
      AppLogger.warning(
        'Unable to resolve initial Android CallKit action.',
        name: 'PushNotification',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  String _resolveTitle(RemoteMessage message) {
    return _trimmed(
      message.notification?.title,
      message.data['title']?.toString(),
    );
  }

  String _resolveBody(RemoteMessage message) {
    return _trimmed(
      message.notification?.body,
      message.data['body']?.toString(),
    );
  }

  String _trimmed(String? first, [String? second]) {
    final values = [first, second];
    for (final value in values) {
      final normalized = value?.trim() ?? '';
      if (normalized.isNotEmpty) {
        return normalized;
      }
    }
    return '';
  }

  String get _platformName {
    if (Platform.isIOS) {
      return 'ios';
    }
    if (Platform.isAndroid) {
      return 'android';
    }
    return 'unknown';
  }

  String get _deviceName {
    if (Platform.isIOS) {
      return 'iOS';
    }
    if (Platform.isAndroid) {
      return 'Android';
    }
    return Platform.operatingSystem;
  }

  bool get _hasActiveUser {
    try {
      _dataService.requireCurrentUser(
        unauthorizedMessage: 'Unable to access current user.',
        logName: 'PushNotification',
        blockedLogMessage:
            'Push token request skipped because there is no active user.',
      );
      return true;
    } catch (_) {
      return false;
    }
  }
}

Future<void> _showBackgroundLocalNotification(RemoteMessage message) async {
  final title = _notificationTitle(message);
  final body = _notificationBody(message);
  if (title.isEmpty && body.isEmpty) {
    return;
  }

  final plugin = FlutterLocalNotificationsPlugin();
  const initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('ic_stat_notification'),
    iOS: DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    ),
  );
  await plugin.initialize(initializationSettings);

  final androidPlugin = plugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >();
  await androidPlugin?.createNotificationChannel(_communityNotificationChannel);

  final metadata = <String, Object?>{
    'notificationId': message.data['notificationId'],
    'entityType': message.data['entityType'],
    'entityId': message.data['entityId'],
    'notificationType': message.data['notificationType'],
  };

  await plugin.show(
    DateTime.now().millisecondsSinceEpoch ~/ 1000,
    title,
    body,
    NotificationDetails(
      android: AndroidNotificationDetails(
        _communityNotificationChannel.id,
        _communityNotificationChannel.name,
        channelDescription: _communityNotificationChannel.description,
        importance: Importance.max,
        priority: Priority.high,
        visibility: NotificationVisibility.public,
        icon: 'ic_stat_notification',
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentBanner: true,
        presentList: true,
        presentSound: true,
      ),
    ),
    payload: jsonEncode(metadata),
  );
}

String _callIdFromCallkitBody(dynamic body) {
  if (body is! Map) {
    return '';
  }

  final directId = body['id']?.toString().trim() ?? '';
  if (directId.isNotEmpty) {
    return directId;
  }

  final extra = body['extra'];
  if (extra is Map) {
    return extra['callId']?.toString().trim() ??
        extra['call_id']?.toString().trim() ??
        '';
  }

  return '';
}

String _endedCallIdFromRemoteMessage(RemoteMessage message) {
  final data = message.data;
  final notificationType =
      data['notificationType']?.toString() ??
      data['notification_type']?.toString() ??
      '';
  if (notificationType != 'call_ended' &&
      notificationType != 'call_declined' &&
      notificationType != 'missed_call') {
    return '';
  }

  return (data['callId']?.toString() ??
          data['call_id']?.toString() ??
          data['entityId']?.toString() ??
          data['entity_id']?.toString() ??
          '')
      .trim();
}

String _notificationTitle(RemoteMessage message) {
  return _firstNonEmpty(
    message.notification?.title,
    message.data['title']?.toString(),
  );
}

String _notificationBody(RemoteMessage message) {
  return _firstNonEmpty(
    message.notification?.body,
    message.data['body']?.toString(),
  );
}

String _firstNonEmpty(String? first, [String? second]) {
  for (final value in [first, second]) {
    final normalized = value?.trim() ?? '';
    if (normalized.isNotEmpty) {
      return normalized;
    }
  }
  return '';
}

CallSession? _callFromRemoteMessage(RemoteMessage message) {
  final data = message.data;
  final notificationType =
      data['notificationType']?.toString() ??
      data['notification_type']?.toString() ??
      '';
  if (notificationType != 'incoming_call') {
    return null;
  }

  final callId =
      data['callId']?.toString() ??
      data['call_id']?.toString() ??
      data['entityId']?.toString() ??
      data['entity_id']?.toString() ??
      '';
  final conversationId =
      data['conversationId']?.toString() ??
      data['conversation_id']?.toString() ??
      '';
  if (callId.trim().isEmpty) {
    return null;
  }

  final callerName =
      data['callerName']?.toString() ??
      data['actorName']?.toString() ??
      data['actor_name']?.toString() ??
      message.notification?.title ??
      'iMovie user';
  final callerAvatarUrl =
      data['callerAvatarUrl']?.toString() ??
      data['actorAvatarUrl']?.toString() ??
      data['actor_avatar_url']?.toString() ??
      data['imageUrl']?.toString() ??
      data['image_url']?.toString() ??
      '';

  return CallSession(
    id: callId,
    conversationId: conversationId,
    callerId:
        data['callerId']?.toString() ??
        data['caller_id']?.toString() ??
        data['actorId']?.toString() ??
        data['actor_id']?.toString() ??
        '',
    callerName: callerName,
    callerAvatarUrl: callerAvatarUrl,
    displayName: data['displayName']?.toString() ?? callerName,
    displayAvatarUrl:
        data['displayAvatarUrl']?.toString() ??
        data['display_avatar_url']?.toString() ??
        callerAvatarUrl,
    type:
        (data['callType']?.toString() ?? data['call_type']?.toString()) ==
            'video'
        ? CallType.video
        : CallType.audio,
    status: CallStatus.ringing,
    agoraChannel:
        data['agoraChannel']?.toString() ??
        data['agora_channel']?.toString() ??
        '',
    agoraUid: int.tryParse(data['agoraUid']?.toString() ?? '') ?? 0,
    agoraToken: data['agoraToken']?.toString() ?? '',
    startedAt: DateTime.tryParse(data['startedAt']?.toString() ?? ''),
    acceptedAt: null,
    endedAt: null,
  );
}

class NoOpPushNotificationService implements PushNotificationService {
  const NoOpPushNotificationService();

  @override
  Future<void> initialize() async {}
}
