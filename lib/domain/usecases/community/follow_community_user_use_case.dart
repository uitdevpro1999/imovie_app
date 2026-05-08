import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/community/community_profile.dart';
import 'package:imovie_app/domain/repositories/community_repository.dart';

class FollowCommunityUserParams {
  const FollowCommunityUserParams({required this.userId});

  final String userId;
}

class FollowCommunityUserUseCase
    implements UseCase<CommunityProfile, FollowCommunityUserParams> {
  const FollowCommunityUserUseCase(this.repository);

  final CommunityRepository repository;

  @override
  Future<Result<CommunityProfile>> call(FollowCommunityUserParams params) {
    return repository.followUser(params.userId);
  }
}
