part of '../genre_movies_page.dart';

class _GenreFilterResult {
  const _GenreFilterResult({
    required this.sortType,
    required this.countrySlug,
    required this.year,
  });

  final GenreSortType sortType;
  final String countrySlug;
  final GenreYear year;
}

class _GenreFilterSheet extends StatefulWidget {
  const _GenreFilterSheet({required this.state});

  final GenreMoviesState state;

  @override
  State<_GenreFilterSheet> createState() => _GenreFilterSheetState();
}

class _GenreFilterSheetState extends State<_GenreFilterSheet> {
  late GenreSortType _sortType;
  late HomeCountry _country;
  late GenreYear _year;

  @override
  void initState() {
    super.initState();
    _sortType = widget.state.sortType;
    _country = widget.state.country;
    _year = widget.state.year;
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding =
        MediaQuery.viewInsetsOf(context).bottom +
        MediaQuery.paddingOf(context).bottom +
        16;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 12, 16, bottomPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.grayscale600,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Bộ lọc phim',
                  style: AppTypography.h3.copyWith(color: AppColors.white),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close_rounded, color: AppColors.white),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _FilterSelector<GenreSortType>(
            title: 'Kiểu sắp xếp',
            value: _sortType,
            items: GenreSortType.values,
            labelBuilder: (item) => item.label,
            onChanged: (value) => setState(() => _sortType = value),
          ),
          const SizedBox(height: 12),
          _FilterSelector<HomeCountry>(
            title: 'Quốc gia',
            value: _country,
            items: widget.state.countries,
            labelBuilder: (item) => item.name,
            onChanged: (value) => setState(() => _country = value),
          ),
          const SizedBox(height: 12),
          _FilterSelector<GenreYear>(
            title: 'Năm sản xuất',
            value: _year,
            items: GenreYear.values,
            labelBuilder: (item) => item.label,
            onChanged: (value) => setState(() => _year = value),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _reset,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.white,
                    side: const BorderSide(color: AppColors.grayscale600),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Đặt lại'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: _apply,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.yellow500,
                    foregroundColor: AppColors.grayscale950,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Áp dụng'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _reset() {
    setState(() {
      _sortType = GenreSortType.desc;
      _country = HomeCountry.all;
      _year = GenreYear.all;
    });
  }

  void _apply() {
    Navigator.of(context).pop(
      _GenreFilterResult(
        sortType: _sortType,
        countrySlug: _country.slug,
        year: _year,
      ),
    );
  }
}
