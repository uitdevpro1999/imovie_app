import 'package:imovie_app/domain/entities/community/community_comment.dart';
import 'package:imovie_app/domain/entities/community/community_post.dart';
import 'package:imovie_app/domain/entities/community/community_story.dart';

class CommunityStoryResponse {
  const CommunityStoryResponse({
    required this.id,
    required this.userId,
    required this.authorName,
    required this.authorAvatarUrl,
    required this.imageUrl,
    required this.imagePath,
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
    required this.isOwner,
    required this.createdAt,
    required this.expiresAt,
  });

  factory CommunityStoryResponse.fromJson({
    required Map<String, dynamic> json,
    required String currentUserId,
  }) {
    final userId = json['user_id']?.toString() ?? '';
    return CommunityStoryResponse(
      id: json['id']?.toString() ?? '',
      userId: userId,
      authorName: json['author_name']?.toString() ?? '',
      authorAvatarUrl: json['author_avatar_url']?.toString() ?? '',
      imageUrl: json['image_url']?.toString() ?? '',
      imagePath: json['image_path']?.toString() ?? '',
      caption: json['caption']?.toString() ?? '',
      movieTitle: json['movie_title']?.toString() ?? '',
      movieSlug: json['movie_slug']?.toString() ?? '',
      moviePosterUrl: json['movie_poster_url']?.toString() ?? '',
      locationName: json['location_name']?.toString() ?? '',
      textPositionX: _positionValue(json['text_position_x'], 0.5),
      textPositionY: _positionValue(json['text_position_y'], 0.45),
      moviePositionX: _positionValue(json['movie_position_x'], 0.28),
      moviePositionY: _positionValue(json['movie_position_y'], 0.78),
      locationPositionX: _positionValue(json['location_position_x'], 0.32),
      locationPositionY: _positionValue(json['location_position_y'], 0.88),
      isOwner: userId == currentUserId,
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
      expiresAt: DateTime.tryParse(json['expires_at']?.toString() ?? ''),
    );
  }

  final String id;
  final String userId;
  final String authorName;
  final String authorAvatarUrl;
  final String imageUrl;
  final String imagePath;
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
  final bool isOwner;
  final DateTime? createdAt;
  final DateTime? expiresAt;

  CommunityStory toEntity() {
    return CommunityStory(
      id: id,
      userId: userId,
      authorName: authorName,
      authorAvatarUrl: authorAvatarUrl,
      imageUrl: imageUrl,
      imagePath: imagePath,
      caption: caption,
      movieTitle: movieTitle,
      movieSlug: movieSlug,
      moviePosterUrl: moviePosterUrl,
      locationName: locationName,
      textPositionX: textPositionX,
      textPositionY: textPositionY,
      moviePositionX: moviePositionX,
      moviePositionY: moviePositionY,
      locationPositionX: locationPositionX,
      locationPositionY: locationPositionY,
      isOwner: isOwner,
      createdAt: createdAt,
      expiresAt: expiresAt,
    );
  }
}

double _positionValue(Object? value, double fallback) {
  final parsed = value is num
      ? value.toDouble()
      : double.tryParse(value?.toString() ?? '');
  if (parsed == null) {
    return fallback;
  }

  return parsed.clamp(0.0, 1.0);
}

class CommunityPostResponse {
  const CommunityPostResponse({
    required this.id,
    required this.userId,
    required this.authorName,
    required this.authorAvatarUrl,
    required this.content,
    required this.imageUrl,
    required this.movieTitle,
    required this.movieSlug,
    required this.moviePosterUrl,
    required this.locationName,
    required this.reactionCount,
    required this.commentCount,
    required this.isReactedByMe,
    required this.isOwner,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CommunityPostResponse.fromJson({
    required Map<String, dynamic> json,
    required String currentUserId,
    required Set<String> reactedPostIds,
  }) {
    final id = json['id']?.toString() ?? '';
    final userId = json['user_id']?.toString() ?? '';
    return CommunityPostResponse(
      id: id,
      userId: userId,
      authorName: json['author_name']?.toString() ?? '',
      authorAvatarUrl: json['author_avatar_url']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      imageUrl: json['image_url']?.toString() ?? '',
      movieTitle: json['movie_title']?.toString() ?? '',
      movieSlug: json['movie_slug']?.toString() ?? '',
      moviePosterUrl: json['movie_poster_url']?.toString() ?? '',
      locationName: json['location_name']?.toString() ?? '',
      reactionCount: (json['reaction_count'] as num?)?.toInt() ?? 0,
      commentCount: (json['comment_count'] as num?)?.toInt() ?? 0,
      isReactedByMe: reactedPostIds.contains(id),
      isOwner: userId == currentUserId,
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at']?.toString() ?? ''),
    );
  }

  final String id;
  final String userId;
  final String authorName;
  final String authorAvatarUrl;
  final String content;
  final String imageUrl;
  final String movieTitle;
  final String movieSlug;
  final String moviePosterUrl;
  final String locationName;
  final int reactionCount;
  final int commentCount;
  final bool isReactedByMe;
  final bool isOwner;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CommunityPost toEntity() {
    return CommunityPost(
      id: id,
      userId: userId,
      authorName: authorName,
      authorAvatarUrl: authorAvatarUrl,
      content: content,
      imageUrl: imageUrl,
      movieTitle: movieTitle,
      movieSlug: movieSlug,
      moviePosterUrl: moviePosterUrl,
      locationName: locationName,
      reactionCount: reactionCount,
      commentCount: commentCount,
      isReactedByMe: isReactedByMe,
      isOwner: isOwner,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

class CommunityCommentResponse {
  const CommunityCommentResponse({
    required this.id,
    required this.postId,
    required this.userId,
    required this.authorName,
    required this.authorAvatarUrl,
    required this.content,
    required this.isOwner,
    required this.createdAt,
  });

  factory CommunityCommentResponse.fromJson({
    required Map<String, dynamic> json,
    required String currentUserId,
  }) {
    final userId = json['user_id']?.toString() ?? '';
    return CommunityCommentResponse(
      id: json['id']?.toString() ?? '',
      postId: json['post_id']?.toString() ?? '',
      userId: userId,
      authorName: json['author_name']?.toString() ?? '',
      authorAvatarUrl: json['author_avatar_url']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      isOwner: userId == currentUserId,
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
    );
  }

  final String id;
  final String postId;
  final String userId;
  final String authorName;
  final String authorAvatarUrl;
  final String content;
  final bool isOwner;
  final DateTime? createdAt;

  CommunityComment toEntity() {
    return CommunityComment(
      id: id,
      postId: postId,
      userId: userId,
      authorName: authorName,
      authorAvatarUrl: authorAvatarUrl,
      content: content,
      isOwner: isOwner,
      createdAt: createdAt,
    );
  }
}
