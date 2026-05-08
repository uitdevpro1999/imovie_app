import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/domain/entities/home/home_movie.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/ui/home/home_state.dart';
import 'package:imovie_app/presentation/widgets/imovie_remote_image.dart';

class HomeFeaturedUpdatesSection extends StatelessWidget {
  const HomeFeaturedUpdatesSection({
    super.key,
    required this.title,
    required this.actionLabel,
    required this.movies,
    required this.relatedMovies,
    required this.onPlayMovie,
    required this.onOpenTrailer,
    required this.onActionTap,
  });

  final String title;
  final String actionLabel;
  final List<HomeMovieViewData> movies;
  final List<HomeMovie> relatedMovies;
  final ValueChanged<HomeMovie> onPlayMovie;
  final ValueChanged<HomeMovie> onOpenTrailer;
  final VoidCallback onActionTap;

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const SizedBox.shrink();
    }

    final spotlight = movies.first;
    final sideMovies = movies.skip(1).take(5).toList(growable: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FeaturedHeader(
          title: title,
          actionLabel: actionLabel,
          onActionTap: onActionTap,
        ),
        const SizedBox(height: 14),
        _FeaturedSpotlightCard(
          movie: spotlight,
          relatedMovies: relatedMovies,
          onPlayMovie: onPlayMovie,
          onOpenTrailer: onOpenTrailer,
        ),
        if (sideMovies.isNotEmpty) ...[
          const SizedBox(height: 14),
          SizedBox(
            height: 174,
            child: ListView.separated(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final movie = sideMovies[index];
                return _FeaturedMiniCard(
                  movie: movie,
                  relatedMovies: relatedMovies,
                );
              },
              separatorBuilder: (_, _) => const SizedBox(width: 10),
              itemCount: sideMovies.length,
            ),
          ),
        ],
      ],
    );
  }
}

class _FeaturedHeader extends StatelessWidget {
  const _FeaturedHeader({
    required this.title,
    required this.actionLabel,
    required this.onActionTap,
  });

  final String title;
  final String actionLabel;
  final VoidCallback onActionTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.yellow300, AppColors.red400],
            ),
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
        Material(
          color: AppColors.yellow500.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(999),
          child: InkWell(
            onTap: onActionTap,
            borderRadius: BorderRadius.circular(999),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
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

class _FeaturedSpotlightCard extends StatelessWidget {
  const _FeaturedSpotlightCard({
    required this.movie,
    required this.relatedMovies,
    required this.onPlayMovie,
    required this.onOpenTrailer,
  });

  final HomeMovieViewData movie;
  final List<HomeMovie> relatedMovies;
  final ValueChanged<HomeMovie> onPlayMovie;
  final ValueChanged<HomeMovie> onOpenTrailer;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isTrailerOnly = movie.movie.isTrailerOnly;

    return GestureDetector(
      onTap: () => _openMovie(context),
      child: Container(
        height: 204,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.24),
              blurRadius: 24,
              offset: const Offset(0, 12),
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
                      AppColors.black.withValues(alpha: 0.06),
                      AppColors.black.withValues(alpha: 0.52),
                      AppColors.black.withValues(alpha: 0.92),
                    ],
                    stops: const [0, 0.5, 1],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 14,
              top: 14,
              child: _RatingBadge(rating: movie.ratingLabel),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          movie.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.h2.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                            height: 1.15,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _metaLine(movie),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.captionMedium.copyWith(
                            color: AppColors.grayscale200,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Material(
                    color: AppColors.white.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(999),
                    child: InkWell(
                      onTap: () => isTrailerOnly
                          ? onOpenTrailer(movie.movie)
                          : onPlayMovie(movie.movie),
                      borderRadius: BorderRadius.circular(999),
                      child: Container(
                        height: 42,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: AppColors.white.withValues(alpha: 0.18),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withValues(alpha: 0.18),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isTrailerOnly
                                  ? FluentIcons.movies_and_tv_24_regular
                                  : FluentIcons.play_24_filled,
                              size: 18,
                              color: AppColors.white,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              isTrailerOnly
                                  ? l10n.movieDetailActionTrailer
                                  : l10n.movieDetailPlay,
                              style: AppTypography.captionMedium.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openMovie(BuildContext context) {
    context.router.push(
      MovieDetailRoute(slug: movie.slug, relatedMovies: relatedMovies),
    );
  }
}

class _FeaturedMiniCard extends StatelessWidget {
  const _FeaturedMiniCard({required this.movie, required this.relatedMovies});

  final HomeMovieViewData movie;
  final List<HomeMovie> relatedMovies;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.push(
        MovieDetailRoute(slug: movie.slug, relatedMovies: relatedMovies),
      ),
      child: SizedBox(
        width: 132,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
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
                              AppColors.black.withValues(alpha: 0.72),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 8,
                      top: 8,
                      child: _RatingBadge(
                        rating: movie.ratingLabel,
                        compact: true,
                      ),
                    ),
                    Positioned(
                      left: 10,
                      right: 10,
                      bottom: 10,
                      child: Text(
                        movie.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.captionMedium.copyWith(
                          color: AppColors.white,
                          height: 1.16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
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
      ),
    );
  }
}

class _RatingBadge extends StatelessWidget {
  const _RatingBadge({required this.rating, this.compact = false});

  final String rating;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: 0.62),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.12)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 7 : 9,
          vertical: compact ? 4 : 5,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              FluentIcons.star_24_filled,
              color: AppColors.yellow500,
              size: 13,
            ),
            const SizedBox(width: 4),
            Text(
              rating,
              style: AppTypography.captionMedium.copyWith(
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _metaLine(HomeMovieViewData movie) {
  final values = [
    if (movie.movie.year > 0) movie.movie.yearLabel,
    if (movie.movie.qualityLabel.trim().isNotEmpty) movie.movie.qualityLabel,
    if (movie.movie.languageLabel.trim().isNotEmpty) movie.movie.languageLabel,
    movie.subtitleLabel,
  ].where((value) => value.trim().isNotEmpty).toList(growable: false);

  return values.join('  •  ');
}
