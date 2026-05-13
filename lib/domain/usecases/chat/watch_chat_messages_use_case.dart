import 'package:imovie_app/domain/repositories/chat_repository.dart';

class WatchChatMessagesUseCase {
  const WatchChatMessagesUseCase(this.repository);

  final ChatRepository repository;

  Stream<void> call(String conversationId) {
    return repository.watchMessages(conversationId);
  }
}
