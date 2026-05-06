import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/presentation/widgets/moviego_remote_image.dart';

class MovieGoPosterCard extends StatelessWidget {
  const MovieGoPosterCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.badgeText,
    this.width = 108,
    this.titleColor = AppColors.textPrimary,
    this.subtitleColor = AppColors.textSecondary,
  });

  final String imageUrl;
  final String title;
  final String subtitle;
  final String badgeText;
  final double width;
  final Color titleColor;
  final Color subtitleColor;

  @override
  Widget build(BuildContext context) {
    final imageHeight = width * 1.48;

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              MovieGoRemoteImage(
                imageUrl: imageUrl,
                width: width,
                height: imageHeight,
                borderRadius: BorderRadius.circular(16),
                placeholderLabel: title,
              ),
              Positioned(
                top: 8,
                left: 8,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.black88,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Text(
                      badgeText,
                      style: AppTypography.captionMedium.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.body2Medium.copyWith(color: titleColor),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.captionRegular1.copyWith(color: subtitleColor),
          ),
        ],
      ),
    );
  }
}
