import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/domain/entities/library/library_movie.dart';
import 'package:imovie_app/presentation/widgets/imovie_remote_image.dart';

class LibraryMovieCard extends StatelessWidget {
  const LibraryMovieCard({
    super.key,
    required this.item,
    required this.savedDateText,
    required this.swipeHint,
    required this.onTap,
  });

  final LibraryMovie item;
  final String savedDateText;
  final String swipeHint;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final movie = item.movie;
    final meta = [
      if (movie.yearLabel.isNotEmpty) movie.yearLabel,
      if (movie.quality.trim().isNotEmpty) movie.quality,
      if (movie.language.trim().isNotEmpty) movie.language,
    ].join(' • ');
    final subtitle = movie.originalTitle.trim().isEmpty ? meta : movie.originalTitle;
    final genres = movie.genres.take(2).where((genre) => genre.trim().isNotEmpty);

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Material(
        color: AppColors.grayscale900,
        child: InkWell(
          onTap: onTap,
          child: Stack(
            children: [
              Positioned.fill(
                child: IMovieRemoteImage(
                  imageUrl: movie.backdropUrl.isEmpty ? movie.posterUrl : movie.backdropUrl,
                  fit: BoxFit.cover,
                  placeholderLabel: movie.title,
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.black.withValues(alpha: 0.82),
                        AppColors.black.withValues(alpha: 0.66),
                        AppColors.grayscale900.withValues(alpha: 0.96),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IMovieRemoteImage(
                      imageUrl: movie.posterUrl,
                      width: 96,
                      height: 148,
                      borderRadius: BorderRadius.circular(14),
                      placeholderLabel: movie.title,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SizedBox(
                        height: 162,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    movie.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.h4.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  FluentIcons.chevron_right_24_regular,
                                  color: AppColors.grayscale300,
                                  size: 22,
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            if (subtitle.isNotEmpty)
                              Text(
                                subtitle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.captionRegular1.copyWith(color: AppColors.grayscale300),
                              ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: [
                                if (movie.rating > 0)
                                  _LibraryInfoPill(
                                    movie.rating.toStringAsFixed(1),
                                    icon: FluentIcons.star_24_filled,
                                    highlighted: true,
                                  ),
                                if (movie.yearLabel.isNotEmpty) _LibraryInfoPill(movie.yearLabel),
                                if (movie.quality.trim().isNotEmpty) _LibraryInfoPill(movie.quality),
                                if (movie.language.trim().isNotEmpty) _LibraryInfoPill(movie.language),
                                ...genres.take(2).map((genre) => _LibraryInfoPill(genre)),
                              ],
                            ),
                            SizedBox(height: 2,),
                            const Spacer(),
                            Row(
                              children: [
                                if (savedDateText.isNotEmpty)
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Icon(
                                          FluentIcons.bookmark_24_regular,
                                          size: 14,
                                          color: AppColors.grayscale300,
                                        ),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: Text(
                                            savedDateText,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTypography.captionRegular2.copyWith(
                                              color: AppColors.grayscale300,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                else
                                  const Spacer(),
                                const SizedBox(width: 12),
                                Flexible(
                                  child: Text(
                                    swipeHint,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.right,
                                    style: AppTypography.captionRegular2.copyWith(color: AppColors.grayscale400),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LibraryInfoPill extends StatelessWidget {
  const _LibraryInfoPill(this.label, {this.icon, this.highlighted = false});

  final IconData? icon;
  final String label;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final foreground = highlighted ? AppColors.yellow500 : AppColors.white;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: 0.28),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: highlighted ? AppColors.yellow500.withValues(alpha: 0.32) : AppColors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[Icon(icon, size: 13, color: foreground), const SizedBox(width: 3)],
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.captionRegular2.copyWith(color: foreground),
            ),
          ],
        ),
      ),
    );
  }
}
