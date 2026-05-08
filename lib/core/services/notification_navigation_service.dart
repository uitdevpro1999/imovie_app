import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/core/logger/app_logger.dart';
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

    if (appRouter.current.name != MainRoute.name) {
      appRouter.replaceAll([const MainRoute()]);
    }

    switch (entityType) {
      case CommunityNotificationEntityType.post:
        await appRouter.push(CommunityPostDetailRoute(postId: normalizedEntityId));
        break;
      case CommunityNotificationEntityType.story:
        await appRouter.push(
          CommunityStoryViewerRoute(storyId: normalizedEntityId),
        );
        break;
      case CommunityNotificationEntityType.profile:
        await appRouter.push(
          CommunityProfileRoute(userId: normalizedEntityId),
        );
        break;
    }
  }
}
