import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/domain/entities/home/home_movie.dart';
import 'package:imovie_app/domain/entities/movie_detail/movie_detail.dart';

part 'movie_detail_state.freezed.dart';

@freezed
abstract class MovieDetailState with _$MovieDetailState implements BaseState {
  const MovieDetailState._();

  const factory MovieDetailState({
    required String slug,
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(false) bool addingToLibrary,
    @Default(false) bool addedToLibrary,
    AppFailure? failure,
    MovieDetail? detail,
    @Default(<HomeMovie>[]) List<HomeMovie> relatedMovies,
  }) = _MovieDetailState;

  @override
  MovieDetailState copyWithBase({
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

  String get ratingLabel => detail?.rating.toStringAsFixed(1) ?? '0.0';

  String get originalTitleValue =>
      _valueOrFallback(detail?.originalTitle ?? '');

  String get statusValue => _valueOrFallback(detail?.status ?? '');

  String get yearValue => _valueOrFallback(detail?.yearLabel ?? '');

  String get runtimeValue => _valueOrFallback(detail?.runtime ?? '');

  String get languageValue => _valueOrFallback(detail?.language ?? '');

  String get qualityValue => _valueOrFallback(detail?.quality ?? '');

  String get directorsValue =>
      _valueOrFallback(detail?.directors.join(', ') ?? '');

  List<MovieDetailActorViewData> get actorViewData {
    return (detail?.actors ?? const [])
        .map(
          (actor) => MovieDetailActorViewData(
            name: actor.name,
            avatarUrl: actor.hasProfileImage
                ? actor.profileUrl
                : 'https://ui-avatars.com/api/?name=${Uri.encodeComponent(actor.name)}&background=2b2b2b&color=ffffff&size=128',
          ),
        )
        .toList(growable: false);
  }

  int get recommendedMovieCount => relatedMovies.length.clamp(0, 10);

  List<MovieDetailRecommendedMovieViewData> get recommendedMovieViewData {
    return relatedMovies
        .take(recommendedMovieCount)
        .map(MovieDetailRecommendedMovieViewData.fromMovie)
        .toList(growable: false);
  }

  String _valueOrFallback(String value) {
    return value.trim().isEmpty ? '-' : value;
  }
}

class MovieDetailActorViewData {
  const MovieDetailActorViewData({required this.name, required this.avatarUrl});

  final String name;
  final String avatarUrl;
}

class MovieDetailRecommendedMovieViewData {
  const MovieDetailRecommendedMovieViewData({
    required this.movie,
    required this.ratingLabel,
  });

  factory MovieDetailRecommendedMovieViewData.fromMovie(HomeMovie movie) {
    return MovieDetailRecommendedMovieViewData(
      movie: movie,
      ratingLabel: movie.rating.toStringAsFixed(1),
    );
  }

  final HomeMovie movie;
  final String ratingLabel;
}
