import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/domain/entities/chat/chat_message.dart';

class ChatThreadState implements BaseState {
  const ChatThreadState({
    required this.conversationId,
    required this.title,
    this.pageStatus = PageStatus.initial,
    this.processing = false,
    this.failure,
    this.messages = const [],
    this.page = 1,
    this.pageSize = 40,
    this.hasMore = false,
    this.loadingMore = false,
    this.sending = false,
    this.callStarting = false,
    this.sendingImagePath = '',
  });

  final String conversationId;
  final String title;
  @override
  final PageStatus pageStatus;
  @override
  final bool processing;
  @override
  final AppFailure? failure;
  final List<ChatMessage> messages;
  final int page;
  final int pageSize;
  final bool hasMore;
  final bool loadingMore;
  final bool sending;
  final bool callStarting;
  final String sendingImagePath;

  ChatThreadState copyWith({
    PageStatus? pageStatus,
    bool? processing,
    AppFailure? failure,
    bool clearFailure = false,
    List<ChatMessage>? messages,
    int? page,
    int? pageSize,
    bool? hasMore,
    bool? loadingMore,
    bool? sending,
    bool? callStarting,
    String? sendingImagePath,
  }) {
    return ChatThreadState(
      conversationId: conversationId,
      title: title,
      pageStatus: pageStatus ?? this.pageStatus,
      processing: processing ?? this.processing,
      failure: clearFailure ? null : failure ?? this.failure,
      messages: messages ?? this.messages,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      hasMore: hasMore ?? this.hasMore,
      loadingMore: loadingMore ?? this.loadingMore,
      sending: sending ?? this.sending,
      callStarting: callStarting ?? this.callStarting,
      sendingImagePath: sendingImagePath ?? this.sendingImagePath,
    );
  }

  @override
  ChatThreadState copyWithBase({
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
