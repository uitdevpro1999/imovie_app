import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/library/library_movie.dart';
import 'package:imovie_app/domain/repositories/library_repository.dart';

class GetLibraryMoviesUseCase implements UseCase<List<LibraryMovie>, NoParams> {
  const GetLibraryMoviesUseCase(this.repository);

  final LibraryRepository repository;

  @override
  Future<Result<List<LibraryMovie>>> call(NoParams params) {
    return repository.getLibraryMovies();
  }
}
