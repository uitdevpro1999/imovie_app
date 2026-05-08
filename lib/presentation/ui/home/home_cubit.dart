import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/home/home_movie.dart';
import 'package:imovie_app/domain/entities/movie_detail/movie_detail.dart';
import 'package:imovie_app/domain/usecases/home/get_home_feed_use_case.dart';
import 'package:imovie_app/domain/usecases/home/get_home_genres_use_case.dart';
import 'package:imovie_app/domain/usecases/home/get_movie_list_use_case.dart';
import 'package:imovie_app/domain/usecases/movie_detail/get_movie_detail_use_case.dart';
import 'package:imovie_app/presentation/ui/home/home_state.dart';

class HomeCubit extends BaseCubit<HomeState> {
  static const _homeListLimit = 10;

  HomeCubit({
    required GetHomeFeedUseCase getHomeFeedUseCase,
    required GetHomeGenresUseCase getHomeGenresUseCase,
    required GetMovieListUseCase getMovieListUseCase,
    required GetMovieDetailUseCase getMovieDetailUseCase,
  }) : _getHomeFeedUseCase = getHomeFeedUseCase,
       _getHomeGenresUseCase = getHomeGenresUseCase,
       _getMovieListUseCase = getMovieListUseCase,
       _getMovieDetailUseCase = getMovieDetailUseCase,
       super(const HomeState());

  final GetHomeFeedUseCase _getHomeFeedUseCase;
  final GetHomeGenresUseCase _getHomeGenresUseCase;
  final GetMovieListUseCase _getMovieListUseCase;
  final GetMovieDetailUseCase _getMovieDetailUseCase;

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

    final feedResult = await _getHomeFeedUseCase(const NoParams());
    final feed = feedResult.map(
      success: (feed) => feed,
      failure: (failure) {
        emit(
          state.copyWith(
            pageStatus: showLoading ? PageStatus.error : state.pageStatus,
            failure: failure,
          ),
        );
        if (!showLoading) {
          showFailureToast(failure);
        }
        return null;
      },
    );
    if (feed == null) {
      return false;
    }

    final tvShows = await _loadMovieList(
      slug: 'tv-shows',
      fallback: state.tvShowMovies,
      showFailure: !showLoading,
    );
    final upcoming = await _loadMovieList(
      slug: 'phim-sap-chieu',
      fallback: state.upcomingMovies,
      showFailure: !showLoading,
    );

    final genresResult = await _getHomeGenresUseCase(const NoParams());
    final success = genresResult.map(
      success: (genres) {
        emit(
          state.copyWith(
            pageStatus: PageStatus.loaded,
            feed: feed,
            genres: genres,
            tvShowMovies: tvShows,
            upcomingMovies: upcoming,
            failure: null,
          ),
        );
        return true;
      },
      failure: (failure) {
        emit(
          state.copyWith(
            pageStatus: showLoading ? PageStatus.error : state.pageStatus,
            failure: failure,
          ),
        );
        if (!showLoading) {
          showFailureToast(failure);
        }
        return false;
      },
    );
    return success;
  }

  Future<bool> refresh() => load(showLoading: false);

  Future<MovieDetail?> loadMovieDetailForAction(String slug) async {
    final normalizedSlug = slug.trim();
    if (normalizedSlug.isEmpty) {
      return null;
    }

    emit(state.copyWith(processing: true, failure: null));
    final result = await _getMovieDetailUseCase(
      GetMovieDetailParams(slug: normalizedSlug),
    );
    if (isClosed) {
      return null;
    }

    return result.map(
      success: (detail) {
        emit(state.copyWith(processing: false, failure: null));
        return detail;
      },
      failure: (failure) {
        emit(state.copyWith(processing: false, failure: failure));
        showFailureToast(failure);
        return null;
      },
    );
  }

  Future<List<HomeMovie>> _loadMovieList({
    required String slug,
    required List<HomeMovie> fallback,
    required bool showFailure,
  }) async {
    final result = await _getMovieListUseCase(
      GetMovieListParams(slug: slug, limit: _homeListLimit),
    );

    return result.map(
      success: (feed) =>
          feed.movies.take(_homeListLimit).toList(growable: false),
      failure: (failure) {
        if (showFailure) {
          showFailureToast(failure);
        }
        return fallback;
      },
    );
  }
}
