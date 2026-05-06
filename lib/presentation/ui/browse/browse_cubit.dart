import 'dart:async';

import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/home/home_country.dart';
import 'package:imovie_app/domain/entities/home/home_movie.dart';
import 'package:imovie_app/domain/usecases/home/get_countries_use_case.dart';
import 'package:imovie_app/domain/usecases/home/get_home_feed_use_case.dart';
import 'package:imovie_app/domain/usecases/home/get_home_genres_use_case.dart';
import 'package:imovie_app/domain/usecases/home/search_movies_use_case.dart';
import 'package:imovie_app/presentation/ui/browse/browse_state.dart';

class BrowseCubit extends BaseCubit<BrowseState> {
  BrowseCubit({
    required GetHomeFeedUseCase getHomeFeedUseCase,
    required GetHomeGenresUseCase getHomeGenresUseCase,
    required GetCountriesUseCase getCountriesUseCase,
    required SearchMoviesUseCase searchMoviesUseCase,
  }) : _getHomeFeedUseCase = getHomeFeedUseCase,
       _getHomeGenresUseCase = getHomeGenresUseCase,
       _getCountriesUseCase = getCountriesUseCase,
       _searchMoviesUseCase = searchMoviesUseCase,
       super(const BrowseState());

  final GetHomeFeedUseCase _getHomeFeedUseCase;
  final GetHomeGenresUseCase _getHomeGenresUseCase;
  final GetCountriesUseCase _getCountriesUseCase;
  final SearchMoviesUseCase _searchMoviesUseCase;
  Timer? _searchDebounce;

  @override
  Future<void> initData() async {
    await load();
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
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
            pageStatus: showLoading && state.feed == null
                ? PageStatus.error
                : PageStatus.loaded,
            failure: failure,
          ),
        );
        showFailureToast(failure);
        return null;
      },
    );
    if (feed == null) {
      return false;
    }

    final countriesResult = await _getCountriesUseCase(const NoParams());
    final countries = countriesResult.map(
      success: (countries) => countries,
      failure: (_) => state.countries,
    );

    final genresResult = await _getHomeGenresUseCase(const NoParams());
    return genresResult.map(
      success: (genres) {
        emit(
          state.copyWith(
            pageStatus: PageStatus.loaded,
            feed: feed,
            genres: genres,
            countries: countries,
            failure: null,
          ),
        );
        return true;
      },
      failure: (failure) {
        emit(
          state.copyWith(
            pageStatus: showLoading && state.genres.isEmpty
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

  Future<bool> refresh() {
    if (state.hasKeyword) {
      return _search(keyword: state.keyword, page: 1, showLoading: false);
    }

    return load(showLoading: false);
  }

  void onKeywordChanged(String value) {
    final keyword = value.trim();
    _searchDebounce?.cancel();

    if (keyword.isEmpty) {
      emit(
        state.copyWith(
          keyword: '',
          searchLoading: false,
          searchLoadingMore: false,
          searchResults: const [],
          searchPage: 1,
          searchTotalItems: 0,
          failure: null,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        keyword: keyword,
        searchLoading: true,
        searchLoadingMore: false,
        searchResults: const [],
        searchPage: 1,
        searchTotalItems: 0,
        failure: null,
      ),
    );
    _searchDebounce = Timer(
      const Duration(milliseconds: 450),
      () => _search(keyword: keyword, page: 1, showLoading: false),
    );
  }

  Future<void> applySearchFilters({
    required BrowseSearchSortType sortType,
    required String countrySlug,
    required BrowseSearchYear year,
  }) async {
    final country = state.countries.firstWhere(
      (item) => item.slug == countrySlug,
      orElse: () => HomeCountry.all,
    );
    emit(
      state.copyWith(
        searchSortType: sortType,
        searchCountry: country,
        searchYear: year,
        searchLoading: state.hasKeyword,
        searchLoadingMore: false,
        searchPage: 1,
        searchTotalItems: state.hasKeyword ? 0 : state.searchTotalItems,
        failure: null,
      ),
    );

    _searchDebounce?.cancel();
    if (state.hasKeyword) {
      await _search(keyword: state.keyword, page: 1, showLoading: false);
    }
  }

  Future<bool> loadMoreSearch() async {
    if (!state.searchCanLoadMore) {
      return true;
    }

    return _search(
      keyword: state.keyword,
      page: state.searchPage + 1,
      showLoading: false,
    );
  }

  Future<bool> _search({
    required String keyword,
    required int page,
    required bool showLoading,
  }) async {
    if (page == 1 && showLoading) {
      emit(
        state.copyWith(
          searchLoading: true,
          searchLoadingMore: false,
          failure: null,
        ),
      );
    } else if (page > 1) {
      emit(state.copyWith(searchLoadingMore: true, failure: null));
    }

    final result = await _searchMoviesUseCase(
      SearchMoviesParams(
        keyword: keyword,
        page: page,
        limit: state.searchPageSize,
        sortType: state.searchSortType.apiValue,
        country: state.searchCountry.slug,
        year: state.searchYear.apiValue,
      ),
    );
    return result.map(
      success: (feed) {
        emit(
          state.copyWith(
            keyword: keyword,
            searchLoading: false,
            searchLoadingMore: false,
            searchResults: page == 1
                ? feed.movies
                : _mergeMovies(state.searchResults, feed.movies),
            searchPage: feed.currentPage,
            searchPageSize: feed.itemsPerPage,
            searchTotalItems: feed.totalItems,
            failure: null,
          ),
        );
        return true;
      },
      failure: (failure) {
        if (page == 1 && (showLoading || state.searchResults.isEmpty)) {
          emit(
            state.copyWith(
              keyword: keyword,
              searchLoading: false,
              searchLoadingMore: false,
              searchResults: const [],
              searchPage: 1,
              searchTotalItems: 0,
              failure: failure,
            ),
          );
        } else {
          emit(
            state.copyWith(
              keyword: keyword,
              searchLoading: false,
              searchLoadingMore: false,
              failure: null,
            ),
          );
        }
        showFailureToast(failure);
        return false;
      },
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
