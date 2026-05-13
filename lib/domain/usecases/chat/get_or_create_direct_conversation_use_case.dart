import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/chat/chat_conversation.dart';
import 'package:imovie_app/domain/repositories/chat_repository.dart';

class GetOrCreateDirectConversationParams {
  const GetOrCreateDirectConversationParams({required this.userId});

  final String userId;
}

class GetOrCreateDirectConversationUseCase
    implements UseCase<ChatConversation, GetOrCreateDirectConversationParams> {
  const GetOrCreateDirectConversationUseCase(this.repository);

  final ChatRepository repository;

  @override
  Future<Result<ChatConversation>> call(
    GetOrCreateDirectConversationParams params,
  ) {
    return repository.getOrCreateDirectConversation(userId: params.userId);
  }
}
