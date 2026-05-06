import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/domain/entities/library/library_movie.dart';
import 'package:imovie_app/presentation/widgets/imovie_remote_image.dart';

class LibraryMovieCard extends StatelessWidget {
  const LibraryMovieCard({super.key, required this.item, required this.onTap});

  final LibraryMovie item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final movie = item.movie;
    final meta = [
      if (movie.yearLabel.isNotEmpty) movie.yearLabel,
      if (movie.quality.trim().isNotEmpty) movie.quality,
      if (movie.language.trim().isNotEmpty) movie.language,
    ].join(' • ');
    final subtitle = movie.originalTitle.trim().isEmpty
        ? meta
        : movie.originalTitle;

    return Material(
      color: AppColors.grayscale900,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IMovieRemoteImage(
                imageUrl: movie.posterUrl,
                width: 82,
                height: 122,
                borderRadius: BorderRadius.circular(8),
                placeholderLabel: movie.title,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 122,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.h4.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.captionRegular1.copyWith(
                          color: AppColors.grayscale300,
                        ),
                      ),
                      if (meta.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          meta,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.captionRegular1.copyWith(
                            color: AppColors.grayscale400,
                          ),
                        ),
                      ],
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: AppColors.yellow500,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            movie.rating.toStringAsFixed(1),
                            style: AppTypography.captionMedium.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.grayscale400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
