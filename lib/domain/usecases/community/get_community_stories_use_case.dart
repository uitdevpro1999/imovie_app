import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/community/community_story.dart';
import 'package:imovie_app/domain/repositories/community_repository.dart';

class GetCommunityStoriesUseCase
    implements UseCase<List<CommunityStory>, NoParams> {
  const GetCommunityStoriesUseCase(this.repository);

  final CommunityRepository repository;

  @override
  Future<Result<List<CommunityStory>>> call(NoParams params) {
    return repository.getStories();
  }
}
