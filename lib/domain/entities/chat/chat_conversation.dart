class ChatConversation {
  const ChatConversation({
    required this.id,
    required this.title,
    required this.avatarUrl,
    required this.participantIds,
    required this.lastMessagePreview,
    required this.lastMessageAt,
    required this.unreadCount,
    required this.isDirect,
  });

  final String id;
  final String title;
  final String avatarUrl;
  final List<String> participantIds;
  final String lastMessagePreview;
  final DateTime? lastMessageAt;
  final int unreadCount;
  final bool isDirect;
}
