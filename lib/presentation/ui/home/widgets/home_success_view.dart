part of '../home_page.dart';

class _HomeSuccessView extends StatelessWidget {
  const _HomeSuccessView({required this.state, required this.onRefresh});

  final HomeState state;
  final Future<bool> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return IMovieSmartRefresher(
      onRefresh: onRefresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        cacheExtent: 3200,
        padding: const EdgeInsets.only(bottom: 16),
        children: [
          if (state.topMovieViewData.isNotEmpty) ...[
            HomeHeroSlider(
              movies: state.topMovieViewData,
              relatedMovies: state.topMovies,
            ),
            const SizedBox(height: 24),
          ] else if (state.heroMovieViewData != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: HomeHeroBanner(movie: state.heroMovieViewData!),
            ),
            const SizedBox(height: 24),
          ],
          if (state.visibleGenres.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _HomeGenresSection(
                title: l10n.movieDetailGenres,
                actionLabel: l10n.homeSectionViewMore,
                state: state,
                onShowMore: () =>
                    context.router.push(GenresRoute(genres: state.genres)),
              ),
            ),
            const SizedBox(height: 24),
          ],
          if (state.freshUpdateMovies.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: HomeMovieStripSection(
                title: l10n.homeSectionFreshUpdates,
                actionLabel: l10n.homeSectionViewMore,
                movies: state.freshUpdateMovieViewData,
                relatedMovies: state.freshUpdateMovies,
                onActionTap: () => context.router.push(
                  MovieListRoute(
                    slug: 'phim-moi',
                    title: l10n.homeSectionFreshUpdates,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
          if (state.highestRatedMovies.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: HomeMovieStripSection(
                title: l10n.homeSectionHighestRated,
                movies: state.highestRatedMovieViewData,
                relatedMovies: state.highestRatedMovies,
              ),
            ),
            const SizedBox(height: 24),
          ],
          if (state.seriesMovies.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: HomeMovieStripSection(
                title: l10n.homeSectionSeriesSpotlight,
                actionLabel: l10n.homeSectionViewMore,
                movies: state.seriesMovieViewData,
                relatedMovies: state.seriesMovies,
                onActionTap: () => context.router.push(
                  MovieListRoute(
                    slug: 'phim-bo',
                    title: l10n.homeSectionSeriesSpotlight,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
          if (state.tvShows.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: HomeMovieStripSection(
                title: l10n.homeSectionTvShows,
                actionLabel: l10n.homeSectionViewMore,
                movies: state.tvShowMovieViewData,
                relatedMovies: state.tvShows,
                onActionTap: () => context.router.push(
                  MovieListRoute(
                    slug: 'tv-shows',
                    title: l10n.homeSectionTvShows,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
          if (state.upcoming.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: HomeMovieStripSection(
                title: l10n.homeSectionUpcoming,
                actionLabel: l10n.homeSectionViewMore,
                movies: state.upcomingMovieViewData,
                relatedMovies: state.upcoming,
                onActionTap: () => context.router.push(
                  MovieListRoute(
                    slug: 'phim-sap-chieu',
                    title: l10n.homeSectionUpcoming,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
          if (state.animationMovies.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: HomeMovieStripSection(
                title: l10n.homeSectionAnimationPicks,
                actionLabel: l10n.homeSectionViewMore,
                movies: state.animationMovieViewData,
                relatedMovies: state.animationMovies,
                onActionTap: () => context.router.push(
                  MovieListRoute(
                    slug: 'hoat-hinh',
                    title: l10n.homeSectionAnimationPicks,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ],
      ),
    );
  }
}
