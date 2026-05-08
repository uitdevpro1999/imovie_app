import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/community/community_profile.dart';
import 'package:imovie_app/domain/repositories/community_repository.dart';

class GetCommunityFollowersParams {
  const GetCommunityFollowersParams({
    required this.userId,
    required this.page,
    required this.limit,
  });

  final String userId;
  final int page;
  final int limit;
}

class GetCommunityFollowersUseCase
    implements UseCase<List<CommunityProfile>, GetCommunityFollowersParams> {
  const GetCommunityFollowersUseCase(this.repository);

  final CommunityRepository repository;

  @override
  Future<Result<List<CommunityProfile>>> call(
    GetCommunityFollowersParams params,
  ) {
    return repository.getFollowers(
      userId: params.userId,
      page: params.page,
      limit: params.limit,
    );
  }
}
