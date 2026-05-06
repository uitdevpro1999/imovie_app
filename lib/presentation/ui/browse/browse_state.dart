import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imovie_app/config/refresh/imovie_refresh_config.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/domain/entities/home/home_country.dart';
import 'package:imovie_app/domain/entities/home/home_feed.dart';
import 'package:imovie_app/domain/entities/home/home_genre.dart';
import 'package:imovie_app/domain/entities/home/home_movie.dart';

part 'browse_state.freezed.dart';

@freezed
abstract class BrowseState with _$BrowseState implements BaseState {
  const BrowseState._();

  const factory BrowseState({
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    AppFailure? failure,
    HomeFeed? feed,
    @Default(<HomeGenre>[]) List<HomeGenre> genres,
    @Default(<HomeCountry>[HomeCountry.all]) List<HomeCountry> countries,
    @Default('') String keyword,
    @Default(false) bool searchLoading,
    @Default(false) bool searchLoadingMore,
    @Default(<HomeMovie>[]) List<HomeMovie> searchResults,
    @Default(1) int searchPage,
    @Default(IMovieRefreshConfig.pageSize) int searchPageSize,
    @Default(0) int searchTotalItems,
    @Default(BrowseSearchSortType.desc) BrowseSearchSortType searchSortType,
    @Default(HomeCountry.all) HomeCountry searchCountry,
    @Default(BrowseSearchYear.all) BrowseSearchYear searchYear,
  }) = _BrowseState;

  @override
  BrowseState copyWithBase({
    PageStatus? pageStatus,
    bool? processing,
    AppFailure? failure,
    bool clearFailure = false,
  }) {
    return copyWith(
      pageStatus: pageStatus ?? this.pageStatus,
      processing: processing ?? this.processing,
      failure: clearFailure ? null : failure ?? this.failure,
    );
  }

  bool get hasKeyword => keyword.trim().isNotEmpty;

  bool get showSearchResults => hasKeyword;

  bool get searchHasMore => searchResults.length < searchTotalItems;

  bool get searchCanLoadMore =>
      showSearchResults && searchHasMore && !searchLoadingMore;

  int get activeSearchFilterCount {
    var count = 0;
    if (searchSortType != BrowseSearchSortType.desc) {
      count++;
    }
    if (searchCountry.slug.isNotEmpty) {
      count++;
    }
    if (searchYear != BrowseSearchYear.all) {
      count++;
    }
    return count;
  }

  List<BrowseFilterChipData> get activeSearchFilterChips {
    return [
      if (searchSortType != BrowseSearchSortType.desc)
        BrowseFilterChipData(label: 'Sắp xếp', value: searchSortType.label),
      if (searchCountry.slug.isNotEmpty)
        BrowseFilterChipData(label: 'Quốc gia', value: searchCountry.name),
      if (searchYear != BrowseSearchYear.all)
        BrowseFilterChipData(label: 'Năm', value: searchYear.label),
    ];
  }

  List<BrowseMovieViewData> get searchMovieViewData =>
      _toViewData(searchResults);

  List<HomeGenre> get visibleGenres => genres.take(20).toList(growable: false);

  bool get hasHiddenGenres => genres.length > visibleGenres.length;

  List<HomeMovie> get popularMovies {
    final copy = List<HomeMovie>.from(feed?.movies ?? const <HomeMovie>[]);
    copy.sort((a, b) {
      final left = a.modifiedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      final right = b.modifiedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      return right.compareTo(left);
    });
    return copy.take(10).toList(growable: false);
  }

  List<BrowseMovieViewData> get popularMovieViewData =>
      _toViewData(popularMovies);

  List<BrowseMovieViewData> _toViewData(List<HomeMovie> movies) {
    return movies.map(BrowseMovieViewData.fromMovie).toList(growable: false);
  }
}

class BrowseFilterChipData {
  const BrowseFilterChipData({required this.label, required this.value});

  final String label;
  final String value;
}

enum BrowseSearchSortType {
  desc(apiValue: 'desc', label: 'Mới nhất'),
  asc(apiValue: 'asc', label: 'Cũ nhất');

  const BrowseSearchSortType({required this.apiValue, required this.label});

  final String apiValue;
  final String label;
}

enum BrowseSearchYear {
  all(apiValue: '', label: 'Tất cả năm'),
  y2026(apiValue: '2026', label: '2026'),
  y2025(apiValue: '2025', label: '2025'),
  y2024(apiValue: '2024', label: '2024'),
  y2023(apiValue: '2023', label: '2023'),
  y2022(apiValue: '2022', label: '2022'),
  y2021(apiValue: '2021', label: '2021'),
  y2020(apiValue: '2020', label: '2020'),
  y2019(apiValue: '2019', label: '2019'),
  y2018(apiValue: '2018', label: '2018'),
  y2017(apiValue: '2017', label: '2017'),
  y2016(apiValue: '2016', label: '2016'),
  y2015(apiValue: '2015', label: '2015'),
  y2014(apiValue: '2014', label: '2014'),
  y2013(apiValue: '2013', label: '2013'),
  y2012(apiValue: '2012', label: '2012'),
  y2011(apiValue: '2011', label: '2011'),
  y2010(apiValue: '2010', label: '2010');

  const BrowseSearchYear({required this.apiValue, required this.label});

  final String apiValue;
  final String label;
}

class BrowseMovieViewData {
  const BrowseMovieViewData({
    required this.movie,
    required this.ratingLabel,
    required this.subtitleLabel,
    required this.tags,
  });

  factory BrowseMovieViewData.fromMovie(HomeMovie movie) {
    final tags = <String>[
      ...movie.categories,
      if (movie.qualityLabel.trim().isNotEmpty) movie.qualityLabel,
      if (movie.languageLabel.trim().isNotEmpty) movie.languageLabel,
    ];

    return BrowseMovieViewData(
      movie: movie,
      ratingLabel: movie.rating.toStringAsFixed(1),
      subtitleLabel: movie.yearLabel,
      tags: tags.take(4).toList(growable: false),
    );
  }

  final HomeMovie movie;
  final String ratingLabel;
  final String subtitleLabel;
  final List<String> tags;
}
