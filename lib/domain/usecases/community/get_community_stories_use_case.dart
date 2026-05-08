import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/community/community_story.dart';
import 'package:imovie_app/domain/repositories/community_repository.dart';

class GetCommunityStoriesParams {
  const GetCommunityStoriesParams({
    this.userId = '',
    this.followedOnly = false,
  });

  final String userId;
  final bool followedOnly;
}

class GetCommunityStoriesUseCase
    implements UseCase<List<CommunityStory>, GetCommunityStoriesParams> {
  const GetCommunityStoriesUseCase(this.repository);

  final CommunityRepository repository;

  @override
  Future<Result<List<CommunityStory>>> call(GetCommunityStoriesParams params) {
    return repository.getStories(
      userId: params.userId,
      followedOnly: params.followedOnly,
    );
  }
}
