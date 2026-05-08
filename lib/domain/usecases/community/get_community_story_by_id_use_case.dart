import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/community/community_story.dart';
import 'package:imovie_app/domain/repositories/community_repository.dart';

class GetCommunityStoryByIdParams {
  const GetCommunityStoryByIdParams({required this.id});

  final String id;
}

class GetCommunityStoryByIdUseCase
    implements UseCase<CommunityStory, GetCommunityStoryByIdParams> {
  const GetCommunityStoryByIdUseCase(this.repository);

  final CommunityRepository repository;

  @override
  Future<Result<CommunityStory>> call(GetCommunityStoryByIdParams params) {
    return repository.getStoryById(params.id);
  }
}
