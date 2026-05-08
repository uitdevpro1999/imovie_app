enum CommunityFollowListType { followers, following }

abstract final class CommunityFollowListSlugs {
  static const followers = 'followers';
  static const following = 'following';
}

CommunityFollowListType communityFollowListTypeFromSlug(String value) {
  return switch (value.trim()) {
    CommunityFollowListSlugs.following => CommunityFollowListType.following,
    _ => CommunityFollowListType.followers,
  };
}

extension CommunityFollowListTypeX on CommunityFollowListType {
  String get slug {
    return switch (this) {
      CommunityFollowListType.followers => CommunityFollowListSlugs.followers,
      CommunityFollowListType.following => CommunityFollowListSlugs.following,
    };
  }

  bool get isFollowers => this == CommunityFollowListType.followers;
}
