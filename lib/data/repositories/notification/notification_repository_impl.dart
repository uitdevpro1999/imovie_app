import 'package:imovie_app/config/flavors/app_bootstrap.dart';
import 'package:imovie_app/core/error/app_exception.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/data/datasources/notification/notification_remote_data_source.dart';
import 'package:imovie_app/domain/entities/notification/community_notification.dart';
import 'package:imovie_app/domain/repositories/notification_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  const NotificationRepositoryImpl({
    required this.bootstrap,
    required this.remoteDataSource,
  });

  final AppBootstrap bootstrap;
  final NotificationRemoteDataSource remoteDataSource;

  @override
  Future<Result<List<CommunityNotification>>> getNotifications({
    required int page,
    required int limit,
  }) async {
    return _run(
      request: () async {
        final response = await remoteDataSource.getNotifications(
          page: page,
          limit: limit,
        );
        return response.map((item) => item.toEntity()).toList(growable: false);
      },
      authMessage: 'Unable to load notifications.',
      unknownMessage: 'Unexpected error while loading notifications.',
    );
  }

  @override
  Future<Result<int>> getUnreadCount() {
    return _run(
      request: remoteDataSource.getUnreadCount,
      authMessage: 'Unable to load unread notifications count.',
      unknownMessage:
          'Unexpected error while loading unread notifications count.',
    );
  }

  @override
  Future<Result<void>> markNotificationRead(String notificationId) {
    return _run(
      request: () => remoteDataSource.markNotificationRead(notificationId),
      authMessage: 'Unable to mark this notification as read.',
      unknownMessage:
          'Unexpected error while marking this notification as read.',
    );
  }

  @override
  Future<Result<void>> markAllNotificationsRead() {
    return _run(
      request: remoteDataSource.markAllNotificationsRead,
      authMessage: 'Unable to mark notifications as read.',
      unknownMessage: 'Unexpected error while marking notifications as read.',
    );
  }

  @override
  Stream<void> watchNotifications() {
    if (!bootstrap.isSupabaseReady) {
      return const Stream<void>.empty();
    }

    return remoteDataSource.watchNotifications();
  }

  Future<Result<T>> _run<T>({
    required Future<T> Function() request,
    required String authMessage,
    required String unknownMessage,
  }) async {
    if (!bootstrap.isSupabaseReady) {
      return FailureResult(
        AppFailure.configuration(
          'Supabase is not configured for notifications.',
        ),
      );
    }

    try {
      final value = await request();
      return Success(value);
    } on AppException catch (error) {
      return FailureResult(_mapFailure(error.failure, authMessage));
    } on AuthException catch (error) {
      return FailureResult(
        AppFailure.unauthorized(
          error.message.trim().isEmpty ? authMessage : error.message,
        ),
      );
    } catch (error) {
      return FailureResult(
        AppFailure.unknown(unknownMessage, details: error.toString()),
      );
    }
  }

  AppFailure _mapFailure(AppFailure failure, String fallbackMessage) {
    if (failure.message.trim().isNotEmpty) {
      return failure;
    }

    return AppFailure(
      type: failure.type,
      message: fallbackMessage,
      details: failure.details,
    );
  }
}
