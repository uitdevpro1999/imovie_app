import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/library/library_movie.dart';
import 'package:imovie_app/domain/entities/movie_detail/movie_detail.dart';
import 'package:imovie_app/domain/repositories/library_repository.dart';

class AddMovieToLibraryParams {
  const AddMovieToLibraryParams({required this.movie});

  final MovieDetail movie;
}

class AddMovieToLibraryUseCase
    implements UseCase<LibraryMovie, AddMovieToLibraryParams> {
  const AddMovieToLibraryUseCase(this.repository);

  final LibraryRepository repository;

  @override
  Future<Result<LibraryMovie>> call(AddMovieToLibraryParams params) {
    return repository.addMovie(params.movie);
  }
}
