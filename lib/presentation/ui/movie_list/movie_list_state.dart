import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imovie_app/config/refresh/imovie_refresh_config.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/domain/entities/home/home_movie.dart';

part 'movie_list_state.freezed.dart';

@freezed
abstract class MovieListState with _$MovieListState implements BaseState {
  const MovieListState._();

  const factory MovieListState({
    required String slug,
    required String title,
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    AppFailure? failure,
    @Default(<HomeMovie>[]) List<HomeMovie> movies,
    @Default(1) int page,
    @Default(IMovieRefreshConfig.pageSize) int pageSize,
    @Default(0) int totalItems,
    @Default(false) bool loadingMore,
  }) = _MovieListState;

  List<MovieListItemViewData> get movieViewData {
    return movies.map(MovieListItemViewData.fromMovie).toList(growable: false);
  }

  bool get hasMore => movies.length < totalItems;

  String get resultSummary => totalItems > 0
      ? '${movies.length}/$totalItems phim'
      : '${movies.length} phim';

  @override
  MovieListState copyWithBase({
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

class MovieListItemViewData {
  const MovieListItemViewData({
    required this.movie,
    required this.ratingLabel,
    required this.subtitle,
    required this.tags,
  });

  factory MovieListItemViewData.fromMovie(HomeMovie movie) {
    final tags = <String>[
      ...movie.categories,
      if (movie.qualityLabel.trim().isNotEmpty) movie.qualityLabel,
      if (movie.languageLabel.trim().isNotEmpty) movie.languageLabel,
    ];

    return MovieListItemViewData(
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
