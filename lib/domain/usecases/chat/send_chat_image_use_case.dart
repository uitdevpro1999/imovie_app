import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/chat/chat_message.dart';
import 'package:imovie_app/domain/repositories/chat_repository.dart';

class SendChatImageParams {
  const SendChatImageParams({
    required this.conversationId,
    required this.imagePath,
    required this.fileName,
  });

  final String conversationId;
  final String imagePath;
  final String fileName;
}

class SendChatImageUseCase
    implements UseCase<ChatMessage, SendChatImageParams> {
  const SendChatImageUseCase(this.repository);

  final ChatRepository repository;

  @override
  Future<Result<ChatMessage>> call(SendChatImageParams params) {
    return repository.sendImageMessage(
      conversationId: params.conversationId,
      imagePath: params.imagePath,
      fileName: params.fileName,
    );
  }
}
