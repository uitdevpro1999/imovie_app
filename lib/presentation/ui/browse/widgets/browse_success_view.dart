part of '../browse_page.dart';

class _BrowseSuccessView extends StatelessWidget {
  const _BrowseSuccessView({
    required this.state,
    required this.controller,
    required this.onKeywordChanged,
  });

  final BrowseState state;
  final TextEditingController controller;
  final ValueChanged<String> onKeywordChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              l10n.homeBottomNavBrowse,
              style: AppTypography.h2.copyWith(color: AppColors.white),
            ),
          ),
          const SizedBox(height: 18),
          _BrowseSearchField(
            controller: controller,
            onChanged: onKeywordChanged,
          ),
          const SizedBox(height: 24),
          if (state.showSearchResults)
            _SearchResultsSection(state: state)
          else ...[
            _TopMoviesOfWeekSection(state: state),
            const SizedBox(height: 24),
            _BrowseGenresSection(state: state),
            const SizedBox(height: 24),
            _BrowseMovieStripSection(
              title: l10n.browsePopularSection,
              actionLabel: l10n.homeSectionViewMore,
              movies: state.popularMovieViewData,
              relatedMovies: state.popularMovies,
            ),
          ],
        ],
      ),
    );
  }
}

class _TopMoviesOfWeekSection extends StatelessWidget {
  const _TopMoviesOfWeekSection({required this.state});

  final BrowseState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (state.topMovieViewData.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieGoSectionHeader(
          title: l10n.homeSectionTopThisWeek,
          actionLabel: l10n.homeSectionViewMore,
          titleColor: AppColors.white,
          actionColor: AppColors.yellow500,
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 150,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final movie = state.topMovieViewData[index];
              return _BrowsePromoCard(
                movie: movie,
                index: index,
                onTap: () => context.router.push(
                  MovieDetailRoute(
                    slug: movie.movie.slug,
                    relatedMovies: state.topMoviesOfWeek,
                  ),
                ),
              );
            },
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemCount: state.topMovieViewData.length,
          ),
        ),
      ],
    );
  }
}

class _SearchResultsSection extends StatelessWidget {
  const _SearchResultsSection({required this.state});

  final BrowseState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (state.searchLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 48),
          child: CircularProgressIndicator(color: AppColors.yellow500),
        ),
      );
    }

    final failure = state.failure;
    if (failure != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Text(
          failure.message,
          textAlign: TextAlign.center,
          style: AppTypography.body1Regular.copyWith(
            color: AppColors.grayscale300,
          ),
        ),
      );
    }

    if (state.searchMovieViewData.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Text(
          l10n.browseNoSearchResults,
          textAlign: TextAlign.center,
          style: AppTypography.body1Regular.copyWith(
            color: AppColors.grayscale300,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.browseSearchResults,
          style: AppTypography.h3.copyWith(color: AppColors.white),
        ),
        const SizedBox(height: 14),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final item = state.searchMovieViewData[index];
            return GestureDetector(
              onTap: () => context.router.push(
                MovieDetailRoute(
                  slug: item.movie.slug,
                  relatedMovies: state.searchResults,
                ),
              ),
              child: MovieGoSearchResultCard(
                imageUrl: item.movie.posterUrl,
                title: item.movie.title,
                duration: item.movie.durationLabel.isNotEmpty
                    ? item.movie.durationLabel
                    : item.movie.yearLabel,
                rating: item.ratingLabel,
                tags: item.tags,
                backgroundColor: AppColors.grayscale900,
                titleColor: AppColors.white,
                textColor: AppColors.grayscale300,
                tagColor: AppColors.grayscale800,
              ),
            );
          },
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemCount: state.searchMovieViewData.length,
        ),
      ],
    );
  }
}
