import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';

class IMovieNotificationPromo extends StatelessWidget {
  const IMovieNotificationPromo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 358,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.yellow50,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.notifications_active_outlined,
              color: AppColors.yellow600,
              size: 32,
            ),
          ),
          const SizedBox(height: 16),
          Text('Enable notifications', style: AppTypography.h4),
          const SizedBox(height: 8),
          Text(
            'Get alerts for tickets, releases and reminders.',
            style: AppTypography.body2Regular.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
