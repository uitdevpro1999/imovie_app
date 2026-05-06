import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/home/home_feed.dart';
import 'package:imovie_app/domain/repositories/home_repository.dart';

class SearchMoviesUseCase implements UseCase<HomeFeed, SearchMoviesParams> {
  const SearchMoviesUseCase(this.repository);

  final HomeRepository repository;

  @override
  Future<Result<HomeFeed>> call(SearchMoviesParams params) {
    return repository.searchMovies(keyword: params.keyword);
  }
}

class SearchMoviesParams {
  const SearchMoviesParams({required this.keyword});

  final String keyword;
}
