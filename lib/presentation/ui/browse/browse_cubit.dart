import 'dart:async';

import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/usecases/home/get_home_feed_use_case.dart';
import 'package:imovie_app/domain/usecases/home/get_home_genres_use_case.dart';
import 'package:imovie_app/domain/usecases/home/search_movies_use_case.dart';
import 'package:imovie_app/presentation/ui/browse/browse_state.dart';

class BrowseCubit extends BaseCubit<BrowseState> {
  BrowseCubit({
    required GetHomeFeedUseCase getHomeFeedUseCase,
    required GetHomeGenresUseCase getHomeGenresUseCase,
    required SearchMoviesUseCase searchMoviesUseCase,
  }) : _getHomeFeedUseCase = getHomeFeedUseCase,
       _getHomeGenresUseCase = getHomeGenresUseCase,
       _searchMoviesUseCase = searchMoviesUseCase,
       super(const BrowseState());

  final GetHomeFeedUseCase _getHomeFeedUseCase;
  final GetHomeGenresUseCase _getHomeGenresUseCase;
  final SearchMoviesUseCase _searchMoviesUseCase;
  Timer? _searchDebounce;

  @override
  Future<void> initData() => load();

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }

  Future<void> load() async {
    emit(
      state.copyWithBase(pageStatus: PageStatus.loading, clearFailure: true),
    );

    final feedResult = await _getHomeFeedUseCase(const NoParams());
    final feed = feedResult.map(
      success: (feed) => feed,
      failure: (failure) {
        emit(state.copyWith(pageStatus: PageStatus.error, failure: failure));
        return null;
      },
    );
    if (feed == null) {
      return;
    }

    final genresResult = await _getHomeGenresUseCase(const NoParams());
    emit(
      genresResult.map(
        success: (genres) => state.copyWith(
          pageStatus: PageStatus.loaded,
          feed: feed,
          genres: genres,
          failure: null,
        ),
        failure: (failure) =>
            state.copyWith(pageStatus: PageStatus.error, failure: failure),
      ),
    );
  }

  void onKeywordChanged(String value) {
    final keyword = value.trim();
    _searchDebounce?.cancel();

    if (keyword.isEmpty) {
      emit(
        state.copyWith(
          keyword: '',
          searchLoading: false,
          searchResults: const [],
          failure: null,
        ),
      );
      return;
    }

    emit(state.copyWith(keyword: keyword, searchLoading: true, failure: null));
    _searchDebounce = Timer(
      const Duration(milliseconds: 450),
      () => _search(keyword),
    );
  }

  Future<void> _search(String keyword) async {
    final result = await _searchMoviesUseCase(
      SearchMoviesParams(keyword: keyword),
    );
    emit(
      result.map(
        success: (feed) => state.copyWith(
          keyword: keyword,
          searchLoading: false,
          searchResults: feed.movies,
          failure: null,
        ),
        failure: (failure) => state.copyWith(
          keyword: keyword,
          searchLoading: false,
          searchResults: const [],
          failure: failure,
        ),
      ),
    );
  }
}
