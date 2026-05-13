import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/domain/entities/chat/chat_conversation.dart';
import 'package:imovie_app/domain/entities/chat/chat_message.dart';

abstract interface class ChatRepository {
  Future<Result<List<ChatConversation>>> getConversations({
    required int page,
    required int limit,
  });

  Future<Result<ChatConversation>> getOrCreateDirectConversation({
    required String userId,
  });

  Future<Result<List<ChatMessage>>> getMessages({
    required String conversationId,
    required int page,
    required int limit,
  });

  Future<Result<ChatMessage>> sendTextMessage({
    required String conversationId,
    required String body,
  });

  Future<Result<ChatMessage>> sendImageMessage({
    required String conversationId,
    required String imagePath,
    required String fileName,
  });

  Future<Result<void>> recallMessage(String messageId);

  Future<Result<void>> toggleReaction({
    required String conversationId,
    required String messageId,
    required String reaction,
    required bool reactedByMe,
  });

  Future<Result<void>> markConversationRead(String conversationId);

  Stream<void> watchConversations();

  Stream<void> watchMessages(String conversationId);
}
