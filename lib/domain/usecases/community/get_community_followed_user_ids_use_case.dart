import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/repositories/community_repository.dart';

class GetCommunityFollowedUserIdsUseCase
    implements UseCase<List<String>, NoParams> {
  const GetCommunityFollowedUserIdsUseCase(this.repository);

  final CommunityRepository repository;

  @override
  Future<Result<List<String>>> call(NoParams params) {
    return repository.getFollowedUserIds();
  }
}
