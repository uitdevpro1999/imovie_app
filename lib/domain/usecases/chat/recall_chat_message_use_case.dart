import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/domain/repositories/chat_repository.dart';

class RecallChatMessageParams {
  const RecallChatMessageParams({required this.messageId});

  final String messageId;
}

class RecallChatMessageUseCase {
  const RecallChatMessageUseCase({required this.repository});

  final ChatRepository repository;

  Future<Result<void>> call(RecallChatMessageParams params) {
    return repository.recallMessage(params.messageId);
  }
}
