import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
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
    @Default('') String keyword,
    @Default(false) bool searchLoading,
    @Default(<HomeMovie>[]) List<HomeMovie> searchResults,
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

  List<BrowseMovieViewData> get searchMovieViewData =>
      _toViewData(searchResults);

  List<HomeMovie> get topMoviesOfWeek {
    final copy = List<HomeMovie>.from(feed?.movies ?? const <HomeMovie>[]);
    copy.sort((a, b) => b.rating.compareTo(a.rating));
    return copy.take(3).toList(growable: false);
  }

  List<BrowseMovieViewData> get topMovieViewData =>
      _toViewData(topMoviesOfWeek);

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
