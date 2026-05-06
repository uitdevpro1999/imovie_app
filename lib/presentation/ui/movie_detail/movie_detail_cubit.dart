import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/events/app_event_bus.dart';
import 'package:imovie_app/core/events/app_library_event.dart';
import 'package:imovie_app/domain/entities/home/home_movie.dart';
import 'package:imovie_app/domain/usecases/library/add_movie_to_library_use_case.dart';
import 'package:imovie_app/domain/usecases/movie_detail/get_movie_detail_use_case.dart';
import 'package:imovie_app/presentation/ui/movie_detail/movie_detail_state.dart';

class MovieDetailCubit extends BaseCubit<MovieDetailState> {
  MovieDetailCubit({
    required GetMovieDetailUseCase getMovieDetailUseCase,
    required AddMovieToLibraryUseCase addMovieToLibraryUseCase,
    required String slug,
    List<HomeMovie> relatedMovies = const [],
  }) : _getMovieDetailUseCase = getMovieDetailUseCase,
       _addMovieToLibraryUseCase = addMovieToLibraryUseCase,
       _initialRelatedMovies = relatedMovies,
       super(MovieDetailState(slug: slug));

  final GetMovieDetailUseCase _getMovieDetailUseCase;
  final AddMovieToLibraryUseCase _addMovieToLibraryUseCase;
  final List<HomeMovie> _initialRelatedMovies;

  @override
  Future<void> initData() => load();

  Future<void> load() async {
    emit(
      state.copyWith(
        pageStatus: PageStatus.loading,
        relatedMovies: _filteredRelatedMovies(_initialRelatedMovies),
        failure: null,
      ),
    );

    final result = await _getMovieDetailUseCase(
      GetMovieDetailParams(slug: state.slug),
    );

    emit(
      result.map(
        success: (detail) => state.copyWith(
          pageStatus: PageStatus.loaded,
          detail: detail,
          relatedMovies: _filteredRelatedMovies(_initialRelatedMovies),
          failure: null,
        ),
        failure: (failure) =>
            state.copyWith(pageStatus: PageStatus.error, failure: failure),
      ),
    );
  }

  Future<void> addToLibrary({
    required MovieDetailLibraryMessages messages,
  }) async {
    final detail = state.detail;
    if (detail == null) {
      final failure = AppFailure.unknown(messages.emptyMovie);
      emit(state.copyWith(failure: failure));
      showFailureToast(failure);
      return;
    }

    emit(state.copyWith(addingToLibrary: true, failure: null));

    final result = await _addMovieToLibraryUseCase(
      AddMovieToLibraryParams(movie: detail),
    );
    result.map(
      success: (_) {
        emit(
          state.copyWith(
            addingToLibrary: false,
            addedToLibrary: true,
            failure: null,
          ),
        );
        appEventBus.emitLibrary(AppLibraryEvent.changed());
        showSuccessToast(messages.success);
      },
      failure: (failure) {
        emit(state.copyWith(addingToLibrary: false, failure: failure));
        showFailureToast(failure);
      },
    );
  }

  List<HomeMovie> _filteredRelatedMovies(List<HomeMovie> movies) {
    return movies
        .where((movie) => movie.slug != state.slug)
        .take(10)
        .toList(growable: false);
  }
}

class MovieDetailLibraryMessages {
  const MovieDetailLibraryMessages({
    required this.emptyMovie,
    required this.success,
  });

  final String emptyMovie;
  final String success;
}
