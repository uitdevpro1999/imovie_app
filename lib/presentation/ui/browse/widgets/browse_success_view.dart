part of '../browse_page.dart';

class _BrowseSuccessView extends StatelessWidget {
  const _BrowseSuccessView({
    required this.state,
    required this.controller,
    required this.onKeywordChanged,
    required this.onApplySearchFilters,
    required this.onRefresh,
    required this.onLoadMoreSearch,
  });

  final BrowseState state;
  final TextEditingController controller;
  final ValueChanged<String> onKeywordChanged;
  final Future<void> Function({
    required BrowseSearchSortType sortType,
    required String countrySlug,
    required BrowseSearchYear year,
  })
  onApplySearchFilters;
  final Future<bool> Function() onRefresh;
  final Future<IMovieLoadMoreResult> Function() onLoadMoreSearch;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return IMovieSmartRefresher(
      onRefresh: onRefresh,
      onLoadMore: onLoadMoreSearch,
      enablePullUp: state.searchHasMore,
      hasMore: state.searchHasMore,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(14, 8, 14, 104),
        children: [
          Column(
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
                activeFilterCount: state.activeSearchFilterCount,
                onFilterTap: () => _openSearchFilters(context),
              ),
              if (state.activeSearchFilterChips.isNotEmpty) ...[
                const SizedBox(height: 12),
                _BrowseSearchFilterChips(chips: state.activeSearchFilterChips),
              ],
              const SizedBox(height: 24),
              if (state.showSearchResults)
                _SearchResultsSection(state: state)
              else ...[
                _BrowseGenresSection(state: state),
                const SizedBox(height: 24),
                _BrowseMovieStripSection(
                  title: l10n.browsePopularSection,
                  actionLabel: '',
                  movies: state.popularMovieViewData,
                  relatedMovies: state.popularMovies,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _openSearchFilters(BuildContext context) async {
    final filters = await showModalBottomSheet<_BrowseSearchFilterResult>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.grayscale950,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      clipBehavior: Clip.antiAlias,
      builder: (_) => _BrowseSearchFilterSheet(state: state),
    );

    if (filters == null) {
      return;
    }

    await onApplySearchFilters(
      sortType: filters.sortType,
      countrySlug: filters.countrySlug,
      year: filters.year,
    );
  }
}

class _BrowseSearchFilterChips extends StatelessWidget {
  const _BrowseSearchFilterChips({required this.chips});

  final List<BrowseFilterChipData> chips;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final chip in chips)
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.grayscale900,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: AppColors.grayscale800),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Text(
                '${chip.label}: ${chip.value}',
                style: AppTypography.body2Regular.copyWith(
                  color: AppColors.grayscale200,
                ),
              ),
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
              child: IMovieSearchResultCard(
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
