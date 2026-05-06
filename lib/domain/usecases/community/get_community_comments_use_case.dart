import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/community/community_comment.dart';
import 'package:imovie_app/domain/repositories/community_repository.dart';

class GetCommunityCommentsParams {
  const GetCommunityCommentsParams({required this.postId});

  final String postId;
}

class GetCommunityCommentsUseCase
    implements UseCase<List<CommunityComment>, GetCommunityCommentsParams> {
  const GetCommunityCommentsUseCase(this.repository);

  final CommunityRepository repository;

  @override
  Future<Result<List<CommunityComment>>> call(
    GetCommunityCommentsParams params,
  ) {
    return repository.getComments(params.postId);
  }
}
