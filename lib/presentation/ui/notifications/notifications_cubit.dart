import 'dart:async';

import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/events/app_event_bus.dart';
import 'package:imovie_app/core/events/app_notification_event.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/notification/community_notification.dart';
import 'package:imovie_app/domain/usecases/notification/get_notifications_use_case.dart';
import 'package:imovie_app/domain/usecases/notification/mark_all_notifications_read_use_case.dart';
import 'package:imovie_app/domain/usecases/notification/mark_notification_read_use_case.dart';
import 'package:imovie_app/presentation/ui/notifications/notifications_state.dart';

class NotificationsCubit extends BaseCubit<NotificationsState> {
  NotificationsCubit({
    required GetNotificationsUseCase getNotificationsUseCase,
    required MarkNotificationReadUseCase markNotificationReadUseCase,
    required MarkAllNotificationsReadUseCase markAllNotificationsReadUseCase,
  }) : _getNotificationsUseCase = getNotificationsUseCase,
       _markNotificationReadUseCase = markNotificationReadUseCase,
       _markAllNotificationsReadUseCase = markAllNotificationsReadUseCase,
       super(const NotificationsState()) {
    _notificationSubscription = appEventBus.notificationStream.listen(
      (_) => refresh(),
    );
  }

  static const _initialPage = 1;

  final GetNotificationsUseCase _getNotificationsUseCase;
  final MarkNotificationReadUseCase _markNotificationReadUseCase;
  final MarkAllNotificationsReadUseCase _markAllNotificationsReadUseCase;
  late final StreamSubscription<AppNotificationEvent> _notificationSubscription;

  @override
  Future<void> initData() async {
    await load();
  }

  Future<bool> load({bool showLoading = true}) async {
    if (showLoading) {
      emit(
        state.copyWith(
          pageStatus: state.notifications.isEmpty
              ? PageStatus.loading
              : PageStatus.loaded,
          processing: state.notifications.isNotEmpty,
          failure: null,
        ),
      );
    } else {
      emit(state.copyWith(failure: null));
    }

    final result = await _getNotificationsUseCase(
      GetNotificationsParams(page: _initialPage, limit: state.pageSize),
    );
    return result.map(
      success: (notifications) {
        emit(
          state.copyWith(
            pageStatus: PageStatus.loaded,
            processing: false,
            failure: null,
            notifications: notifications,
            page: _initialPage,
            hasMore: notifications.length == state.pageSize,
            loadingMore: false,
          ),
        );
        return true;
      },
      failure: (failure) {
        emit(
          state.copyWith(
            pageStatus: showLoading && state.notifications.isEmpty
                ? PageStatus.error
                : PageStatus.loaded,
            processing: false,
            failure: failure,
            loadingMore: false,
          ),
        );
        showFailureToast(failure);
        return false;
      },
    );
  }

  Future<bool> refresh() => load(showLoading: false);

  Future<bool> loadMore() async {
    if (state.loadingMore || !state.hasMore) {
      return true;
    }

    final nextPage = state.page + 1;
    emit(state.copyWith(loadingMore: true, failure: null));
    final result = await _getNotificationsUseCase(
      GetNotificationsParams(page: nextPage, limit: state.pageSize),
    );

    return result.map(
      success: (notifications) {
        final existingIds = state.notifications.map((item) => item.id).toSet();
        final nextItems = notifications
            .where((item) => !existingIds.contains(item.id))
            .toList(growable: false);
        emit(
          state.copyWith(
            notifications: [...state.notifications, ...nextItems],
            page: nextPage,
            hasMore: notifications.length == state.pageSize,
            loadingMore: false,
            failure: null,
          ),
        );
        return true;
      },
      failure: (failure) {
        emit(state.copyWith(loadingMore: false, failure: failure));
        showFailureToast(failure);
        return false;
      },
    );
  }

  Future<void> markAsRead(CommunityNotification notification) async {
    if (notification.isRead) {
      return;
    }

    _replaceNotification(notification.copyWith(isRead: true));
    final result = await _markNotificationReadUseCase(
      MarkNotificationReadParams(notificationId: notification.id),
    );
    result.map(
      success: (_) {
        appEventBus.emitNotification(AppNotificationEvent.changed());
      },
      failure: (failure) {
        _replaceNotification(notification);
        showFailureToast(failure);
      },
    );
  }

  Future<void> markAllAsRead() async {
    if (state.readAllProcessing || state.unreadCount == 0) {
      return;
    }

    final previousItems = state.notifications;
    final optimisticItems = previousItems
        .map((item) => item.isRead ? item : item.copyWith(isRead: true))
        .toList(growable: false);
    emit(
      state.copyWith(
        readAllProcessing: true,
        notifications: optimisticItems,
        failure: null,
      ),
    );

    final result = await _markAllNotificationsReadUseCase(const NoParams());
    result.map(
      success: (_) {
        emit(state.copyWith(readAllProcessing: false));
        appEventBus.emitNotification(AppNotificationEvent.changed());
      },
      failure: (failure) {
        emit(
          state.copyWith(
            readAllProcessing: false,
            notifications: previousItems,
            failure: failure,
          ),
        );
        showFailureToast(failure);
      },
    );
  }

  void _replaceNotification(CommunityNotification notification) {
    final nextItems = state.notifications
        .map((item) => item.id == notification.id ? notification : item)
        .toList(growable: false);
    emit(state.copyWith(notifications: nextItems));
  }

  @override
  Future<void> close() async {
    await _notificationSubscription.cancel();
    return super.close();
  }
}
