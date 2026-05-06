import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/home/home_feed.dart';
import 'package:imovie_app/domain/repositories/home_repository.dart';

class GetHomeFeedUseCase implements UseCase<HomeFeed, NoParams> {
  const GetHomeFeedUseCase(this.repository);

  final HomeRepository repository;

  @override
  Future<Result<HomeFeed>> call(NoParams params) {
    return repository.getHomeFeed();
  }
}
