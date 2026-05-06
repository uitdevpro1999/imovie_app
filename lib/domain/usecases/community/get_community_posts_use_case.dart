import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/community/community_post.dart';
import 'package:imovie_app/domain/repositories/community_repository.dart';

class GetCommunityPostsParams {
  const GetCommunityPostsParams({
    required this.mineOnly,
    required this.page,
    required this.limit,
  });

  final bool mineOnly;
  final int page;
  final int limit;
}

class GetCommunityPostsUseCase
    implements UseCase<List<CommunityPost>, GetCommunityPostsParams> {
  const GetCommunityPostsUseCase(this.repository);

  final CommunityRepository repository;

  @override
  Future<Result<List<CommunityPost>>> call(GetCommunityPostsParams params) {
    return repository.getPosts(
      mineOnly: params.mineOnly,
      page: params.page,
      limit: params.limit,
    );
  }
}
