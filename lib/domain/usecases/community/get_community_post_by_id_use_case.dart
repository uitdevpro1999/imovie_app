import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/community/community_post.dart';
import 'package:imovie_app/domain/repositories/community_repository.dart';

class GetCommunityPostByIdParams {
  const GetCommunityPostByIdParams({required this.id});

  final String id;
}

class GetCommunityPostByIdUseCase
    implements UseCase<CommunityPost, GetCommunityPostByIdParams> {
  const GetCommunityPostByIdUseCase(this.repository);

  final CommunityRepository repository;

  @override
  Future<Result<CommunityPost>> call(GetCommunityPostByIdParams params) {
    return repository.getPostById(params.id);
  }
}
