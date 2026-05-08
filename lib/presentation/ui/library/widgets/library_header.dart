import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/domain/entities/library/library_movie.dart';

class LibraryHeader extends StatelessWidget {
  const LibraryHeader({
    super.key,
    required this.movies,
    required this.title,
    required this.subtitle,
    required this.savedMoviesLabel,
    required this.playableMoviesLabel,
  });

  final List<LibraryMovie> movies;
  final String title;
  final String subtitle;
  final String savedMoviesLabel;
  final String playableMoviesLabel;

  @override
  Widget build(BuildContext context) {
    final playableCount = movies
        .where((item) => item.movie.hasPlayableContent)
        .length;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [AppColors.grayscale900, AppColors.yellow950],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: AppColors.grayscale800),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.yellow500.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppColors.yellow500.withValues(alpha: 0.3),
                    ),
                  ),
                  child: const Icon(
                    FluentIcons.collections_24_filled,
                    color: AppColors.yellow500,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.h2.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        subtitle,
                        maxLines: 2,
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
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: _LibraryStatTile(
                    value: movies.length.toString(),
                    label: savedMoviesLabel,
                  ),
                ),
                const SizedBox(width: 10),
                const _LibraryStatDivider(),
                Expanded(
                  child: _LibraryStatTile(
                    value: playableCount.toString(),
                    label: playableMoviesLabel,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LibraryStatTile extends StatelessWidget {
  const _LibraryStatTile({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.h3.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.captionRegular2.copyWith(
              color: AppColors.grayscale300,
            ),
          ),
        ],
      ),
    );
  }
}

class _LibraryStatDivider extends StatelessWidget {
  const _LibraryStatDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 34,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      color: AppColors.white.withValues(alpha: 0.08),
    );
  }
}
