part of '../genre_movies_page.dart';

class _GenreFilterBar extends StatelessWidget {
  const _GenreFilterBar({
    required this.resultSummary,
    required this.activeFilterChips,
    required this.filterState,
    required this.onApplyFilters,
  });

  final String resultSummary;
  final List<GenreFilterChipData> activeFilterChips;
  final GenreMoviesState filterState;
  final Future<void> Function({
    required GenreSortType sortType,
    required String countrySlug,
    required GenreYear year,
  })
  onApplyFilters;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.grayscale950,
        border: Border(bottom: BorderSide(color: AppColors.grayscale900)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    resultSummary,
                    style: AppTypography.body2Regular.copyWith(
                      color: AppColors.grayscale300,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () => _openFilters(context),
                  icon: const Icon(Icons.tune_rounded, size: 18),
                  label: const Text('Bộ lọc'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.yellow500,
                  ),
                ),
              ],
            ),
            if (activeFilterChips.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final chip in activeFilterChips)
                    _FilterStatusChip(chip: chip),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _openFilters(BuildContext context) async {
    final filters = await showModalBottomSheet<_GenreFilterResult>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.grayscale950,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      clipBehavior: Clip.antiAlias,
      builder: (_) => _GenreFilterSheet(state: filterState),
    );

    if (filters == null) {
      return;
    }

    await onApplyFilters(
      sortType: filters.sortType,
      countrySlug: filters.countrySlug,
      year: filters.year,
    );
  }
}

class _FilterStatusChip extends StatelessWidget {
  const _FilterStatusChip({required this.chip});

  final GenreFilterChipData chip;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
    );
  }
}
