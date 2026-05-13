enum CommunityNotificationType {
  newPost,
  newStory,
  postComment,
  postReaction,
  newFollower,
  chatMessage,
  incomingCall,
  callDeclined,
  callEnded,
  missedCall,
}

enum CommunityNotificationEntityType { post, story, profile, chat, call }

class CommunityNotification {
  const CommunityNotification({
    required this.id,
    required this.recipientUserId,
    required this.actorUserId,
    required this.actorName,
    required this.actorAvatarUrl,
    required this.type,
    required this.sourceTable,
    required this.sourceRecordId,
    required this.entityType,
    required this.entityId,
    required this.title,
    required this.body,
    required this.imageUrl,
    required this.isRead,
    required this.createdAt,
  });

  final String id;
  final String recipientUserId;
  final String actorUserId;
  final String actorName;
  final String actorAvatarUrl;
  final CommunityNotificationType type;
  final String sourceTable;
  final String sourceRecordId;
  final CommunityNotificationEntityType entityType;
  final String entityId;
  final String title;
  final String body;
  final String imageUrl;
  final bool isRead;
  final DateTime? createdAt;

  bool get isUnread => !isRead;

  CommunityNotification copyWith({bool? isRead}) {
    return CommunityNotification(
      id: id,
      recipientUserId: recipientUserId,
      actorUserId: actorUserId,
      actorName: actorName,
      actorAvatarUrl: actorAvatarUrl,
      type: type,
      sourceTable: sourceTable,
      sourceRecordId: sourceRecordId,
      entityType: entityType,
      entityId: entityId,
      title: title,
      body: body,
      imageUrl: imageUrl,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt,
    );
  }
}
