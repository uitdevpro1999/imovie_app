import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/chat/chat_conversation.dart';
import 'package:imovie_app/domain/repositories/chat_repository.dart';

class GetChatConversationsParams {
  const GetChatConversationsParams({required this.page, required this.limit});

  final int page;
  final int limit;
}

class GetChatConversationsUseCase
    implements UseCase<List<ChatConversation>, GetChatConversationsParams> {
  const GetChatConversationsUseCase(this.repository);

  final ChatRepository repository;

  @override
  Future<Result<List<ChatConversation>>> call(
    GetChatConversationsParams params,
  ) {
    return repository.getConversations(page: params.page, limit: params.limit);
  }
}
