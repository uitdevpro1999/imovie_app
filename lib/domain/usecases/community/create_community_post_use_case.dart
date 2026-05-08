import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/community/community_post.dart';
import 'package:imovie_app/domain/repositories/community_repository.dart';

class CreateCommunityPostParams {
  const CreateCommunityPostParams({
    required this.content,
    required this.movieTitle,
    required this.movieSlug,
    required this.moviePosterUrl,
    required this.locationName,
    this.images = const [],
  });

  final String content;
  final String movieTitle;
  final String movieSlug;
  final String moviePosterUrl;
  final String locationName;
  final List<CommunityImagePayload> images;
}

class CreateCommunityPostUseCase
    implements UseCase<CommunityPost, CreateCommunityPostParams> {
  const CreateCommunityPostUseCase(this.repository);

  final CommunityRepository repository;

  @override
  Future<Result<CommunityPost>> call(CreateCommunityPostParams params) {
    return repository.createPost(
      content: params.content,
      movieTitle: params.movieTitle,
      movieSlug: params.movieSlug,
      moviePosterUrl: params.moviePosterUrl,
      locationName: params.locationName,
      images: params.images,
    );
  }
}
