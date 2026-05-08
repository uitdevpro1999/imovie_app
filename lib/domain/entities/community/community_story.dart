class CommunityStory {
  const CommunityStory({
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

  bool get isExpired {
    final expiry = expiresAt;
    if (expiry == null) {
      return false;
    }

    return DateTime.now().toUtc().isAfter(expiry.toUtc());
  }

  CommunityStory copyWith({
    String? authorName,
    String? authorAvatarUrl,
    String? caption,
    String? movieTitle,
    String? movieSlug,
    String? moviePosterUrl,
    String? locationName,
  }) {
    return CommunityStory(
      id: id,
      userId: userId,
      authorName: authorName ?? this.authorName,
      authorAvatarUrl: authorAvatarUrl ?? this.authorAvatarUrl,
      imageUrl: imageUrl,
      imagePath: imagePath,
      caption: caption ?? this.caption,
      movieTitle: movieTitle ?? this.movieTitle,
      movieSlug: movieSlug ?? this.movieSlug,
      moviePosterUrl: moviePosterUrl ?? this.moviePosterUrl,
      locationName: locationName ?? this.locationName,
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
