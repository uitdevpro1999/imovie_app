import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/community/community_comment.dart';
import 'package:imovie_app/domain/repositories/community_repository.dart';

class AddCommunityCommentParams {
  const AddCommunityCommentParams({
    required this.postId,
    required this.content,
  });

  final String postId;
  final String content;
}

class AddCommunityCommentUseCase
    implements UseCase<CommunityComment, AddCommunityCommentParams> {
  const AddCommunityCommentUseCase(this.repository);

  final CommunityRepository repository;

  @override
  Future<Result<CommunityComment>> call(AddCommunityCommentParams params) {
    return repository.addComment(
      postId: params.postId,
      content: params.content,
    );
  }
}
