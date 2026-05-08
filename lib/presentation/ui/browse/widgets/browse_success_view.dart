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
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 112),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BrowseHeroHeader(
                title: l10n.browseHeroTitle,
                subtitle: l10n.browseHeroSubtitle,
                genresLabel: l10n.browseStatCatalog,
                popularLabel: l10n.profileMovies,
                genresCount: state.genres.length,
                popularCount: 1000,
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 26),
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

class _BrowseHeroHeader extends StatelessWidget {
  const _BrowseHeroHeader({
    required this.title,
    required this.subtitle,
    required this.genresLabel,
    required this.popularLabel,
    required this.genresCount,
    required this.popularCount,
  });

  final String title;
  final String subtitle;
  final String genresLabel;
  final String popularLabel;
  final int genresCount;
  final int popularCount;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [AppColors.grayscale900, AppColors.yellow950],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.07)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.yellow500.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.yellow500.withValues(alpha: 0.32),
                    ),
                  ),
                  child: const Icon(
                    FluentIcons.search_visual_24_filled,
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
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.h2.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.body2Regular.copyWith(
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
                  child: _BrowseHeroMetric(
                    value: genresCount.toString(),
                    label: genresLabel,
                  ),
                ),
                const _BrowseHeroDivider(),
                Expanded(
                  child: _BrowseHeroMetric(
                    value: '$popularCount+',
                    label: popularLabel,
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

class _BrowseHeroMetric extends StatelessWidget {
  const _BrowseHeroMetric({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.h3.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
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

class _BrowseHeroDivider extends StatelessWidget {
  const _BrowseHeroDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 38,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      color: AppColors.white.withValues(alpha: 0.08),
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
              color: AppColors.yellow500.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: AppColors.yellow500.withValues(alpha: 0.22),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Text(
                '${chip.label}: ${chip.value}',
                style: AppTypography.body2Regular.copyWith(
                  color: AppColors.yellow200,
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
      return const _BrowseSearchFeedback(
        child: CircularProgressIndicator(color: AppColors.yellow500),
      );
    }

    final failure = state.failure;
    if (failure != null) {
      return _BrowseSearchFeedback(
        child: Text(
          failure.message,
          textAlign: TextAlign.center,
          style: AppTypography.body1Regular.copyWith(color: AppColors.white),
        ),
      );
    }

    if (state.searchMovieViewData.isEmpty) {
      return _BrowseSearchFeedback(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              FluentIcons.search_24_regular,
              color: AppColors.yellow500,
              size: 32,
            ),
            const SizedBox(height: 12),
            Text(
              l10n.browseNoSearchResults,
              textAlign: TextAlign.center,
              style: AppTypography.body1Regular.copyWith(
                color: AppColors.white,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.browseSearchResults,
                style: AppTypography.h3.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.grayscale900,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AppColors.grayscale800),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                child: Text(
                  l10n.browseSearchCount(state.searchTotalItems),
                  style: AppTypography.captionMedium.copyWith(
                    color: AppColors.grayscale200,
                  ),
                ),
              ),
            ),
          ],
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
                tagColor: AppColors.black.withValues(alpha: 0.26),
                borderColor: AppColors.white.withValues(alpha: 0.07),
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

class _BrowseSearchFeedback extends StatelessWidget {
  const _BrowseSearchFeedback({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.grayscale900,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.07)),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 44),
          child: Center(child: child),
        ),
      ),
    );
  }
}
