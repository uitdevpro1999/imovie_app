import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/domain/entities/home/home_movie.dart';
import 'package:imovie_app/presentation/ui/home/home_state.dart';
import 'package:imovie_app/presentation/widgets/imovie_remote_image.dart';

class HomeMovieStripSection extends StatelessWidget {
  const HomeMovieStripSection({
    super.key,
    required this.title,
    required this.movies,
    required this.relatedMovies,
    this.actionLabel,
    this.onActionTap,
  });

  final String title;
  final List<HomeMovieViewData> movies;
  final String? actionLabel;
  final List<HomeMovie> relatedMovies;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _HomeStripHeader(
          title: title,
          actionLabel: actionLabel ?? '',
          onActionTap: onActionTap,
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 268,
          child: ListView.separated(
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final movie = movies[index];

              return GestureDetector(
                onTap: () => context.router.push(
                  MovieDetailRoute(
                    slug: movie.slug,
                    relatedMovies: relatedMovies,
                  ),
                ),
                child: _HomeMoviePosterTile(movie: movie),
              );
            },
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemCount: movies.length,
          ),
        ),
      ],
    );
  }
}

class _HomeMoviePosterTile extends StatelessWidget {
  const _HomeMoviePosterTile({required this.movie});

  final HomeMovieViewData movie;

  @override
  Widget build(BuildContext context) {
    const width = 136.0;
    const imageHeight = 202.0;

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: imageHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.24),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                Positioned.fill(
                  child: IMovieRemoteImage(
                    imageUrl: movie.posterUrl,
                    fit: BoxFit.cover,
                    placeholderLabel: movie.title,
                  ),
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppColors.black.withValues(alpha: 0.66),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.black.withValues(alpha: 0.62),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: AppColors.white.withValues(alpha: 0.12),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 4,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            FluentIcons.star_24_filled,
                            size: 13,
                            color: AppColors.yellow500,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            movie.ratingLabel,
                            style: AppTypography.captionMedium.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.16),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.white.withValues(alpha: 0.18),
                      ),
                    ),
                    child: const Icon(
                      FluentIcons.play_24_filled,
                      size: 18,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            movie.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.body2Medium.copyWith(color: AppColors.white),
          ),
          const SizedBox(height: 3),
          Text(
            movie.subtitleLabel,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.captionRegular1.copyWith(
              color: AppColors.grayscale300,
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeStripHeader extends StatelessWidget {
  const _HomeStripHeader({
    required this.title,
    required this.actionLabel,
    this.onActionTap,
  });

  final String title;
  final String actionLabel;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: AppColors.yellow500,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.h3.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        if (actionLabel.trim().isNotEmpty)
          Material(
            color: AppColors.grayscale900,
            borderRadius: BorderRadius.circular(999),
            child: InkWell(
              onTap: onActionTap,
              borderRadius: BorderRadius.circular(999),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                child: Text(
                  actionLabel,
                  style: AppTypography.captionMedium.copyWith(
                    color: AppColors.yellow500,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
