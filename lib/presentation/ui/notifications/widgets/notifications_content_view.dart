import 'package:flutter/material.dart';
import 'package:imovie_app/domain/entities/notification/community_notification.dart';
import 'package:imovie_app/presentation/ui/notifications/widgets/notifications_card.dart';
import 'package:imovie_app/presentation/ui/notifications/widgets/notifications_empty_view.dart';
import 'package:imovie_app/presentation/widgets/imovie_smart_refresher.dart';

class NotificationsContentView extends StatelessWidget {
  const NotificationsContentView({
    super.key,
    required this.notifications,
    required this.emptyTitle,
    required this.emptySubtitle,
    required this.headerTitle,
    required this.headerSubtitle,
    required this.readAllLabel,
    required this.readAllEnabled,
    required this.readAllProcessing,
    required this.onRefresh,
    required this.onLoadMore,
    required this.hasMore,
    required this.onReadAllTap,
    required this.onItemTap,
    required this.timeLabelBuilder,
  });

  final List<CommunityNotification> notifications;
  final String emptyTitle;
  final String emptySubtitle;
  final String headerTitle;
  final String headerSubtitle;
  final String readAllLabel;
  final bool readAllEnabled;
  final bool readAllProcessing;
  final Future<bool> Function() onRefresh;
  final Future<IMovieLoadMoreResult> Function() onLoadMore;
  final bool hasMore;
  final ValueChanged<CommunityNotification> onItemTap;
  final VoidCallback onReadAllTap;
  final String Function(CommunityNotification notification) timeLabelBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
          child: _NotificationsHeader(
            title: headerTitle,
            subtitle: headerSubtitle,
            readAllLabel: readAllLabel,
            readAllEnabled: readAllEnabled,
            readAllProcessing: readAllProcessing,
            onReadAllTap: onReadAllTap,
          ),
        ),
        Expanded(
          child: IMovieSmartRefresher(
            onRefresh: onRefresh,
            onLoadMore: onLoadMore,
            enablePullUp: notifications.isNotEmpty,
            hasMore: notifications.isNotEmpty && hasMore,
            child: notifications.isEmpty
                ? LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: NotificationsEmptyView(
                            title: emptyTitle,
                            subtitle: emptySubtitle,
                          ),
                        ),
                      );
                    },
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    itemBuilder: (context, index) {
                      final notification = notifications[index];
                      return NotificationsCard(
                        notification: notification,
                        timeLabel: timeLabelBuilder(notification),
                        onTap: () => onItemTap(notification),
                      );
                    },
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemCount: notifications.length,
                  ),
          ),
        ),
      ],
    );
  }
}

class _NotificationsHeader extends StatelessWidget {
  const _NotificationsHeader({
    required this.title,
    required this.subtitle,
    required this.readAllLabel,
    required this.readAllEnabled,
    required this.readAllProcessing,
    required this.onReadAllTap,
  });

  final String title;
  final String subtitle;
  final String readAllLabel;
  final bool readAllEnabled;
  final bool readAllProcessing;
  final VoidCallback onReadAllTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(color: Color(0xFFB3B3B3), fontSize: 13),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: readAllEnabled && !readAllProcessing ? onReadAllTap : null,
          child: readAllProcessing
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(readAllLabel),
        ),
      ],
    );
  }
}
