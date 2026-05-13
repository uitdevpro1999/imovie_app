import 'package:imovie_app/domain/repositories/chat_repository.dart';

class WatchChatConversationsUseCase {
  const WatchChatConversationsUseCase(this.repository);

  final ChatRepository repository;

  Stream<void> call() => repository.watchConversations();
}
