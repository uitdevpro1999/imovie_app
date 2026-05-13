enum ChatMessageType { text, image, system }

enum ChatMessageStatus { sending, sent, delivered, read, failed }

class ChatMessageReaction {
  const ChatMessageReaction({
    required this.reaction,
    required this.count,
    required this.reactedByMe,
  });

  final String reaction;
  final int count;
  final bool reactedByMe;
}

class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.senderName,
    required this.senderAvatarUrl,
    required this.body,
    required this.type,
    this.status = ChatMessageStatus.sent,
    this.reactions = const [],
    required this.createdAt,
    required this.deletedAt,
  });

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

  bool get isDeleted => deletedAt != null;

  ChatMessage copyWith({
    String? id,
    String? conversationId,
    String? senderId,
    String? senderName,
    String? senderAvatarUrl,
    String? body,
    ChatMessageType? type,
    ChatMessageStatus? status,
    List<ChatMessageReaction>? reactions,
    DateTime? createdAt,
    DateTime? deletedAt,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      senderAvatarUrl: senderAvatarUrl ?? this.senderAvatarUrl,
      body: body ?? this.body,
      type: type ?? this.type,
      status: status ?? this.status,
      reactions: reactions ?? this.reactions,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}
