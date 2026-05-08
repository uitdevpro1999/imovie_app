class CommunityProfile {
  const CommunityProfile({
    required this.userId,
    required this.displayName,
    required this.avatarUrl,
    required this.coverUrl,
    required this.isMe,
    required this.isFollowing,
    required this.followerCount,
    required this.followingCount,
    required this.postCount,
    required this.storyCount,
  });

  final String userId;
  final String displayName;
  final String avatarUrl;
  final String coverUrl;
  final bool isMe;
  final bool isFollowing;
  final int followerCount;
  final int followingCount;
  final int postCount;
  final int storyCount;

  CommunityProfile copyWith({
    String? displayName,
    String? avatarUrl,
    String? coverUrl,
    bool? isFollowing,
    int? followerCount,
    int? followingCount,
    int? postCount,
    int? storyCount,
  }) {
    return CommunityProfile(
      userId: userId,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      coverUrl: coverUrl ?? this.coverUrl,
      isMe: isMe,
      isFollowing: isFollowing ?? this.isFollowing,
      followerCount: followerCount ?? this.followerCount,
      followingCount: followingCount ?? this.followingCount,
      postCount: postCount ?? this.postCount,
      storyCount: storyCount ?? this.storyCount,
    );
  }
}
