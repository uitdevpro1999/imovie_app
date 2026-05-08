import 'dart:async';

import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/events/app_auth_event.dart';
import 'package:imovie_app/core/events/app_event_bus.dart';
import 'package:imovie_app/core/events/app_notification_event.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/usecases/notification/get_unread_notification_count_use_case.dart';
import 'package:imovie_app/domain/usecases/notification/watch_notifications_use_case.dart';
import 'package:imovie_app/presentation/ui/notifications/notification_center_state.dart';

class NotificationCenterCubit extends BaseCubit<NotificationCenterState> {
  NotificationCenterCubit({
    required GetUnreadNotificationCountUseCase
    getUnreadNotificationCountUseCase,
    required WatchNotificationsUseCase watchNotificationsUseCase,
  }) : _getUnreadNotificationCountUseCase = getUnreadNotificationCountUseCase,
       _watchNotificationsUseCase = watchNotificationsUseCase,
       super(const NotificationCenterState());

  final GetUnreadNotificationCountUseCase _getUnreadNotificationCountUseCase;
  final WatchNotificationsUseCase _watchNotificationsUseCase;

  StreamSubscription<void>? _watchSubscription;
  StreamSubscription<AppNotificationEvent>? _notificationSubscription;
  StreamSubscription<AppAuthEvent>? _authSubscription;
  Timer? _watchDebounce;
  bool _initialized = false;
  bool _loading = false;

  @override
  Future<void> initData() async {
    initialize();
  }

  void initialize() {
    if (_initialized) {
      return;
    }

    _initialized = true;
    _notificationSubscription = appEventBus.notificationStream.listen(
      (_) => refresh(),
    );
    _authSubscription = appEventBus.authStream.listen((event) {
      switch (event.status) {
        case AppAuthEventStatus.authenticated:
          unawaited(refresh());
          break;
        case AppAuthEventStatus.unauthenticated:
          emit(
            state.copyWith(
              pageStatus: PageStatus.loaded,
              processing: false,
              failure: null,
              unreadCount: 0,
            ),
          );
          break;
      }
    });
    _watchSubscription = _watchNotificationsUseCase().listen(
      (_) => _scheduleNotificationBroadcast(),
    );
    unawaited(load());
  }

  Future<void> load() async {
    if (_loading) {
      return;
    }

    _loading = true;
    emit(
      state.copyWith(
        pageStatus: state.pageStatus == PageStatus.initial
            ? PageStatus.loading
            : state.pageStatus,
        processing: state.pageStatus != PageStatus.initial,
        failure: null,
      ),
    );

    final result = await _getUnreadNotificationCountUseCase(const NoParams());
    result.map(
      success: (count) {
        emit(
          state.copyWith(
            pageStatus: PageStatus.loaded,
            processing: false,
            failure: null,
            unreadCount: count < 0 ? 0 : count,
          ),
        );
      },
      failure: (failure) {
        emit(
          state.copyWith(
            pageStatus: state.pageStatus == PageStatus.initial
                ? PageStatus.error
                : PageStatus.loaded,
            processing: false,
            failure: failure,
          ),
        );
      },
    );
    _loading = false;
  }

  Future<void> refresh() => load();

  void _scheduleNotificationBroadcast() {
    _watchDebounce?.cancel();
    _watchDebounce = Timer(const Duration(milliseconds: 250), () {
      appEventBus.emitNotification(AppNotificationEvent.changed());
    });
  }

  @override
  Future<void> close() async {
    _watchDebounce?.cancel();
    await _watchSubscription?.cancel();
    await _notificationSubscription?.cancel();
    await _authSubscription?.cancel();
    return super.close();
  }
}
