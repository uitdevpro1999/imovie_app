part of '../home_page.dart';

class _HomeSuccessView extends StatelessWidget {
  const _HomeSuccessView({required this.state});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              ),
            ),
            const SizedBox(height: 24),
          ],
          if (state.highestRatedMovies.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: HomeMovieStripSection(
                title: l10n.homeSectionHighestRated,
                actionLabel: l10n.homeSectionViewMore,
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
              ),
            ),
            const SizedBox(height: 24),
          ],
        ],
      ),
    );
  }
}
