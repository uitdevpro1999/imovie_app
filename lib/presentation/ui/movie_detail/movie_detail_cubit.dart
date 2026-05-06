import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/domain/entities/home/home_movie.dart';
import 'package:imovie_app/domain/usecases/movie_detail/get_movie_detail_use_case.dart';
import 'package:imovie_app/presentation/ui/movie_detail/movie_detail_state.dart';

class MovieDetailCubit extends BaseCubit<MovieDetailState> {
  MovieDetailCubit({
    required GetMovieDetailUseCase getMovieDetailUseCase,
    required String slug,
    List<HomeMovie> relatedMovies = const [],
  }) : _getMovieDetailUseCase = getMovieDetailUseCase,
       _initialRelatedMovies = relatedMovies,
       super(MovieDetailState(slug: slug));

  final GetMovieDetailUseCase _getMovieDetailUseCase;
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

  List<HomeMovie> _filteredRelatedMovies(List<HomeMovie> movies) {
    return movies
        .where((movie) => movie.slug != state.slug)
        .take(10)
        .toList(growable: false);
  }
}
