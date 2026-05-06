import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/community/community_post.dart';
import 'package:imovie_app/domain/repositories/community_repository.dart';

class ToggleCommunityReactionParams {
  const ToggleCommunityReactionParams({required this.postId});

  final String postId;
}

class ToggleCommunityReactionUseCase
    implements UseCase<CommunityPost, ToggleCommunityReactionParams> {
  const ToggleCommunityReactionUseCase(this.repository);

  final CommunityRepository repository;

  @override
  Future<Result<CommunityPost>> call(ToggleCommunityReactionParams params) {
    return repository.toggleReaction(params.postId);
  }
}
