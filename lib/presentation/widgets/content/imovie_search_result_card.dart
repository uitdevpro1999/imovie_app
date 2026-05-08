import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/presentation/widgets/imovie_remote_image.dart';

class IMovieSearchResultCard extends StatelessWidget {
  const IMovieSearchResultCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.duration,
    required this.rating,
    required this.tags,
    this.backgroundColor = AppColors.surface,
    this.titleColor = AppColors.textPrimary,
    this.textColor = AppColors.textSecondary,
    this.tagColor = AppColors.surfaceAlt,
    this.borderColor,
  });

  final String imageUrl;
  final String title;
  final String duration;
  final String rating;
  final List<String> tags;
  final Color backgroundColor;
  final Color titleColor;
  final Color textColor;
  final Color tagColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
        border: borderColor == null ? null : Border.all(color: borderColor!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IMovieRemoteImage(
              imageUrl: imageUrl,
              width: 80,
              height: 118,
              borderRadius: BorderRadius.circular(16),
              placeholderLabel: title,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.h4.copyWith(color: titleColor),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    duration,
                    style: AppTypography.captionRegular1.copyWith(
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        FluentIcons.star_24_filled,
                        size: 16,
                        color: AppColors.yellow500,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        rating,
                        style: AppTypography.captionMedium.copyWith(
                          color: titleColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final tag in tags.take(4))
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: tagColor,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            child: Text(
                              tag,
                              style: AppTypography.captionMedium.copyWith(
                                color: titleColor,
                              ),
                            ),
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
    );
  }
}
