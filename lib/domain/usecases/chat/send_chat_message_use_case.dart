import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/chat/chat_message.dart';
import 'package:imovie_app/domain/repositories/chat_repository.dart';

class SendChatMessageParams {
  const SendChatMessageParams({
    required this.conversationId,
    required this.body,
  });

  final String conversationId;
  final String body;
}

class SendChatMessageUseCase
    implements UseCase<ChatMessage, SendChatMessageParams> {
  const SendChatMessageUseCase(this.repository);

  final ChatRepository repository;

  @override
  Future<Result<ChatMessage>> call(SendChatMessageParams params) {
    return repository.sendTextMessage(
      conversationId: params.conversationId,
      body: params.body,
    );
  }
}
