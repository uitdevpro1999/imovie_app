import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/repositories/community_repository.dart';

class DeleteCommunityPostParams {
  const DeleteCommunityPostParams({required this.id});

  final String id;
}

class DeleteCommunityPostUseCase
    implements UseCase<void, DeleteCommunityPostParams> {
  const DeleteCommunityPostUseCase(this.repository);

  final CommunityRepository repository;

  @override
  Future<Result<void>> call(DeleteCommunityPostParams params) {
    return repository.deletePost(params.id);
  }
}
