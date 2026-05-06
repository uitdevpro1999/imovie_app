import 'dart:async';

import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/events/app_event_bus.dart';
import 'package:imovie_app/core/events/app_library_event.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/library/library_movie.dart';
import 'package:imovie_app/domain/usecases/library/get_library_movies_use_case.dart';
import 'package:imovie_app/domain/usecases/library/remove_movie_from_library_use_case.dart';
import 'package:imovie_app/presentation/ui/library/library_state.dart';

class LibraryCubit extends BaseCubit<LibraryState> {
  LibraryCubit({
    required GetLibraryMoviesUseCase getLibraryMoviesUseCase,
    required RemoveMovieFromLibraryUseCase removeMovieFromLibraryUseCase,
  }) : _getLibraryMoviesUseCase = getLibraryMoviesUseCase,
       _removeMovieFromLibraryUseCase = removeMovieFromLibraryUseCase,
       super(const LibraryState()) {
    _librarySubscription = appEventBus.libraryStream.listen((_) => load());
  }

  final GetLibraryMoviesUseCase _getLibraryMoviesUseCase;
  final RemoveMovieFromLibraryUseCase _removeMovieFromLibraryUseCase;
  late final StreamSubscription<AppLibraryEvent> _librarySubscription;

  @override
  Future<void> initData() => load();

  Future<void> load() async {
    emit(
      state.copyWith(
        pageStatus: state.movies.isEmpty
            ? PageStatus.loading
            : PageStatus.loaded,
        processing: state.movies.isNotEmpty,
        failure: null,
      ),
    );

    final result = await _getLibraryMoviesUseCase(const NoParams());
    result.map(
      success: (movies) {
        emit(
          state.copyWith(
            pageStatus: PageStatus.loaded,
            processing: false,
            failure: null,
            movies: movies,
          ),
        );
      },
      failure: (failure) {
        emit(
          state.copyWith(
            pageStatus: state.movies.isEmpty
                ? PageStatus.error
                : PageStatus.loaded,
            processing: false,
            failure: failure,
          ),
        );
        showFailureToast(failure);
      },
    );
  }

  Future<bool> removeMovie({
    required LibraryMovie item,
    required String successMessage,
  }) async {
    emit(state.copyWith(processing: true, failure: null));

    final result = await _removeMovieFromLibraryUseCase(
      RemoveMovieFromLibraryParams(id: item.id),
    );
    return result.map(
      success: (_) {
        final updatedMovies = state.movies
            .where((movie) => movie.id != item.id)
            .toList(growable: false);
        emit(
          state.copyWith(
            pageStatus: PageStatus.loaded,
            processing: false,
            failure: null,
            movies: updatedMovies,
          ),
        );
        appEventBus.emitLibrary(AppLibraryEvent.changed());
        showSuccessToast(successMessage);
        return true;
      },
      failure: (failure) {
        emit(state.copyWith(processing: false, failure: failure));
        showFailureToast(failure);
        return false;
      },
    );
  }

  @override
  Future<void> close() async {
    await _librarySubscription.cancel();
    return super.close();
  }
}
