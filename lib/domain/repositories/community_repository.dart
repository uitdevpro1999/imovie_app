import 'dart:typed_data';

import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/domain/entities/community/community_comment.dart';
import 'package:imovie_app/domain/entities/community/community_post.dart';
import 'package:imovie_app/domain/entities/community/community_story.dart';

class CommunityImagePayload {
  const CommunityImagePayload({
    required this.bytes,
    required this.fileName,
    required this.contentType,
  });

  final Uint8List bytes;
  final String fileName;
  final String contentType;
}

abstract interface class CommunityRepository {
  Future<Result<List<CommunityStory>>> getStories();

  Future<Result<CommunityStory>> createStory({
    required CommunityImagePayload image,
    required String caption,
    required String movieTitle,
    required String movieSlug,
    required String moviePosterUrl,
    required String locationName,
    required double textPositionX,
    required double textPositionY,
    required double moviePositionX,
    required double moviePositionY,
    required double locationPositionX,
    required double locationPositionY,
  });

  Future<Result<void>> deleteStory(String id);

  Future<Result<List<CommunityPost>>> getPosts({
    required bool mineOnly,
    required int page,
    required int limit,
  });

  Future<Result<CommunityPost>> createPost({
    required String content,
    required String movieTitle,
    required String movieSlug,
    required String moviePosterUrl,
    required String locationName,
    CommunityImagePayload? image,
  });

  Future<Result<CommunityPost>> updatePost({
    required String id,
    required String content,
    required String movieTitle,
    required String movieSlug,
    required String moviePosterUrl,
    required String locationName,
    CommunityImagePayload? image,
  });

  Future<Result<void>> deletePost(String id);

  Future<Result<List<CommunityComment>>> getComments(String postId);

  Future<Result<CommunityComment>> addComment({
    required String postId,
    required String content,
  });

  Future<Result<CommunityPost>> toggleReaction(String postId);
}
