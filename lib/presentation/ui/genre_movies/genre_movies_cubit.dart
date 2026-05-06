import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/home/home_feed.dart';
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
  Future<void> initData() => load();

  Future<void> load() async {
    emit(
      state.copyWithBase(pageStatus: PageStatus.loading, clearFailure: true),
    );

    final countriesResult = await _getCountriesUseCase(const NoParams());
    final countries = countriesResult.map(
      success: (countries) => countries,
      failure: (_) => state.countries,
    );
    emit(state.copyWith(countries: countries));

    final result = await _fetchPage(1);

    emit(
      result.map(
        success: (feed) => state.copyWith(
          pageStatus: PageStatus.loaded,
          movies: feed.movies,
          page: feed.currentPage,
          totalItems: feed.totalItems,
          failure: null,
        ),
        failure: (failure) =>
            state.copyWith(pageStatus: PageStatus.error, failure: failure),
      ),
    );
  }

  Future<void> loadMore() async {
    if (state.loadingMore || !state.hasMore) {
      return;
    }

    emit(state.copyWith(loadingMore: true, failure: null));
    final result = await _fetchPage(state.page + 1);

    emit(
      result.map(
        success: (feed) => state.copyWith(
          movies: [...state.movies, ...feed.movies],
          page: feed.currentPage,
          totalItems: feed.totalItems,
          loadingMore: false,
          failure: null,
        ),
        failure: (failure) => state.copyWith(
          loadingMore: false,
          processing: false,
          failure: failure,
        ),
      ),
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
        sortType: state.sortType.apiValue,
        country: state.country.slug,
        year: state.year.apiValue,
      ),
    );
  }
}
