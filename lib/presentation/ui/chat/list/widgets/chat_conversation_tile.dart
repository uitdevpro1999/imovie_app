import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/domain/entities/chat/chat_conversation.dart';
import 'package:imovie_app/presentation/widgets/imovie_remote_image.dart';

class ChatConversationTile extends StatelessWidget {
  const ChatConversationTile({
    super.key,
    required this.conversation,
    required this.onTap,
  });

  final ChatConversation conversation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final unread = conversation.unreadCount > 0;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Ink(
          decoration: BoxDecoration(
            color: unread ? AppColors.grayscale900 : AppColors.grayscale950,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: unread ? AppColors.yellow800 : AppColors.grayscale800,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                _ConversationAvatar(
                  title: conversation.title,
                  avatarUrl: conversation.avatarUrl,
                  unread: unread,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              conversation.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.button1Semibold.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _formatConversationTime(conversation.lastMessageAt),
                            style: AppTypography.captionRegular1.copyWith(
                              color: unread
                                  ? AppColors.yellow400
                                  : AppColors.grayscale500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              conversation.lastMessagePreview.trim().isEmpty
                                  ? 'Bắt đầu trò chuyện'
                                  : conversation.lastMessagePreview,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  (unread
                                          ? AppTypography.body2Medium
                                          : AppTypography.body2Regular)
                                      .copyWith(
                                        color: unread
                                            ? AppColors.white
                                            : AppColors.grayscale300,
                                      ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (unread)
                      Container(
                        constraints: const BoxConstraints(minWidth: 22),
                        height: 22,
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.yellow500,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          conversation.unreadCount > 99
                              ? '99+'
                              : conversation.unreadCount.toString(),
                          style: AppTypography.captionMedium.copyWith(
                            color: AppColors.grayscale950,
                          ),
                        ),
                      )
                    else
                      const Icon(
                        FluentIcons.chevron_right_20_regular,
                        color: AppColors.grayscale500,
                        size: 20,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatConversationTime(DateTime? value) {
    if (value == null) {
      return '';
    }
    final now = DateTime.now();
    final local = value.toLocal();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(local.year, local.month, local.day);
    if (date == today) {
      final hour = local.hour.toString().padLeft(2, '0');
      final minute = local.minute.toString().padLeft(2, '0');
      return '$hour:$minute';
    }
    if (today.difference(date).inDays == 1) {
      return 'Hôm qua';
    }
    return '${local.day.toString().padLeft(2, '0')}/${local.month.toString().padLeft(2, '0')}';
  }
}

class _ConversationAvatar extends StatelessWidget {
  const _ConversationAvatar({
    required this.title,
    required this.avatarUrl,
    required this.unread,
  });

  final String title;
  final String avatarUrl;
  final bool unread;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: unread ? AppColors.yellow500 : AppColors.grayscale800,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: IMovieRemoteImage(imageUrl: avatarUrl, placeholderLabel: title),
      ),
    );
  }
}
