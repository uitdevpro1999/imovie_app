import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';

part 'notification_center_state.freezed.dart';

@freezed
abstract class NotificationCenterState
    with _$NotificationCenterState
    implements BaseState {
  const NotificationCenterState._();

  const factory NotificationCenterState({
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    AppFailure? failure,
    @Default(0) int unreadCount,
  }) = _NotificationCenterState;

  @override
  NotificationCenterState copyWithBase({
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
