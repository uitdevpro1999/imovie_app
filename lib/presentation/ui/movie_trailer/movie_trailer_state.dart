import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';

part 'movie_trailer_state.freezed.dart';

@freezed
abstract class MovieTrailerState with _$MovieTrailerState implements BaseState {
  const MovieTrailerState._();

  const factory MovieTrailerState({
    required String title,
    required String trailerUrl,
    @Default('') String videoId,
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    AppFailure? failure,
  }) = _MovieTrailerState;

  @override
  MovieTrailerState copyWithBase({
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
