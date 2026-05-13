import 'dart:async';

import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/logger/app_logger.dart';
import 'package:imovie_app/domain/usecases/chat/get_chat_conversations_use_case.dart';
import 'package:imovie_app/domain/usecases/chat/watch_chat_conversations_use_case.dart';
import 'package:imovie_app/presentation/ui/chat/list/chat_list_state.dart';
import 'package:imovie_app/presentation/widgets/imovie_smart_refresher.dart';

class ChatListCubit extends BaseCubit<ChatListState> {
  ChatListCubit({
    required GetChatConversationsUseCase getChatConversationsUseCase,
    required WatchChatConversationsUseCase watchChatConversationsUseCase,
  }) : _getChatConversationsUseCase = getChatConversationsUseCase,
       _watchChatConversationsUseCase = watchChatConversationsUseCase,
       super(const ChatListState());

  final GetChatConversationsUseCase _getChatConversationsUseCase;
  final WatchChatConversationsUseCase _watchChatConversationsUseCase;
  StreamSubscription<void>? _conversationSubscription;

  @override
  Future<void> initData() async {
    await load();
    _conversationSubscription ??= _watchChatConversationsUseCase().listen(
      (_) => unawaited(refresh()),
      onError: (Object error, StackTrace stackTrace) {
        AppLogger.error(
          'Chat conversation watcher failed.',
          name: 'ChatList',
          error: error,
          stackTrace: stackTrace,
        );
      },
    );
  }

  Future<bool> load({bool showLoading = true}) async {
    if (showLoading) {
      emit(
        state.copyWith(
          pageStatus: state.conversations.isEmpty
              ? PageStatus.loading
              : PageStatus.loaded,
          processing: state.conversations.isNotEmpty,
          clearFailure: true,
        ),
      );
    }

    final result = await _getChatConversationsUseCase(
      GetChatConversationsParams(page: 1, limit: state.pageSize),
    );
    return result.map(
      success: (conversations) {
        emit(
          state.copyWith(
            pageStatus: PageStatus.loaded,
            processing: false,
            conversations: conversations,
            page: 1,
            hasMore: conversations.length == state.pageSize,
            clearFailure: true,
          ),
        );
        return true;
      },
      failure: (failure) {
        emit(
          state.copyWith(
            pageStatus: showLoading && state.conversations.isEmpty
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

  Future<IMovieLoadMoreResult> loadMore() async {
    if (state.loadingMore || !state.hasMore) {
      return IMovieLoadMoreResult.success(hasMore: state.hasMore);
    }

    final nextPage = state.page + 1;
    emit(state.copyWith(loadingMore: true, clearFailure: true));
    final result = await _getChatConversationsUseCase(
      GetChatConversationsParams(page: nextPage, limit: state.pageSize),
    );
    return result.map(
      success: (conversations) {
        final existingIds = state.conversations.map((item) => item.id).toSet();
        final nextItems = conversations
            .where((item) => !existingIds.contains(item.id))
            .toList(growable: false);
        emit(
          state.copyWith(
            conversations: [...state.conversations, ...nextItems],
            page: nextPage,
            hasMore: conversations.length == state.pageSize,
            loadingMore: false,
            clearFailure: true,
          ),
        );
        return IMovieLoadMoreResult.success(hasMore: state.hasMore);
      },
      failure: (failure) {
        emit(state.copyWith(loadingMore: false, failure: failure));
        showFailureToast(failure);
        return const IMovieLoadMoreResult.failure();
      },
    );
  }

  @override
  Future<void> close() async {
    await _conversationSubscription?.cancel();
    return super.close();
  }
}
