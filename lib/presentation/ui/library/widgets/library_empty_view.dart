import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';

class LibraryEmptyView extends StatelessWidget {
  const LibraryEmptyView({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.grayscale900,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.bookmarks_outlined,
                color: AppColors.yellow500,
                size: 34,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTypography.h3.copyWith(color: AppColors.white),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
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
