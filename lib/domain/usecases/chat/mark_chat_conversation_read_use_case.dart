import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/repositories/chat_repository.dart';

class MarkChatConversationReadParams {
  const MarkChatConversationReadParams({required this.conversationId});

  final String conversationId;
}

class MarkChatConversationReadUseCase
    implements UseCase<void, MarkChatConversationReadParams> {
  const MarkChatConversationReadUseCase(this.repository);

  final ChatRepository repository;

  @override
  Future<Result<void>> call(MarkChatConversationReadParams params) {
    return repository.markConversationRead(params.conversationId);
  }
}
