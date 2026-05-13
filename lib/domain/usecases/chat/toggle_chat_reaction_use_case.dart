import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/domain/repositories/chat_repository.dart';

class ToggleChatReactionParams {
  const ToggleChatReactionParams({
    required this.conversationId,
    required this.messageId,
    required this.reaction,
    required this.reactedByMe,
  });

  final String conversationId;
  final String messageId;
  final String reaction;
  final bool reactedByMe;
}

class ToggleChatReactionUseCase {
  const ToggleChatReactionUseCase({required this.repository});

  final ChatRepository repository;

  Future<Result<void>> call(ToggleChatReactionParams params) {
    return repository.toggleReaction(
      conversationId: params.conversationId,
      messageId: params.messageId,
      reaction: params.reaction,
      reactedByMe: params.reactedByMe,
    );
  }
}
