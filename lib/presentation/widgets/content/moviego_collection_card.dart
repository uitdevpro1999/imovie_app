import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';

class MovieGoCollectionCard extends StatelessWidget {
  const MovieGoCollectionCard({
    super.key,
    required this.initials,
    required this.title,
    required this.subtitle,
  });

  final String initials;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 173,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.yellow100,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: Text(
              initials,
              style: AppTypography.body2Medium.copyWith(
                color: AppColors.yellow700,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(title, style: AppTypography.body2Medium),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppTypography.captionRegular1.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
