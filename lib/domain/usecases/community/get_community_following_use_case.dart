import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/community/community_profile.dart';
import 'package:imovie_app/domain/repositories/community_repository.dart';

class GetCommunityFollowingParams {
  const GetCommunityFollowingParams({
    required this.userId,
    required this.page,
    required this.limit,
  });

  final String userId;
  final int page;
  final int limit;
}

class GetCommunityFollowingUseCase
    implements UseCase<List<CommunityProfile>, GetCommunityFollowingParams> {
  const GetCommunityFollowingUseCase(this.repository);

  final CommunityRepository repository;

  @override
  Future<Result<List<CommunityProfile>>> call(
    GetCommunityFollowingParams params,
  ) {
    return repository.getFollowing(
      userId: params.userId,
      page: params.page,
      limit: params.limit,
    );
  }
}
