import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';

class ChatEmptyView extends StatelessWidget {
  const ChatEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.grayscale900,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.grayscale800),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 34),
        child: Column(
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.yellow950,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.yellow800),
              ),
              child: const Icon(
                FluentIcons.chat_sparkle_24_filled,
                color: AppColors.yellow400,
                size: 34,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Chưa có cuộc trò chuyện',
              style: AppTypography.h4.copyWith(color: AppColors.white),
            ),
            const SizedBox(height: 8),
            Text(
              'Mở hồ sơ cộng đồng để bắt đầu nhắn tin hoặc gọi.',
              textAlign: TextAlign.center,
              style: AppTypography.body2Regular.copyWith(
                color: AppColors.grayscale300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
