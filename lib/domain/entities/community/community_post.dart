class CommunityPost {
  const CommunityPost({
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

  CommunityPost copyWith({
    String? content,
    String? imageUrl,
    String? movieTitle,
    String? movieSlug,
    String? moviePosterUrl,
    String? locationName,
    int? reactionCount,
    int? commentCount,
    bool? isReactedByMe,
  }) {
    return CommunityPost(
      id: id,
      userId: userId,
      authorName: authorName,
      authorAvatarUrl: authorAvatarUrl,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      movieTitle: movieTitle ?? this.movieTitle,
      movieSlug: movieSlug ?? this.movieSlug,
      moviePosterUrl: moviePosterUrl ?? this.moviePosterUrl,
      locationName: locationName ?? this.locationName,
      reactionCount: reactionCount ?? this.reactionCount,
      commentCount: commentCount ?? this.commentCount,
      isReactedByMe: isReactedByMe ?? this.isReactedByMe,
      isOwner: isOwner,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
