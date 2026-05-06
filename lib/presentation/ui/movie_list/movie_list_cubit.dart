import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/domain/entities/home/home_feed.dart';
import 'package:imovie_app/domain/entities/home/home_movie.dart';
import 'package:imovie_app/domain/usecases/home/get_movie_list_use_case.dart';
import 'package:imovie_app/presentation/ui/movie_list/movie_list_state.dart';

class MovieListCubit extends BaseCubit<MovieListState> {
  MovieListCubit({
    required GetMovieListUseCase getMovieListUseCase,
    required String slug,
    required String title,
  }) : _getMovieListUseCase = getMovieListUseCase,
       super(MovieListState(slug: slug, title: title));

  final GetMovieListUseCase _getMovieListUseCase;

  @override
  Future<void> initData() async {
    await load();
  }

  Future<bool> load({bool showLoading = true}) async {
    if (showLoading) {
      emit(
        state.copyWithBase(pageStatus: PageStatus.loading, clearFailure: true),
      );
    } else {
      emit(state.copyWith(failure: null));
    }

    final result = await _fetchPage(1);
    return result.map(
      success: (feed) {
        emit(
          state.copyWith(
            pageStatus: PageStatus.loaded,
            movies: feed.movies,
            page: feed.currentPage,
            pageSize: feed.itemsPerPage,
            totalItems: feed.totalItems,
            failure: null,
          ),
        );
        return true;
      },
      failure: (failure) {
        emit(
          state.copyWith(
            pageStatus: showLoading && state.movies.isEmpty
                ? PageStatus.error
                : PageStatus.loaded,
            failure: failure,
          ),
        );
        showFailureToast(failure);
        return false;
      },
    );
  }

  Future<bool> refresh() => load(showLoading: false);

  Future<bool> loadMore() async {
    if (state.loadingMore || !state.hasMore) {
      return true;
    }

    emit(state.copyWith(loadingMore: true, failure: null));
    final result = await _fetchPage(state.page + 1);
    return result.map(
      success: (feed) {
        emit(
          state.copyWith(
            movies: _mergeMovies(state.movies, feed.movies),
            page: feed.currentPage,
            pageSize: feed.itemsPerPage,
            totalItems: feed.totalItems,
            loadingMore: false,
            failure: null,
          ),
        );
        return true;
      },
      failure: (failure) {
        emit(state.copyWith(loadingMore: false, failure: failure));
        showFailureToast(failure);
        return false;
      },
    );
  }

  Future<Result<HomeFeed>> _fetchPage(int page) {
    return _getMovieListUseCase(
      GetMovieListParams(slug: state.slug, page: page, limit: state.pageSize),
    );
  }

  List<HomeMovie> _mergeMovies(List<HomeMovie> current, List<HomeMovie> next) {
    final slugs = current.map((movie) => movie.slug).toSet();
    final uniqueNext = next
        .where((movie) => slugs.add(movie.slug))
        .toList(growable: false);
    return [...current, ...uniqueNext];
  }
}
