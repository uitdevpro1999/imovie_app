import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/domain/entities/chat/chat_conversation.dart';

class ChatListState implements BaseState {
  const ChatListState({
    this.pageStatus = PageStatus.initial,
    this.processing = false,
    this.failure,
    this.conversations = const [],
    this.page = 1,
    this.pageSize = 24,
    this.hasMore = false,
    this.loadingMore = false,
  });

  @override
  final PageStatus pageStatus;
  @override
  final bool processing;
  @override
  final AppFailure? failure;
  final List<ChatConversation> conversations;
  final int page;
  final int pageSize;
  final bool hasMore;
  final bool loadingMore;

  ChatListState copyWith({
    PageStatus? pageStatus,
    bool? processing,
    AppFailure? failure,
    bool clearFailure = false,
    List<ChatConversation>? conversations,
    int? page,
    int? pageSize,
    bool? hasMore,
    bool? loadingMore,
  }) {
    return ChatListState(
      pageStatus: pageStatus ?? this.pageStatus,
      processing: processing ?? this.processing,
      failure: clearFailure ? null : failure ?? this.failure,
      conversations: conversations ?? this.conversations,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      hasMore: hasMore ?? this.hasMore,
      loadingMore: loadingMore ?? this.loadingMore,
    );
  }

  @override
  ChatListState copyWithBase({
    PageStatus? pageStatus,
    bool? processing,
    AppFailure? failure,
    bool clearFailure = false,
  }) {
    return copyWith(
      pageStatus: pageStatus,
      processing: processing,
      failure: failure,
      clearFailure: clearFailure,
    );
  }
}
