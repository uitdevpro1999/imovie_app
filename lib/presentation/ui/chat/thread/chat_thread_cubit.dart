import 'dart:async';

import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/core/events/app_event_bus.dart';
import 'package:imovie_app/core/events/app_notification_event.dart';
import 'package:imovie_app/core/logger/app_logger.dart';
import 'package:imovie_app/core/services/supabase_data_service.dart';
import 'package:imovie_app/domain/entities/call/call_session.dart';
import 'package:imovie_app/domain/entities/chat/chat_message.dart';
import 'package:imovie_app/domain/usecases/call/start_call_use_case.dart';
import 'package:imovie_app/domain/usecases/chat/get_chat_messages_use_case.dart';
import 'package:imovie_app/domain/usecases/chat/mark_chat_conversation_read_use_case.dart';
import 'package:imovie_app/domain/usecases/chat/recall_chat_message_use_case.dart';
import 'package:imovie_app/domain/usecases/chat/send_chat_image_use_case.dart';
import 'package:imovie_app/domain/usecases/chat/send_chat_message_use_case.dart';
import 'package:imovie_app/domain/usecases/chat/toggle_chat_reaction_use_case.dart';
import 'package:imovie_app/domain/usecases/chat/watch_chat_messages_use_case.dart';
import 'package:imovie_app/presentation/ui/chat/thread/chat_thread_state.dart';

class ChatThreadCubit extends BaseCubit<ChatThreadState> {
  ChatThreadCubit({
    required String conversationId,
    required String title,
    required GetChatMessagesUseCase getChatMessagesUseCase,
    required SendChatMessageUseCase sendChatMessageUseCase,
    required SendChatImageUseCase sendChatImageUseCase,
    required RecallChatMessageUseCase recallChatMessageUseCase,
    required ToggleChatReactionUseCase toggleChatReactionUseCase,
    required MarkChatConversationReadUseCase markChatConversationReadUseCase,
    required WatchChatMessagesUseCase watchChatMessagesUseCase,
    required StartCallUseCase startCallUseCase,
  }) : _getChatMessagesUseCase = getChatMessagesUseCase,
       _sendChatMessageUseCase = sendChatMessageUseCase,
       _sendChatImageUseCase = sendChatImageUseCase,
       _recallChatMessageUseCase = recallChatMessageUseCase,
       _toggleChatReactionUseCase = toggleChatReactionUseCase,
       _markChatConversationReadUseCase = markChatConversationReadUseCase,
       _watchChatMessagesUseCase = watchChatMessagesUseCase,
       _startCallUseCase = startCallUseCase,
       super(ChatThreadState(conversationId: conversationId, title: title));

  final GetChatMessagesUseCase _getChatMessagesUseCase;
  final SendChatMessageUseCase _sendChatMessageUseCase;
  final SendChatImageUseCase _sendChatImageUseCase;
  final RecallChatMessageUseCase _recallChatMessageUseCase;
  final ToggleChatReactionUseCase _toggleChatReactionUseCase;
  final MarkChatConversationReadUseCase _markChatConversationReadUseCase;
  final WatchChatMessagesUseCase _watchChatMessagesUseCase;
  final StartCallUseCase _startCallUseCase;
  StreamSubscription<void>? _messageSubscription;

  @override
  Future<void> initData() async {
    await load();
    unawaited(_markConversationReadSafely());
    _messageSubscription ??= _watchChatMessagesUseCase(state.conversationId).listen(
      (_) => unawaited(refresh()),
      onError: (Object error, StackTrace stackTrace) {
        AppLogger.error(
          'Chat message watcher failed conversation=${AppLogger.shortId(state.conversationId)}.',
          name: 'ChatThread',
          error: error,
          stackTrace: stackTrace,
        );
      },
    );
  }

  Future<void> _markConversationReadSafely() async {
    final result = await _markChatConversationReadUseCase(
      MarkChatConversationReadParams(conversationId: state.conversationId),
    );
    result.map(
      success: (_) =>
          appEventBus.emitNotification(AppNotificationEvent.changed()),
      failure: (failure) {
        AppLogger.warning(
          'Mark conversation read failed conversation=${AppLogger.shortId(state.conversationId)} '
          'message=${failure.message}',
          name: 'ChatThread',
        );
      },
    );
  }

