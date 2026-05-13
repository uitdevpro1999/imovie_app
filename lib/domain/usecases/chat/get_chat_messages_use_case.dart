import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/chat/chat_message.dart';
import 'package:imovie_app/domain/repositories/chat_repository.dart';

class GetChatMessagesParams {
  const GetChatMessagesParams({
    required this.conversationId,
    required this.page,
    required this.limit,
  });

  final String conversationId;
  final int page;
  final int limit;
}

class GetChatMessagesUseCase
    implements UseCase<List<ChatMessage>, GetChatMessagesParams> {
  const GetChatMessagesUseCase(this.repository);

  final ChatRepository repository;

  @override
  Future<Result<List<ChatMessage>>> call(GetChatMessagesParams params) {
    return repository.getMessages(
      conversationId: params.conversationId,
      page: params.page,
      limit: params.limit,
    );
  }
}
