import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imovie_app/config/refresh/imovie_refresh_config.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/domain/entities/notification/community_notification.dart';

part 'notifications_state.freezed.dart';

@freezed
abstract class NotificationsState
    with _$NotificationsState
    implements BaseState {
  const NotificationsState._();

  const factory NotificationsState({
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    AppFailure? failure,
    @Default(<CommunityNotification>[])
    List<CommunityNotification> notifications,
    @Default(1) int page,
    @Default(IMovieRefreshConfig.communityPageSize) int pageSize,
    @Default(true) bool hasMore,
    @Default(false) bool loadingMore,
    @Default(false) bool readAllProcessing,
  }) = _NotificationsState;

  int get unreadCount =>
      notifications.where((notification) => notification.isUnread).length;

  @override
  NotificationsState copyWithBase({
    PageStatus? pageStatus,
    bool? processing,
    AppFailure? failure,
    bool clearFailure = false,
  }) {
    return copyWith(
      pageStatus: pageStatus ?? this.pageStatus,
      processing: processing ?? this.processing,
      failure: clearFailure ? null : failure ?? this.failure,
    );
  }
}
