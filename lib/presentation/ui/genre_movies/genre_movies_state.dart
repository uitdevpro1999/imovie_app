import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/domain/entities/home/home_country.dart';
import 'package:imovie_app/domain/entities/home/home_movie.dart';

part 'genre_movies_state.freezed.dart';

@freezed
abstract class GenreMoviesState with _$GenreMoviesState implements BaseState {
  const GenreMoviesState._();

  const factory GenreMoviesState({
    required String slug,
    required String title,
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    AppFailure? failure,
    @Default(<HomeMovie>[]) List<HomeMovie> movies,
    @Default(<HomeCountry>[HomeCountry.all]) List<HomeCountry> countries,
    @Default(1) int page,
    @Default(GenreSortType.desc) GenreSortType sortType,
    @Default(HomeCountry.all) HomeCountry country,
    @Default(GenreYear.all) GenreYear year,
    @Default(0) int totalItems,
    @Default(false) bool loadingMore,
  }) = _GenreMoviesState;

  List<GenreMovieViewData> get movieViewData {
    return movies.map(GenreMovieViewData.fromMovie).toList(growable: false);
  }

  bool get hasMore => movies.length < totalItems;

  String get resultSummary => totalItems > 0
      ? '${movies.length}/$totalItems phim'
      : '${movies.length} phim';

  List<GenreFilterChipData> get activeFilterChips {
    return [
      GenreFilterChipData(label: 'Sắp xếp', value: sortType.label),
      if (country.slug.isNotEmpty)
        GenreFilterChipData(label: 'Quốc gia', value: country.name),
      if (year != GenreYear.all)
        GenreFilterChipData(label: 'Năm', value: year.label),
    ];
  }

  @override
  GenreMoviesState copyWithBase({
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
}

class GenreFilterChipData {
  const GenreFilterChipData({required this.label, required this.value});

  final String label;
  final String value;
}

enum GenreSortType {
  desc(apiValue: 'desc', label: 'Mới nhất'),
  asc(apiValue: 'asc', label: 'Cũ nhất');

  const GenreSortType({required this.apiValue, required this.label});

  final String apiValue;
  final String label;
}

enum GenreYear {
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

  const GenreYear({required this.apiValue, required this.label});

  final String apiValue;
  final String label;
}

class GenreMovieViewData {
  const GenreMovieViewData({
    required this.movie,
    required this.ratingLabel,
    required this.subtitle,
    required this.tags,
  });

  factory GenreMovieViewData.fromMovie(HomeMovie movie) {
    final tags = <String>[
      ...movie.categories,
      if (movie.qualityLabel.trim().isNotEmpty) movie.qualityLabel,
      if (movie.languageLabel.trim().isNotEmpty) movie.languageLabel,
    ];

    return GenreMovieViewData(
      movie: movie,
      ratingLabel: movie.rating.toStringAsFixed(1),
      subtitle: _subtitle(movie),
      tags: tags.take(4).toList(growable: false),
    );
  }

  final HomeMovie movie;
  final String ratingLabel;
  final String subtitle;
  final List<String> tags;

  static String _subtitle(HomeMovie movie) {
    if (movie.durationLabel.trim().isNotEmpty) {
      return movie.durationLabel;
    }

    if (movie.episodeLabel.trim().isNotEmpty) {
      return movie.episodeLabel;
    }

    return movie.yearLabel;
  }
}
