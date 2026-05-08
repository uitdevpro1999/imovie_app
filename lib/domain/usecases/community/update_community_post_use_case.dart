import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/community/community_post.dart';
import 'package:imovie_app/domain/repositories/community_repository.dart';

class UpdateCommunityPostParams {
  const UpdateCommunityPostParams({
    required this.id,
    required this.content,
    required this.movieTitle,
    required this.movieSlug,
    required this.moviePosterUrl,
    required this.locationName,
    this.keptImageUrls = const [],
    this.images = const [],
  });

  final String id;
  final String content;
  final String movieTitle;
  final String movieSlug;
  final String moviePosterUrl;
  final String locationName;
  final List<String> keptImageUrls;
  final List<CommunityImagePayload> images;
}

class UpdateCommunityPostUseCase
    implements UseCase<CommunityPost, UpdateCommunityPostParams> {
  const UpdateCommunityPostUseCase(this.repository);

  final CommunityRepository repository;

  @override
  Future<Result<CommunityPost>> call(UpdateCommunityPostParams params) {
    return repository.updatePost(
      id: params.id,
      content: params.content,
      movieTitle: params.movieTitle,
      movieSlug: params.movieSlug,
      moviePosterUrl: params.moviePosterUrl,
      locationName: params.locationName,
      keptImageUrls: params.keptImageUrls,
      images: params.images,
    );
  }
}
