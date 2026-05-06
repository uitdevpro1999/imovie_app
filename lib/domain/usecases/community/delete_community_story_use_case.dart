import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/repositories/community_repository.dart';

class DeleteCommunityStoryParams {
  const DeleteCommunityStoryParams({required this.id});

  final String id;
}

class DeleteCommunityStoryUseCase
    implements UseCase<void, DeleteCommunityStoryParams> {
  const DeleteCommunityStoryUseCase(this.repository);

  final CommunityRepository repository;

  @override
  Future<Result<void>> call(DeleteCommunityStoryParams params) {
    return repository.deleteStory(params.id);
  }
}
