import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/community/community_story.dart';
import 'package:imovie_app/domain/repositories/community_repository.dart';

class CreateCommunityStoryParams {
  const CreateCommunityStoryParams({
    required this.image,
    required this.caption,
    required this.movieTitle,
    required this.movieSlug,
    required this.moviePosterUrl,
    required this.locationName,
    required this.textPositionX,
    required this.textPositionY,
    required this.moviePositionX,
    required this.moviePositionY,
    required this.locationPositionX,
    required this.locationPositionY,
  });

  final CommunityImagePayload image;
  final String caption;
  final String movieTitle;
  final String movieSlug;
  final String moviePosterUrl;
  final String locationName;
  final double textPositionX;
  final double textPositionY;
  final double moviePositionX;
  final double moviePositionY;
  final double locationPositionX;
  final double locationPositionY;
}

class CreateCommunityStoryUseCase
    implements UseCase<CommunityStory, CreateCommunityStoryParams> {
  const CreateCommunityStoryUseCase(this.repository);

  final CommunityRepository repository;

  @override
  Future<Result<CommunityStory>> call(CreateCommunityStoryParams params) {
    return repository.createStory(
      image: params.image,
      caption: params.caption,
      movieTitle: params.movieTitle,
      movieSlug: params.movieSlug,
      moviePosterUrl: params.moviePosterUrl,
      locationName: params.locationName,
      textPositionX: params.textPositionX,
      textPositionY: params.textPositionY,
      moviePositionX: params.moviePositionX,
      moviePositionY: params.moviePositionY,
      locationPositionX: params.locationPositionX,
      locationPositionY: params.locationPositionY,
    );
  }
}