  Future<bool> load({bool showLoading = true}) async {
    if (showLoading) {
      emit(
        state.copyWith(
          pageStatus: state.messages.isEmpty
              ? PageStatus.loading
              : PageStatus.loaded,
          processing: state.messages.isNotEmpty,
          clearFailure: true,
        ),
      );
    }
    final result = await _getChatMessagesUseCase(
      GetChatMessagesParams(
        conversationId: state.conversationId,
        page: 1,
        limit: state.pageSize,
      ),
    );
    return result.map(
      success: (messages) {
        emit(
          state.copyWith(
            pageStatus: PageStatus.loaded,
            processing: false,
            messages: messages,
            page: 1,
            hasMore: messages.length == state.pageSize,
            clearFailure: true,
          ),
        );
        return true;
      },
      failure: (failure) {
        emit(
          state.copyWith(
            pageStatus: showLoading && state.messages.isEmpty
                ? PageStatus.error
                : PageStatus.loaded,
            processing: false,
            failure: failure,
          ),
        );
        showFailureToast(failure);
        return false;
      },
    );
  }

  Future<bool> refresh() => load(showLoading: false);

  Future<bool> sendMessage(String value) async {
    final body = value.trim();
    if (body.isEmpty || state.sending) {
      return false;
    }

    final pendingMessage = _pendingMessage(
      body: body,
      type: ChatMessageType.text,
    );
    emit(state.copyWith(sending: true, clearFailure: true));
    _appendMessage(pendingMessage);
    final result = await _sendChatMessageUseCase(
      SendChatMessageParams(conversationId: state.conversationId, body: body),
    );
    return result.map(
      success: (message) {
        _replaceMessage(
          pendingMessage.id,
          message.copyWith(status: message.status),
          sending: false,
        );
        return true;
      },
      failure: (failure) {
        _replaceMessage(
          pendingMessage.id,
          pendingMessage.copyWith(status: ChatMessageStatus.failed),
          sending: false,
          failure: failure,
        );
        showFailureToast(failure);
        return false;
      },
    );
  }

  Future<bool> sendImage({
    required String imagePath,
    required String fileName,
  }) async {
    if (imagePath.trim().isEmpty || state.sending) {
      return false;
    }

    final pendingMessage = _pendingMessage(
      body: imagePath,
      type: ChatMessageType.image,
    );
    emit(
      state.copyWith(
        sending: true,
        sendingImagePath: imagePath,
        clearFailure: true,
      ),
    );
    _appendMessage(pendingMessage);
    final result = await _sendChatImageUseCase(
      SendChatImageParams(
        conversationId: state.conversationId,
        imagePath: imagePath,
        fileName: fileName.trim().isEmpty ? 'image' : fileName.trim(),
      ),
    );
    return result.map(
      success: (message) {
        _replaceMessage(
          pendingMessage.id,
          message.copyWith(status: message.status),
          sending: false,
          sendingImagePath: '',
        );
        return true;
      },
      failure: (failure) {
        _replaceMessage(
          pendingMessage.id,
          pendingMessage.copyWith(status: ChatMessageStatus.failed),
          sending: false,
          sendingImagePath: '',
          failure: failure,
        );
        showFailureToast(failure);
        return false;
      },
    );
  }

  Future<bool> retryMessage(ChatMessage message) {
    if (message.status != ChatMessageStatus.failed || state.sending) {
      return Future.value(false);
    }

    _removeMessage(message.id);
    if (message.type == ChatMessageType.image) {
      return sendImage(imagePath: message.body, fileName: 'image');
    }
    return sendMessage(message.body);
  }

  Future<bool> recallMessage(ChatMessage message) async {
    final currentUserId = sl<SupabaseDataService>().getCurrentUserId();
    if (message.senderId != currentUserId) {
      return false;
    }

    if (message.id.startsWith('local_')) {
      _removeMessage(message.id);
      return true;
    }

    emit(state.copyWith(processing: true, clearFailure: true));
    final result = await _recallChatMessageUseCase(
      RecallChatMessageParams(messageId: message.id),
    );
    return result.map(
      success: (_) {
        _markMessageDeleted(message.id);
        emit(state.copyWith(processing: false, clearFailure: true));
        return true;
      },
      failure: (failure) {
        emit(state.copyWith(processing: false, failure: failure));
        showFailureToast(failure);
        return false;
      },
    );
  }

