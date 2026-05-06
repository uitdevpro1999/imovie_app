import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/home/home_feed.dart';
import 'package:imovie_app/domain/repositories/home_repository.dart';

class GetMovieListUseCase implements UseCase<HomeFeed, GetMovieListParams> {
  const GetMovieListUseCase(this.repository);

  final HomeRepository repository;

  @override
  Future<Result<HomeFeed>> call(GetMovieListParams params) {
    return repository.getMoviesByList(
      slug: params.slug,
      page: params.page,
      limit: params.limit,
      sortField: 'modified.time',
      sortType: 'desc',
    );
  }
}

class GetMovieListParams {
  const GetMovieListParams({
    required this.slug,
    this.page = 1,
    this.limit = 24,
  });

  final String slug;
  final int page;
  final int limit;
}
