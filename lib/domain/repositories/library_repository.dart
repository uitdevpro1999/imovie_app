import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/domain/entities/library/library_movie.dart';
import 'package:imovie_app/domain/entities/movie_detail/movie_detail.dart';

abstract interface class LibraryRepository {
  Future<Result<List<LibraryMovie>>> getLibraryMovies();

  Future<Result<LibraryMovie>> addMovie(MovieDetail movie);

  Future<Result<void>> removeMovie(String id);
}
