import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';

class ChatListHeader extends StatelessWidget {
  const ChatListHeader({
    super.key,
    required this.conversationCount,
    required this.unreadCount,
  });

  final int conversationCount;
  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.grayscale900,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.grayscale800),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.yellow500,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    FluentIcons.chat_sparkle_24_filled,
                    color: AppColors.grayscale950,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hộp thư cộng đồng',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.button1Semibold.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Tin nhắn và cuộc gọi',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.captionRegular1.copyWith(
                          color: AppColors.grayscale300,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                _HeaderMetric(
                  label: 'Cuộc trò chuyện',
                  value: conversationCount.toString(),
                ),
                const SizedBox(width: 8),
                _HeaderMetric(
                  label: 'Chưa đọc',
                  value: unreadCount > 99 ? '99+' : unreadCount.toString(),
                  highlighted: unreadCount > 0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderMetric extends StatelessWidget {
  const _HeaderMetric({
    required this.label,
    required this.value,
    this.highlighted = false,
  });

  final String label;
  final String value;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: highlighted ? AppColors.yellow950 : AppColors.grayscale950,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: highlighted ? AppColors.yellow700 : AppColors.grayscale800,
          ),
        ),
        child: Row(
          children: [
            Text(
              value,
              style: AppTypography.button1Semibold.copyWith(
                color: highlighted ? AppColors.yellow300 : AppColors.white,
              ),
            ),
            const SizedBox(width: 7),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.captionRegular1.copyWith(
                  color: AppColors.grayscale300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
