import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/domain/entities/movie_detail/movie_detail.dart';

abstract interface class MovieDetailRepository {
  Future<Result<MovieDetail>> getMovieDetail(String slug);
}
