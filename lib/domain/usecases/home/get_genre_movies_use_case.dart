import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/home/home_feed.dart';
import 'package:imovie_app/domain/repositories/home_repository.dart';

class GetGenreMoviesUseCase implements UseCase<HomeFeed, GetGenreMoviesParams> {
  const GetGenreMoviesUseCase(this.repository);

  final HomeRepository repository;

  @override
  Future<Result<HomeFeed>> call(GetGenreMoviesParams params) {
    return repository.getMoviesByGenre(
      slug: params.slug,
      page: params.page,
      limit: 24,
      sortField: 'modified.time',
      sortType: params.sortType,
      country: params.country,
      year: params.year,
    );
  }
}

class GetGenreMoviesParams {
  const GetGenreMoviesParams({
    required this.slug,
    this.page = 1,
    this.sortType = 'desc',
    this.country = '',
    this.year = '',
  });

  final String slug;
  final int page;
  final String sortType;
  final String country;
  final String year;
}
