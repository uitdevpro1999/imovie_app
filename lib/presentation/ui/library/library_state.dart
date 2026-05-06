import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/domain/entities/library/library_movie.dart';

part 'library_state.freezed.dart';

@freezed
abstract class LibraryState with _$LibraryState implements BaseState {
  const LibraryState._();

  const factory LibraryState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    AppFailure? failure,
    @Default(<LibraryMovie>[]) List<LibraryMovie> movies,
  }) = _LibraryState;

  @override
  LibraryState copyWithBase({
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
