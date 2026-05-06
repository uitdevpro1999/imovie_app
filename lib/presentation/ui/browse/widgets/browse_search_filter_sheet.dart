part of '../browse_page.dart';

class _BrowseSearchFilterResult {
  const _BrowseSearchFilterResult({
    required this.sortType,
    required this.countrySlug,
    required this.year,
  });

  final BrowseSearchSortType sortType;
  final String countrySlug;
  final BrowseSearchYear year;
}

class _BrowseSearchFilterSheet extends StatefulWidget {
  const _BrowseSearchFilterSheet({required this.state});

  final BrowseState state;

  @override
  State<_BrowseSearchFilterSheet> createState() =>
      _BrowseSearchFilterSheetState();
}

class _BrowseSearchFilterSheetState extends State<_BrowseSearchFilterSheet> {
  late BrowseSearchSortType _sortType;
  late HomeCountry _country;
  late BrowseSearchYear _year;

  @override
  void initState() {
    super.initState();
    _sortType = widget.state.searchSortType;
    _country = widget.state.searchCountry;
    _year = widget.state.searchYear;
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
                  'Bộ lọc tìm kiếm',
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
          _BrowseFilterSelector<BrowseSearchSortType>(
            title: 'Kiểu sắp xếp',
            value: _sortType,
            items: BrowseSearchSortType.values,
            labelBuilder: (item) => item.label,
            onChanged: (value) => setState(() => _sortType = value),
          ),
          const SizedBox(height: 12),
          _BrowseFilterSelector<HomeCountry>(
            title: 'Quốc gia',
            value: _country,
            items: widget.state.countries,
            labelBuilder: (item) => item.name,
            onChanged: (value) => setState(() => _country = value),
          ),
          const SizedBox(height: 12),
          _BrowseFilterSelector<BrowseSearchYear>(
            title: 'Năm sản xuất',
            value: _year,
            items: BrowseSearchYear.values,
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
      _sortType = BrowseSearchSortType.desc;
      _country = HomeCountry.all;
      _year = BrowseSearchYear.all;
    });
  }

  void _apply() {
    Navigator.of(context).pop(
      _BrowseSearchFilterResult(
        sortType: _sortType,
        countrySlug: _country.slug,
        year: _year,
      ),
    );
  }
}
