import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/domain/entities/notification/community_notification.dart';

abstract interface class NotificationRepository {
  Future<Result<List<CommunityNotification>>> getNotifications({
    required int page,
    required int limit,
  });

  Future<Result<int>> getUnreadCount();

  Future<Result<void>> markNotificationRead(String notificationId);

  Future<Result<void>> markAllNotificationsRead();

  Stream<void> watchNotifications();
}
