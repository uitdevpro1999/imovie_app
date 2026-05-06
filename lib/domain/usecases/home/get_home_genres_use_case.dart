import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/home/home_genre.dart';
import 'package:imovie_app/domain/repositories/home_repository.dart';

class GetHomeGenresUseCase implements UseCase<List<HomeGenre>, NoParams> {
  const GetHomeGenresUseCase(this.repository);

  final HomeRepository repository;

  @override
  Future<Result<List<HomeGenre>>> call(NoParams params) {
    return repository.getHomeGenres();
  }
}
