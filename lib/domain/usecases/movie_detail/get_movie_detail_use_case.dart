import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/movie_detail/movie_detail.dart';
import 'package:imovie_app/domain/repositories/movie_detail_repository.dart';

class GetMovieDetailParams {
  const GetMovieDetailParams({required this.slug});

  final String slug;
}

class GetMovieDetailUseCase
    implements UseCase<MovieDetail, GetMovieDetailParams> {
  const GetMovieDetailUseCase(this.repository);

  final MovieDetailRepository repository;

  @override
  Future<Result<MovieDetail>> call(GetMovieDetailParams params) {
    return repository.getMovieDetail(params.slug);
  }
}
