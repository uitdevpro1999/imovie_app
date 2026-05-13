import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/core/logger/app_logger.dart';
import 'package:imovie_app/domain/usecases/call/get_call_use_case.dart';
import 'package:imovie_app/domain/entities/notification/community_notification.dart';

class NotificationNavigationService {
  const NotificationNavigationService._();

  static Future<void> openCommunityNotification(
    CommunityNotification notification,
  ) {
    return _openByEntity(
      entityType: notification.entityType,
      entityId: notification.entityId,
    );
  }

  static Future<void> openRemoteMessage(RemoteMessage message) {
    return _openFromData(message.data);
  }

  static Future<void> openLocalNotificationResponse(
    NotificationResponse response,
  ) async {
    final rawPayload = response.payload?.trim() ?? '';
    if (rawPayload.isEmpty) {
      return;
    }

    try {
      final payload = jsonDecode(rawPayload);
      if (payload is Map<String, dynamic>) {
        await _openFromData(payload);
      }
    } catch (error, stackTrace) {
      AppLogger.warning(
        'Unable to decode local notification payload.',
        name: 'NotificationNavigation',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  static Future<void> _openFromData(Map<String, dynamic> data) {
    final rawEntityType =
        data['entityType']?.toString() ?? data['entity_type']?.toString() ?? '';
    final entityId =
        data['entityId']?.toString() ?? data['entity_id']?.toString() ?? '';
    final entityType = switch (rawEntityType.trim()) {
      'story' => CommunityNotificationEntityType.story,
      'profile' => CommunityNotificationEntityType.profile,
      'chat' => CommunityNotificationEntityType.chat,
      'call' => CommunityNotificationEntityType.call,
      _ => CommunityNotificationEntityType.post,
    };
    return _openByEntity(entityType: entityType, entityId: entityId);
  }

  static Future<void> _openByEntity({
    required CommunityNotificationEntityType entityType,
    required String entityId,
  }) async {
    final normalizedEntityId = entityId.trim();
    if (normalizedEntityId.isEmpty) {
      return;
    }

    if (entityType == CommunityNotificationEntityType.call) {
      await _openCall(normalizedEntityId);
      return;
    }

    switch (entityType) {
      case CommunityNotificationEntityType.post:
        await _openFromHome(
          CommunityPostDetailRoute(postId: normalizedEntityId),
        );
        break;
      case CommunityNotificationEntityType.story:
        await _openFromHome(
          CommunityStoryViewerRoute(storyId: normalizedEntityId),
        );
        break;
      case CommunityNotificationEntityType.profile:
        await _openFromHome(CommunityProfileRoute(userId: normalizedEntityId));
        break;
      case CommunityNotificationEntityType.chat:
        await _openFromHome(
          ChatThreadRoute(
            conversationId: normalizedEntityId,
            title: 'Tin nhắn',
            avatarUrl: '',
          ),
        );
        break;
      case CommunityNotificationEntityType.call:
        break;
    }
  }

  static Future<void> _openFromHome(PageRouteInfo route) async {
    if (appRouter.current.name != MainRoute.name) {
      await appRouter.replaceAll([const MainRoute()]);
      await Future<void>.delayed(Duration.zero);
    }
    await appRouter.push(route);
  }

  static Future<void> _openCall(String callId) async {
    if (appRouter.current.name == ActiveCallRoute.name) {
      return;
    }

    final result = await sl<GetCallUseCase>()(GetCallParams(callId: callId));
    await result.map(
      success: (call) async {
        if (call.isFinished) {
          return;
        }
        await _openFromHome(ActiveCallRoute(call: call));
      },
      failure: (failure) async {
        AppLogger.warning(
          'Unable to open call notification: ${failure.message}',
          name: 'NotificationNavigation',
        );
      },
    );
  }
}
