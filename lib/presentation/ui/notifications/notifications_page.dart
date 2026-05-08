import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/core/services/notification_navigation_service.dart';
import 'package:imovie_app/domain/entities/notification/community_notification.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/common/pages/base_page.dart';
import 'package:imovie_app/presentation/ui/notifications/notifications_cubit.dart';
import 'package:imovie_app/presentation/ui/notifications/notifications_state.dart';
import 'package:imovie_app/presentation/ui/notifications/widgets/notifications_content_view.dart';
import 'package:imovie_app/presentation/widgets/imovie_app_bar.dart';
import 'package:imovie_app/presentation/widgets/imovie_smart_refresher.dart';

@RoutePage()
class NotificationsPage extends BasePage<NotificationsCubit, NotificationsState>
    implements AutoRouteWrapper {
  const NotificationsPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (_) => sl<NotificationsCubit>(), child: this);
  }

  @override
  Widget wrapPage(
    BuildContext context,
    NotificationsState state,
    Widget child,
  ) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.grayscale950,
      appBar: IMovieAppBar(title: l10n.notificationsTitle),
      body: SafeArea(child: child),
    );
  }

  @override
  Widget buildPage(
    BuildContext context,
    NotificationsCubit cubit,
    NotificationsState state,
  ) {
    final l10n = AppLocalizations.of(context)!;
    return NotificationsContentView(
      notifications: state.notifications,
      emptyTitle: l10n.notificationsEmptyTitle,
      emptySubtitle: l10n.notificationsEmptySubtitle,
      headerTitle: l10n.notificationsHeaderTitle(state.unreadCount),
      headerSubtitle: l10n.notificationsHeaderSubtitle,
      readAllLabel: l10n.notificationsReadAll,
      readAllEnabled: state.unreadCount > 0,
      readAllProcessing: state.readAllProcessing,
      hasMore: state.hasMore,
      onRefresh: cubit.refresh,
      onLoadMore: () async {
        final success = await cubit.loadMore();
        return success
            ? IMovieLoadMoreResult.success(hasMore: cubit.state.hasMore)
            : const IMovieLoadMoreResult.failure();
      },
      onReadAllTap: cubit.markAllAsRead,
      onItemTap: (notification) async {
        await cubit.markAsRead(notification);
        await NotificationNavigationService.openCommunityNotification(
          notification,
        );
      },
      timeLabelBuilder: _timeLabel,
    );
  }

  String _timeLabel(CommunityNotification notification) {
    final createdAt = notification.createdAt;
    if (createdAt == null) {
      return '';
    }

    final diff = DateTime.now().difference(createdAt.toLocal());
    if (diff.inMinutes < 1) {
      return 'Vừa xong';
    }
    if (diff.inHours < 1) {
      return '${diff.inMinutes}m';
    }
    if (diff.inDays < 1) {
      return '${diff.inHours}h';
    }
    if (diff.inDays < 7) {
      return '${diff.inDays}d';
    }

    final day = createdAt.day.toString().padLeft(2, '0');
    final month = createdAt.month.toString().padLeft(2, '0');
    final year = createdAt.year.toString();
    return '$day/$month/$year';
  }

  @override
  Widget buildError(
    BuildContext context,
    AppLocalizations l10n,
    String message,
    VoidCallback onRetry,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          message.isEmpty ? l10n.notificationsLoadError : message,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
