import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/domain/entities/notification/community_notification.dart';
import 'package:imovie_app/presentation/widgets/imovie_remote_image.dart';

class NotificationsCard extends StatelessWidget {
  const NotificationsCard({
    super.key,
    required this.notification,
    required this.timeLabel,
    required this.onTap,
  });

  final CommunityNotification notification;
  final String timeLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final style = _NotificationStyle.fromType(notification.type);

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          decoration: BoxDecoration(
            color: notification.isUnread
                ? AppColors.grayscale900
                : AppColors.grayscale950,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: notification.isUnread
                  ? style.color.withValues(alpha: 0.22)
                  : AppColors.grayscale800,
            ),
            boxShadow: notification.isUnread
                ? [
                    BoxShadow(
                      color: style.color.withValues(alpha: 0.08),
                      blurRadius: 18,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    _NotificationAvatar(notification: notification),
                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: style.color,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.grayscale950,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          style.icon,
                          size: 13,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: AppTypography.body2Medium.copyWith(
                                color: AppColors.white,
                                fontWeight: notification.isUnread
                                    ? FontWeight.w700
                                    : FontWeight.w600,
                              ),
                            ),
                          ),
                          if (notification.isUnread) ...[
                            const SizedBox(width: 8),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: style.color,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (notification.body.trim().isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text(
                          notification.body,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.body2Regular.copyWith(
                            color: AppColors.grayscale300,
                            height: 1.35,
                          ),
                        ),
                      ],
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            timeLabel,
                            style: AppTypography.captionRegular1.copyWith(
                              color: AppColors.grayscale400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NotificationAvatar extends StatelessWidget {
  const _NotificationAvatar({required this.notification});

  final CommunityNotification notification;

  @override
  Widget build(BuildContext context) {
    final initials = notification.actorName.trim().isEmpty
        ? 'U'
        : notification.actorName.characters.first.toUpperCase();

    return Container(
      width: 54,
      height: 54,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.grayscale700),
      ),
      child: ClipOval(
        child: DecoratedBox(
          decoration: const BoxDecoration(color: AppColors.grayscale800),
          child: notification.actorAvatarUrl.trim().isEmpty
              ? Center(
                  child: Text(
                    initials,
                    style: AppTypography.button1Semibold.copyWith(
                      color: AppColors.yellow500,
                    ),
                  ),
                )
              : IMovieRemoteImage(
                  imageUrl: notification.actorAvatarUrl,
                  placeholderLabel: initials,
                ),
        ),
      ),
    );
  }
}

class _NotificationStyle {
  const _NotificationStyle({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  factory _NotificationStyle.fromType(CommunityNotificationType type) {
    return switch (type) {
      CommunityNotificationType.newPost => const _NotificationStyle(
        icon: FluentIcons.document_text_24_filled,
        color: AppColors.yellow500,
      ),
      CommunityNotificationType.newStory => const _NotificationStyle(
        icon: FluentIcons.play_circle_24_filled,
        color: Color(0xFF60A5FA),
      ),
      CommunityNotificationType.postComment => const _NotificationStyle(
        icon: FluentIcons.comment_24_filled,
        color: AppColors.green400,
      ),
      CommunityNotificationType.postReaction => const _NotificationStyle(
        icon: FluentIcons.heart_24_filled,
        color: AppColors.red400,
      ),
      CommunityNotificationType.newFollower => const _NotificationStyle(
        icon: FluentIcons.person_add_24_filled,
        color: Color(0xFFA78BFA),
      ),
      CommunityNotificationType.chatMessage => const _NotificationStyle(
        icon: FluentIcons.chat_24_filled,
        color: Color(0xFF38BDF8),
      ),
      CommunityNotificationType.incomingCall => const _NotificationStyle(
        icon: FluentIcons.call_24_filled,
        color: AppColors.green400,
      ),
      CommunityNotificationType.callDeclined => const _NotificationStyle(
        icon: FluentIcons.call_end_24_filled,
        color: AppColors.red400,
      ),
      CommunityNotificationType.callEnded => const _NotificationStyle(
        icon: FluentIcons.call_end_24_filled,
        color: AppColors.red400,
      ),
      CommunityNotificationType.missedCall => const _NotificationStyle(
        icon: FluentIcons.call_end_24_filled,
        color: AppColors.red400,
      ),
    };
  }
}
