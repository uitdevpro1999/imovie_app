import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/domain/entities/home/home_feed.dart';
import 'package:imovie_app/domain/entities/home/home_genre.dart';
import 'package:imovie_app/domain/entities/home/home_movie.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState implements BaseState {
  const HomeState._();

  const factory HomeState({
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    AppFailure? failure,
    HomeFeed? feed,
    @Default(<HomeGenre>[]) List<HomeGenre> genres,
  }) = _HomeState;

  @override
  HomeState copyWithBase({
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

  HomeMovie? get heroMovie {
    final feed = this.feed;
    if (feed == null) {
      return null;
    }

    final updated = sortedByModifiedMovies;
    return updated.isNotEmpty ? updated.first : feed.featuredMovie;
  }

  HomeMovieViewData? get heroMovieViewData {
    final movie = heroMovie;
    return movie == null ? null : HomeMovieViewData.fromMovie(movie);
  }

  List<HomeMovie> get freshUpdateMovies =>
      sortedByModifiedMovies.take(10).toList(growable: false);

  List<HomeMovieViewData> get freshUpdateMovieViewData =>
      _toViewData(freshUpdateMovies);

  List<HomeMovie> get highestRatedMovies =>
      sortedByRatingMovies.take(10).toList(growable: false);

  List<HomeMovieViewData> get highestRatedMovieViewData =>
      _toViewData(highestRatedMovies);

  List<HomeMovie> get seriesMovies =>
      _moviesByType('series').take(10).toList(growable: false);

  List<HomeMovieViewData> get seriesMovieViewData => _toViewData(seriesMovies);

  List<HomeMovie> get animationMovies =>
      _moviesByType('hoathinh').take(10).toList(growable: false);

  List<HomeMovieViewData> get animationMovieViewData =>
      _toViewData(animationMovies);

  List<HomeMovie> get topMovies =>
      sortedByRatingMovies.take(5).toList(growable: false);

  List<HomeMovieViewData> get topMovieViewData => _toViewData(topMovies);

  bool get hasHiddenGenres => genres.length > 5;

  List<HomeGenre> get visibleGenres => genres.take(5).toList(growable: false);

  List<HomeMovie> get sortedByRatingMovies {
    final copy = List<HomeMovie>.from(feed?.movies ?? const <HomeMovie>[]);
    copy.sort((a, b) => b.rating.compareTo(a.rating));
    return copy;
  }

  List<HomeMovie> get sortedByModifiedMovies {
    final copy = List<HomeMovie>.from(feed?.movies ?? const <HomeMovie>[]);
    copy.sort((a, b) {
      final left = a.modifiedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      final right = b.modifiedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      return right.compareTo(left);
    });
    return copy;
  }

  List<HomeMovie> _moviesByType(String type) {
    return (feed?.movies ?? const <HomeMovie>[])
        .where((movie) => movie.type == type)
        .toList(growable: false);
  }

  List<HomeMovieViewData> _toViewData(List<HomeMovie> movies) {
    return movies.map(HomeMovieViewData.fromMovie).toList(growable: false);
  }
}

class HomeMovieViewData {
  const HomeMovieViewData({
    required this.movie,
    required this.ratingLabel,
    required this.subtitleLabel,
    required this.heroSubtitle,
  });

  factory HomeMovieViewData.fromMovie(HomeMovie movie) {
    return HomeMovieViewData(
      movie: movie,
      ratingLabel: movie.rating.toStringAsFixed(1),
      subtitleLabel: _subtitleLabel(movie),
      heroSubtitle: HomeHeroSubtitleData.fromMovie(movie),
    );
  }

  final HomeMovie movie;
  final String ratingLabel;
  final String subtitleLabel;
  final HomeHeroSubtitleData heroSubtitle;

  String get slug => movie.slug;

  String get title => movie.title;

  String get posterUrl => movie.posterUrl;

  static String _subtitleLabel(HomeMovie movie) {
    if (movie.episodeLabel.trim().isNotEmpty) {
      return movie.episodeLabel;
    }

    return movie.yearLabel;
  }
}

class HomeHeroSubtitleData {
  const HomeHeroSubtitleData({
    required this.type,
    this.primary = '',
    this.secondary = '',
  });

  factory HomeHeroSubtitleData.fromMovie(HomeMovie movie) {
    if (movie.episodeLabel.trim().isNotEmpty &&
        movie.durationLabel.trim().isNotEmpty) {
      return HomeHeroSubtitleData(
        type: HomeHeroSubtitleType.episodeDuration,
        primary: movie.episodeLabel,
        secondary: movie.durationLabel,
      );
    }

    if (movie.languageLabel.trim().isNotEmpty &&
        movie.qualityLabel.trim().isNotEmpty) {
      return HomeHeroSubtitleData(
        type: HomeHeroSubtitleType.languageQuality,
        primary: movie.languageLabel,
        secondary: movie.qualityLabel,
      );
    }

    if (movie.originalTitle.trim().isNotEmpty) {
      return HomeHeroSubtitleData(
        type: HomeHeroSubtitleType.originalTitle,
        primary: movie.originalTitle,
      );
    }

    return const HomeHeroSubtitleData(type: HomeHeroSubtitleType.fallback);
  }

  final HomeHeroSubtitleType type;
  final String primary;
  final String secondary;
}

enum HomeHeroSubtitleType {
  episodeDuration,
  languageQuality,
  originalTitle,
  fallback,
}
