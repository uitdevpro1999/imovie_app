import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';

class IMovieSectionHeader extends StatelessWidget {
  const IMovieSectionHeader({
    super.key,
    required this.title,
    this.actionLabel = 'See all',
    this.titleColor = AppColors.textPrimary,
    this.actionColor = AppColors.textSecondary,
    this.onActionTap,
  });

  final String title;
  final String actionLabel;
  final Color titleColor;
  final Color actionColor;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTypography.h3.copyWith(
              fontWeight: FontWeight.w600,
              color: titleColor,
            ),
          ),
        ),
        if (actionLabel.trim().isNotEmpty)
          InkWell(
            onTap: onActionTap,
            borderRadius: BorderRadius.circular(999),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Text(
                actionLabel,
                style: AppTypography.body2Medium.copyWith(color: actionColor),
              ),
            ),
          ),
      ],
    );
  }
}
