import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/home/home_feed.dart';
import 'package:imovie_app/domain/repositories/home_repository.dart';

class SearchMoviesUseCase implements UseCase<HomeFeed, SearchMoviesParams> {
  const SearchMoviesUseCase(this.repository);

  final HomeRepository repository;

  @override
  Future<Result<HomeFeed>> call(SearchMoviesParams params) {
    return repository.searchMovies(
      keyword: params.keyword,
      page: params.page,
      limit: params.limit,
      sortField: 'modified.time',
      sortType: params.sortType,
      country: params.country,
      year: params.year,
    );
  }
}

class SearchMoviesParams {
  const SearchMoviesParams({
    required this.keyword,
    this.page = 1,
    this.limit = 24,
    this.sortType = 'desc',
    this.country = '',
    this.year = '',
  });

  final String keyword;
  final int page;
  final int limit;
  final String sortType;
  final String country;
  final String year;
}
