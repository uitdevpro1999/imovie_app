import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/domain/entities/community/community_post.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/common/pages/base_page.dart';
import 'package:imovie_app/presentation/ui/community/feed/widgets/community_comments_sheet.dart';
import 'package:imovie_app/presentation/ui/community/post_detail/community_post_detail_cubit.dart';
import 'package:imovie_app/presentation/ui/community/post_detail/community_post_detail_state.dart';
import 'package:imovie_app/presentation/ui/community/post_detail/widgets/community_post_detail_content.dart';
import 'package:imovie_app/presentation/widgets/imovie_app_bar.dart';
import 'package:imovie_app/presentation/widgets/imovie_buttons.dart';

@RoutePage()
class CommunityPostDetailPage
    extends BasePage<CommunityPostDetailCubit, CommunityPostDetailState>
    implements AutoRouteWrapper {
  const CommunityPostDetailPage({super.key, required this.postId});

  final String postId;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CommunityPostDetailCubit>(param1: postId),
      child: this,
    );
  }

  @override
  Widget wrapPage(
    BuildContext context,
    CommunityPostDetailState state,
    Widget child,
  ) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.grayscale950,
      appBar: IMovieAppBar(title: l10n.communityTitle),
      body: SafeArea(top: false, child: child),
    );
  }

  @override
  Widget buildPage(
    BuildContext context,
    CommunityPostDetailCubit cubit,
    CommunityPostDetailState state,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final post = state.post;
    if (post == null) {
      return const SizedBox.shrink();
    }

    return CommunityPostDetailContent(
      post: post,
      movieAttachmentLabel: l10n.communityPostMovieLabel,
      likeLabel: l10n.communityLikeAction,
      commentLabel: l10n.communityCommentAction,
      editLabel: l10n.communityEditAction,
      deleteLabel: l10n.communityDeleteAction,
      onAuthorTap: () => _openProfile(context, post.userId),
      onReactionTap: cubit.toggleReaction,
      onCommentTap: () => _openComments(context, cubit, post),
      onEditTap: () =>
          context.router.root.push(CommunityComposeRoute(initialPost: post)),
      onDeleteTap: () async {
        final deleted = await cubit.deletePost(
          successMessage: l10n.communityDeleteSuccess,
        );
        if (deleted && context.mounted && context.router.canPop()) {
          context.router.pop();
        }
      },
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message.isEmpty ? l10n.communityLoadError : message,
              textAlign: TextAlign.center,
              style: AppTypography.body1Regular.copyWith(
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 16),
            IMovieButton(
              label: l10n.retry,
              showLeadingIcon: false,
              foregroundColor: AppColors.textPrimary,
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }

  void _openComments(
    BuildContext context,
    CommunityPostDetailCubit cubit,
    CommunityPost post,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.grayscale950,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: BlocBuilder<CommunityPostDetailCubit, CommunityPostDetailState>(
          buildWhen: (previous, current) =>
              previous.comments != current.comments ||
              previous.loadingComments != current.loadingComments,
          builder: (context, state) {
            return CommunityCommentsSheet(
              post: state.post ?? post,
              comments: state.comments,
              loading: state.loadingComments,
              onLoad: cubit.loadComments,
              onSubmit: (content) => cubit.addComment(
                content: content,
                emptyMessage: AppLocalizations.of(
                  context,
                )!.communityCommentEmptyError,
              ),
            );
          },
        ),
      ),
    );
  }

  void _openProfile(BuildContext context, String userId) {
    final normalizedUserId = userId.trim();
    if (normalizedUserId.isEmpty) {
      return;
    }

    context.router.root.push(CommunityProfileRoute(userId: normalizedUserId));
  }
}
