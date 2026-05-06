class CommunityComment {
  const CommunityComment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.authorName,
    required this.authorAvatarUrl,
    required this.content,
    required this.isOwner,
    required this.createdAt,
  });

  final String id;
  final String postId;
  final String userId;
  final String authorName;
  final String authorAvatarUrl;
  final String content;
  final bool isOwner;
  final DateTime? createdAt;
}
