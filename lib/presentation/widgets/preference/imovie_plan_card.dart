import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';

class IMoviePlanCard extends StatelessWidget {
  const IMoviePlanCard({
    super.key,
    required this.name,
    required this.price,
    required this.description,
    this.badgeLabel,
    this.highlighted = false,
  });

  final String name;
  final String price;
  final String description;
  final String? badgeLabel;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: highlighted ? AppColors.yellow500 : AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: highlighted ? AppColors.yellow500 : AppColors.surfaceStroke,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (badgeLabel != null) ...[
            DecoratedBox(
              decoration: BoxDecoration(
                color: highlighted ? AppColors.white : AppColors.yellow50,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: Text(
                  badgeLabel!,
                  style: AppTypography.captionMedium.copyWith(
                    color: highlighted
                        ? AppColors.yellow700
                        : AppColors.yellow600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          Text(
            name,
            style: AppTypography.h4.copyWith(
              color: highlighted ? AppColors.white : AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            price,
            style: AppTypography.h2.copyWith(
              color: highlighted ? AppColors.white : AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: AppTypography.body2Regular.copyWith(
              color: highlighted ? AppColors.white : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
