import 'package:imovie_app/domain/entities/notification/community_notification.dart';

class CommunityNotificationResponse {
  const CommunityNotificationResponse({
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

  factory CommunityNotificationResponse.fromJson(Map<String, dynamic> json) {
    return CommunityNotificationResponse(
      id: json['id']?.toString() ?? '',
      recipientUserId: json['recipient_user_id']?.toString() ?? '',
      actorUserId: json['actor_user_id']?.toString() ?? '',
      actorName: json['actor_name']?.toString() ?? '',
      actorAvatarUrl: json['actor_avatar_url']?.toString() ?? '',
      type: _typeFromRaw(json['notification_type']?.toString()),
      sourceTable: json['source_table']?.toString() ?? '',
      sourceRecordId: json['source_record_id']?.toString() ?? '',
      entityType: _entityTypeFromRaw(json['entity_type']?.toString()),
      entityId: json['entity_id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      body: json['body']?.toString() ?? '',
      imageUrl: json['image_url']?.toString() ?? '',
      isRead: json['is_read'] == true,
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
    );
  }

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

  CommunityNotification toEntity() {
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
      isRead: isRead,
      createdAt: createdAt,
    );
  }
}

CommunityNotificationType _typeFromRaw(String? raw) {
  return switch ((raw ?? '').trim()) {
    'new_story' => CommunityNotificationType.newStory,
    'post_comment' => CommunityNotificationType.postComment,
    'post_reaction' => CommunityNotificationType.postReaction,
    'new_follower' => CommunityNotificationType.newFollower,
    'chat_message' => CommunityNotificationType.chatMessage,
    'incoming_call' => CommunityNotificationType.incomingCall,
    'call_declined' => CommunityNotificationType.callDeclined,
    'call_ended' => CommunityNotificationType.callEnded,
    'missed_call' => CommunityNotificationType.missedCall,
    _ => CommunityNotificationType.newPost,
  };
}

CommunityNotificationEntityType _entityTypeFromRaw(String? raw) {
  return switch ((raw ?? '').trim()) {
    'story' => CommunityNotificationEntityType.story,
    'profile' => CommunityNotificationEntityType.profile,
    'chat' => CommunityNotificationEntityType.chat,
    'call' => CommunityNotificationEntityType.call,
    _ => CommunityNotificationEntityType.post,
  };
}
