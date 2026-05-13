import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/common/pages/base_page.dart';
import 'package:imovie_app/presentation/ui/chat/list/chat_list_cubit.dart';
import 'package:imovie_app/presentation/ui/chat/list/chat_list_state.dart';
import 'package:imovie_app/presentation/ui/chat/list/widgets/chat_conversation_tile.dart';
import 'package:imovie_app/presentation/ui/chat/list/widgets/chat_empty_view.dart';
import 'package:imovie_app/presentation/ui/chat/list/widgets/chat_list_header.dart';
import 'package:imovie_app/presentation/widgets/imovie_app_bar.dart';
import 'package:imovie_app/presentation/widgets/imovie_smart_refresher.dart';

@RoutePage()
class ChatListPage extends BasePage<ChatListCubit, ChatListState>
    implements AutoRouteWrapper {
  const ChatListPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (_) => sl<ChatListCubit>(), child: this);
  }

  @override
  Widget wrapPage(BuildContext context, ChatListState state, Widget child) {
    return Scaffold(
      backgroundColor: AppColors.grayscale950,
      appBar: IMovieAppBar(
        title: 'Tin nhắn',
        centerTitle: false,
        backgroundColor: AppColors.grayscale950,
      ),
      body: SafeArea(top: false, child: child),
    );
  }

  @override
  Widget buildPage(
    BuildContext context,
    ChatListCubit cubit,
    ChatListState state,
  ) {
    if (state.conversations.isEmpty) {
      return IMovieSmartRefresher(
        onRefresh: cubit.refresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 112),
          children: const [ChatEmptyView()],
        ),
      );
    }

    final unreadTotal = state.conversations.fold<int>(
      0,
      (total, item) => total + item.unreadCount,
    );

    return IMovieSmartRefresher(
      onRefresh: cubit.refresh,
      onLoadMore: cubit.loadMore,
      enablePullUp: state.hasMore,
      hasMore: state.hasMore,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 112),
        itemCount: state.conversations.length + 1,
        separatorBuilder: (_, index) => SizedBox(height: index == 0 ? 12 : 10),
        itemBuilder: (context, index) {
          if (index == 0) {
            return ChatListHeader(
              conversationCount: state.conversations.length,
              unreadCount: unreadTotal,
            );
          }

          final conversation = state.conversations[index - 1];
          return ChatConversationTile(
            conversation: conversation,
            onTap: () => context.router.push(
              ChatThreadRoute(
                conversationId: conversation.id,
                title: conversation.title,
                avatarUrl: conversation.avatarUrl,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildError(
    BuildContext context,
    AppLocalizations l10n,
    String message,
    VoidCallback onRetry,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          message.isEmpty ? 'Không thể tải tin nhắn.' : message,
          textAlign: TextAlign.center,
          style: AppTypography.body1Regular.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
