import 'package:imovie_app/domain/entities/chat/chat_message.dart';

class ChatMessageResponse {
  const ChatMessageResponse({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.senderName,
    required this.senderAvatarUrl,
    required this.body,
    required this.type,
    required this.status,
    this.reactions = const [],
    required this.createdAt,
    required this.deletedAt,
  });

  factory ChatMessageResponse.fromJson(Map<String, dynamic> json) {
    return ChatMessageResponse(
      id: json['id']?.toString() ?? '',
      conversationId: json['conversation_id']?.toString() ?? '',
      senderId: json['sender_id']?.toString() ?? '',
      senderName:
          json['sender_name']?.toString() ??
          json['profiles']?['full_name']?.toString() ??
          'iMovie user',
      senderAvatarUrl:
          json['sender_avatar_url']?.toString() ??
          json['profiles']?['avatar_url']?.toString() ??
          '',
      body: json['body']?.toString() ?? '',
      type: _typeFromString(json['type']?.toString() ?? ''),
      status: _statusFromString(json['status']?.toString() ?? ''),
      reactions: _reactionsFromJson(json['reactions']),
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
      deletedAt: DateTime.tryParse(json['deleted_at']?.toString() ?? ''),
    );
  }

  final String id;
  final String conversationId;
  final String senderId;
  final String senderName;
  final String senderAvatarUrl;
  final String body;
  final ChatMessageType type;
  final ChatMessageStatus status;
  final List<ChatMessageReaction> reactions;
  final DateTime? createdAt;
  final DateTime? deletedAt;

  ChatMessage toEntity() {
    return ChatMessage(
      id: id,
      conversationId: conversationId,
      senderId: senderId,
      senderName: senderName,
      senderAvatarUrl: senderAvatarUrl,
      body: body,
      type: type,
      status: status,
      reactions: reactions,
      createdAt: createdAt,
      deletedAt: deletedAt,
    );
  }

  static ChatMessageType _typeFromString(String value) {
    return switch (value.trim()) {
      'image' => ChatMessageType.image,
      'system' => ChatMessageType.system,
      _ => ChatMessageType.text,
    };
  }

  static ChatMessageStatus _statusFromString(String value) {
    return switch (value.trim()) {
      'sending' => ChatMessageStatus.sending,
      'delivered' => ChatMessageStatus.delivered,
      'read' => ChatMessageStatus.read,
      'failed' => ChatMessageStatus.failed,
      _ => ChatMessageStatus.sent,
    };
  }

  static List<ChatMessageReaction> _reactionsFromJson(Object? value) {
    if (value is! Iterable) {
      return const [];
    }
    return value
        .whereType<Map>()
        .map((item) {
          final reaction = item['reaction']?.toString() ?? '';
          final count = _intValue(item['count']);
          return ChatMessageReaction(
            reaction: reaction,
            count: count,
            reactedByMe: item['reacted_by_me'] == true,
          );
        })
        .where((item) => item.reaction.trim().isNotEmpty && item.count > 0)
        .toList(growable: false);
  }

  static int _intValue(Object? value) {
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
