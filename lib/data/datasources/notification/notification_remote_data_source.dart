import 'package:imovie_app/data/models/response/notification/community_notification_response.dart';
import 'package:imovie_app/core/services/supabase_data_service.dart';

abstract interface class NotificationRemoteDataSource {
  Future<List<CommunityNotificationResponse>> getNotifications({
    required int page,
    required int limit,
  });

  Future<int> getUnreadCount();

  Future<void> markNotificationRead(String notificationId);

  Future<void> markAllNotificationsRead();

  Stream<void> watchNotifications();
}

class SupabaseNotificationRemoteDataSource
    implements NotificationRemoteDataSource {
  const SupabaseNotificationRemoteDataSource({required this.dataService});

  static const _notificationsTable = 'community_notifications';

  final SupabaseDataService dataService;

  @override
  Future<List<CommunityNotificationResponse>> getNotifications({
    required int page,
    required int limit,
  }) async {
    final user = _currentUser();
    final normalizedPage = page < 1 ? 1 : page;
    final normalizedLimit = limit < 1 ? 1 : limit;
    final from = (normalizedPage - 1) * normalizedLimit;
    final to = from + normalizedLimit - 1;

    final rows = await dataService.selectList(
      table: _notificationsTable,
      equals: {'recipient_user_id': user.id},
      orderBy: 'created_at',
      ascending: false,
      rangeFrom: from,
      rangeTo: to,
    );

    return rows
        .map(CommunityNotificationResponse.fromJson)
        .toList(growable: false);
  }

  @override
  Future<int> getUnreadCount() async {
    final user = _currentUser();
    return dataService.count(
      table: _notificationsTable,
      equals: {'recipient_user_id': user.id, 'is_read': false},
    );
  }

  @override
  Future<void> markNotificationRead(String notificationId) {
    return dataService.rpc(
      function: 'mark_community_notification_read',
      params: {'target_notification_id': notificationId},
    );
  }

  @override
  Future<void> markAllNotificationsRead() {
    return dataService.rpc(function: 'mark_all_community_notifications_read');
  }

  @override
  Stream<void> watchNotifications() {
    final user = _currentUser();
    return dataService.watchTableChanges(
      table: _notificationsTable,
      filterColumn: 'recipient_user_id',
      filterValue: user.id,
    );
  }

  SupabaseDataUser _currentUser() {
    return dataService.requireCurrentUser(
      unauthorizedMessage: 'Unable to access notifications.',
      logName: 'Supabase.Notification',
      blockedLogMessage:
          'Notification request blocked because there is no active user.',
    );
  }
}
