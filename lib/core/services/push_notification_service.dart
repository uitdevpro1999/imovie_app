import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:imovie_app/config/flavors/app_bootstrap.dart';
import 'package:imovie_app/core/events/app_auth_event.dart';
import 'package:imovie_app/core/events/app_event_bus.dart';
import 'package:imovie_app/core/events/app_notification_event.dart';
import 'package:imovie_app/core/logger/app_logger.dart';
import 'package:imovie_app/core/services/notification_navigation_service.dart';
import 'package:imovie_app/core/services/supabase_data_service.dart';

const AndroidNotificationChannel _communityNotificationChannel =
    AndroidNotificationChannel(
      'community_updates',
      'Community updates',
      description: 'Community activity and social updates.',
      importance: Importance.max,
    );

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }
    AppLogger.info(
      'Received background push ${message.messageId ?? '<unknown>'}.',
      name: 'PushNotification',
    );
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
  }) : _bootstrap = bootstrap,
       _dataService = dataService;

  final AppBootstrap _bootstrap;
  final SupabaseDataService _dataService;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final List<StreamSubscription<dynamic>> _subscriptions = [];

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

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    await _initializeLocalNotifications();
    await _requestPermission();

    _subscriptions.add(
      FirebaseMessaging.onMessage.listen(_handleForegroundMessage),
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
      android: AndroidInitializationSettings('app_icon'),
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
    } catch (error, stackTrace) {
      AppLogger.warning(
        'Push permission request failed.',
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
        'Synced FCM token for ${AppLogger.shortId(user.id)}.',
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
          icon: 'app_icon',
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

  void _handleNotificationResponse(NotificationResponse response) {
    appEventBus.emitNotification(AppNotificationEvent.changed());
    unawaited(
      NotificationNavigationService.openLocalNotificationResponse(response),
    );
  }

  Future<void> _handleInitialMessage() async {
    try {
      final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage == null) {
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
        blockedLogMessage: 'Push token request skipped because there is no active user.',
      );
      return true;
    } catch (_) {
      return false;
    }
  }
}

class NoOpPushNotificationService implements PushNotificationService {
  const NoOpPushNotificationService();

  @override
  Future<void> initialize() async {}
}
