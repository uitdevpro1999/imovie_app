import 'package:imovie_app/domain/entities/chat/chat_conversation.dart';

class ChatConversationResponse {
  const ChatConversationResponse({
    required this.id,
    required this.title,
    required this.avatarUrl,
    required this.participantIds,
    required this.lastMessagePreview,
    required this.lastMessageAt,
    required this.unreadCount,
    required this.isDirect,
  });

  factory ChatConversationResponse.fromJson(Map<String, dynamic> json) {
    return ChatConversationResponse(
      id: json['id']?.toString() ?? '',
      title:
          json['title']?.toString() ??
          json['display_title']?.toString() ??
          'Cuộc trò chuyện',
      avatarUrl:
          json['avatar_url']?.toString() ??
          json['display_avatar_url']?.toString() ??
          '',
      participantIds: _stringList(json['participant_ids']),
      lastMessagePreview:
          json['last_message_preview']?.toString() ??
          json['last_message_body']?.toString() ??
          '',
      lastMessageAt: DateTime.tryParse(
        json['last_message_at']?.toString() ?? '',
      ),
      unreadCount: _intValue(json['unread_count']),
      isDirect:
          json['type']?.toString() == 'direct' || json['is_direct'] == true,
    );
  }

  final String id;
  final String title;
  final String avatarUrl;
  final List<String> participantIds;
  final String lastMessagePreview;
  final DateTime? lastMessageAt;
  final int unreadCount;
  final bool isDirect;

  ChatConversation toEntity() {
    return ChatConversation(
      id: id,
      title: title,
      avatarUrl: avatarUrl,
      participantIds: participantIds,
      lastMessagePreview: lastMessagePreview,
      lastMessageAt: lastMessageAt,
      unreadCount: unreadCount,
      isDirect: isDirect,
    );
  }

  static List<String> _stringList(Object? value) {
    if (value is Iterable) {
      return value
          .map((item) => item.toString().trim())
          .where((item) => item.isNotEmpty)
          .toList(growable: false);
    }
    return const [];
  }

  static int _intValue(Object? value) {
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
