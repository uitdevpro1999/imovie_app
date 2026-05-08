import 'dart:typed_data';

import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/domain/entities/community/community_comment.dart';
import 'package:imovie_app/domain/entities/community/community_post.dart';
import 'package:imovie_app/domain/entities/community/community_profile.dart';
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
  Future<Result<CommunityStory>> getStoryById(String id);

  Future<Result<List<CommunityStory>>> getStories({
    required String userId,
    required bool followedOnly,
  });

  Future<Result<List<String>>> getFollowedUserIds();

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

  Future<Result<CommunityPost>> getPostById(String id);

  Future<Result<List<CommunityPost>>> getPosts({
    required bool mineOnly,
    required String userId,
    required int page,
    required int limit,
  });

  Future<Result<CommunityProfile>> getProfile(String userId);

  Future<Result<List<CommunityProfile>>> getFollowers({
    required String userId,
    required int page,
    required int limit,
  });

  Future<Result<List<CommunityProfile>>> getFollowing({
    required String userId,
    required int page,
    required int limit,
  });

  Future<Result<CommunityProfile>> followUser(String userId);

  Future<Result<CommunityProfile>> unfollowUser(String userId);

  Future<Result<CommunityPost>> createPost({
    required String content,
    required String movieTitle,
    required String movieSlug,
    required String moviePosterUrl,
    required String locationName,
    required List<CommunityImagePayload> images,
  });

  Future<Result<CommunityPost>> updatePost({
    required String id,
    required String content,
    required String movieTitle,
    required String movieSlug,
    required String moviePosterUrl,
    required String locationName,
    required List<String> keptImageUrls,
    required List<CommunityImagePayload> images,
  });

  Future<Result<void>> deletePost(String id);

  Future<Result<List<CommunityComment>>> getComments(String postId);

  Future<Result<CommunityComment>> addComment({
    required String postId,
    required String content,
  });

  Future<Result<CommunityPost>> toggleReaction(String postId);
}
