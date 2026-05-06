import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/repositories/library_repository.dart';

class RemoveMovieFromLibraryParams {
  const RemoveMovieFromLibraryParams({required this.id});

  final String id;
}

class RemoveMovieFromLibraryUseCase
    implements UseCase<void, RemoveMovieFromLibraryParams> {
  const RemoveMovieFromLibraryUseCase(this.repository);

  final LibraryRepository repository;

  @override
  Future<Result<void>> call(RemoveMovieFromLibraryParams params) {
    return repository.removeMovie(params.id);
  }
}
