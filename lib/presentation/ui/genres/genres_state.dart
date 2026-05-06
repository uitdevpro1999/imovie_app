import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/domain/entities/home/home_genre.dart';

part 'genres_state.freezed.dart';

@freezed
abstract class GenresState with _$GenresState implements BaseState {
  const GenresState._();

  const factory GenresState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    AppFailure? failure,
    @Default(<HomeGenre>[]) List<HomeGenre> genres,
  }) = _GenresState;

  @override
  GenresState copyWithBase({
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
