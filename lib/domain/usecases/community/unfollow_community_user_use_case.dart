import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/community/community_profile.dart';
import 'package:imovie_app/domain/repositories/community_repository.dart';

class UnfollowCommunityUserParams {
  const UnfollowCommunityUserParams({required this.userId});

  final String userId;
}

class UnfollowCommunityUserUseCase
    implements UseCase<CommunityProfile, UnfollowCommunityUserParams> {
  const UnfollowCommunityUserUseCase(this.repository);

  final CommunityRepository repository;

  @override
  Future<Result<CommunityProfile>> call(UnfollowCommunityUserParams params) {
    return repository.unfollowUser(params.userId);
  }
}