  Future<bool> toggleReaction(ChatMessage message, String reaction) async {
    final normalizedReaction = reaction.trim();
    if (normalizedReaction.isEmpty ||
        message.id.startsWith('local_') ||
        message.type == ChatMessageType.system ||
        message.isDeleted) {
      return false;
    }

    final reactedByMe = message.reactions.any(
      (item) => item.reaction == normalizedReaction && item.reactedByMe,
    );
    _applyOptimisticReaction(
      messageId: message.id,
      reaction: normalizedReaction,
      reactedByMe: reactedByMe,
    );
    final result = await _toggleChatReactionUseCase(
      ToggleChatReactionParams(
        conversationId: state.conversationId,
        messageId: message.id,
        reaction: normalizedReaction,
        reactedByMe: reactedByMe,
      ),
    );
    return result.map(
      success: (_) => true,
      failure: (failure) {
        _applyOptimisticReaction(
          messageId: message.id,
          reaction: normalizedReaction,
          reactedByMe: !reactedByMe,
        );
        showFailureToast(failure);
        return false;
      },
    );
  }

  ChatMessage _pendingMessage({
    required String body,
    required ChatMessageType type,
  }) {
    final userId = sl<SupabaseDataService>().getCurrentUserId();
    return ChatMessage(
      id: 'local_${DateTime.now().microsecondsSinceEpoch}',
      conversationId: state.conversationId,
      senderId: userId,
      senderName: '',
      senderAvatarUrl: '',
      body: body,
      type: type,
      status: ChatMessageStatus.sending,
      createdAt: DateTime.now(),
      deletedAt: null,
    );
  }

  void _appendMessage(ChatMessage message) {
    emit(state.copyWith(messages: [...state.messages, message]));
  }

  void _removeMessage(String messageId) {
    emit(
      state.copyWith(
        messages: state.messages
            .where((message) => message.id != messageId)
            .toList(growable: false),
      ),
    );
  }

  void _markMessageDeleted(String messageId) {
    emit(
      state.copyWith(
        messages: state.messages
            .map(
              (message) => message.id == messageId
                  ? message.copyWith(deletedAt: DateTime.now())
                  : message,
            )
            .toList(growable: false),
      ),
    );
  }

  void _applyOptimisticReaction({
    required String messageId,
    required String reaction,
    required bool reactedByMe,
  }) {
    emit(
      state.copyWith(
        messages: state.messages
            .map((message) {
              if (message.id != messageId) {
                return message;
              }
              final reactions = [...message.reactions];
              final index = reactions.indexWhere(
                (item) => item.reaction == reaction,
              );
              if (reactedByMe) {
                if (index < 0) {
                  return message;
                }
                final current = reactions[index];
                final nextCount = current.count - 1;
                if (nextCount <= 0) {
                  reactions.removeAt(index);
                } else {
                  reactions[index] = ChatMessageReaction(
                    reaction: reaction,
                    count: nextCount,
                    reactedByMe: false,
                  );
                }
              } else if (index < 0) {
                reactions.add(
                  ChatMessageReaction(
                    reaction: reaction,
                    count: 1,
                    reactedByMe: true,
                  ),
                );
              } else {
                final current = reactions[index];
                reactions[index] = ChatMessageReaction(
                  reaction: reaction,
                  count: current.count + 1,
                  reactedByMe: true,
                );
              }
              return message.copyWith(reactions: reactions);
            })
            .toList(growable: false),
      ),
    );
  }

  void _replaceMessage(
    String targetId,
    ChatMessage replacement, {
    required bool sending,
    AppFailure? failure,
    String? sendingImagePath,
  }) {
    emit(
      state.copyWith(
        sending: sending,
        sendingImagePath: sendingImagePath,
        failure: failure,
        clearFailure: failure == null,
        messages: state.messages
            .map((message) => message.id == targetId ? replacement : message)
            .toList(growable: false),
      ),
    );
  }

  Future<CallSession?> startCall(CallType type) async {
    if (state.callStarting) {
      return null;
    }
    emit(
      state.copyWith(processing: true, callStarting: true, clearFailure: true),
    );
    final result = await _startCallUseCase(
      StartCallParams(conversationId: state.conversationId, type: type),
    );
    return result.map(
      success: (call) {
        emit(
          state.copyWith(
            processing: false,
            callStarting: false,
            clearFailure: true,
          ),
        );
        return call;
      },
      failure: (failure) {
        emit(
          state.copyWith(
            processing: false,
            callStarting: false,
            failure: failure,
          ),
        );
        showFailureToast(failure);
        return null;
      },
    );
  }

  @override
  Future<void> close() async {
    await _messageSubscription?.cancel();
    return super.close();
  }
}
