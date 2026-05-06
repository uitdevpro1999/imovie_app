import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/home/home_feed.dart';
import 'package:imovie_app/domain/entities/home/home_movie.dart';
import 'package:imovie_app/domain/usecases/home/get_countries_use_case.dart';
import 'package:imovie_app/domain/usecases/home/get_genre_movies_use_case.dart';
import 'package:imovie_app/presentation/ui/genre_movies/genre_movies_state.dart';

class GenreMoviesCubit extends BaseCubit<GenreMoviesState> {
  GenreMoviesCubit({
    required GetGenreMoviesUseCase getGenreMoviesUseCase,
    required GetCountriesUseCase getCountriesUseCase,
    required String slug,
    required String title,
  }) : _getGenreMoviesUseCase = getGenreMoviesUseCase,
       _getCountriesUseCase = getCountriesUseCase,
       super(GenreMoviesState(slug: slug, title: title));

  final GetGenreMoviesUseCase _getGenreMoviesUseCase;
  final GetCountriesUseCase _getCountriesUseCase;

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

    final countriesResult = await _getCountriesUseCase(const NoParams());
    final countries = countriesResult.map(
      success: (countries) => countries,
      failure: (_) => state.countries,
    );
    emit(state.copyWith(countries: countries));

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
        emit(
          state.copyWith(
            loadingMore: false,
            processing: false,
            failure: failure,
          ),
        );
        showFailureToast(failure);
        return false;
      },
    );
  }

  Future<void> applyFilters({
    required GenreSortType sortType,
    required String countrySlug,
    required GenreYear year,
  }) async {
    final country = state.countries.firstWhere(
      (item) => item.slug == countrySlug,
      orElse: () => state.countries.first,
    );
    emit(state.copyWith(sortType: sortType, country: country, year: year));
    await load();
  }

  Future<Result<HomeFeed>> _fetchPage(int page) {
    return _getGenreMoviesUseCase(
      GetGenreMoviesParams(
        slug: state.slug,
        page: page,
        limit: state.pageSize,
        sortType: state.sortType.apiValue,
        country: state.country.slug,
        year: state.year.apiValue,
      ),
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
