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
import 'package:imovie_app/presentation/ui/community/feed/community_cubit.dart';
import 'package:imovie_app/presentation/ui/community/feed/community_state.dart';
import 'package:imovie_app/presentation/ui/community/feed/widgets/community_comments_sheet.dart';
import 'package:imovie_app/presentation/ui/community/feed/widgets/community_feed_view.dart';
import 'package:imovie_app/presentation/widgets/imovie_app_bar.dart';
import 'package:imovie_app/presentation/widgets/imovie_buttons.dart';
import 'package:imovie_app/presentation/widgets/imovie_smart_refresher.dart';

@RoutePage()
class CommunityPage extends BasePage<CommunityCubit, CommunityState>
    implements AutoRouteWrapper {
  const CommunityPage({super.key, this.mineOnly = false});

  final bool mineOnly;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CommunityCubit>(param1: mineOnly),
      child: this,
    );
  }

  @override
  Widget wrapPage(BuildContext context, CommunityState state, Widget child) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.grayscale950,
      appBar: IMovieAppBar(
        title: mineOnly ? l10n.communityMyPostsTitle : l10n.communityTitle,
        centerTitle: false,
      ),
      body: SafeArea(top: false, child: child),
    );
  }

  @override
  Widget buildPage(
    BuildContext context,
    CommunityCubit cubit,
    CommunityState state,
  ) {
    final l10n = AppLocalizations.of(context)!;
    return CommunityFeedView(
      showStories: !state.mineOnly,
      stories: state.mineOnly ? const [] : state.stories,
      posts: state.posts,
      storiesTitle: l10n.communityStoriesTitle,
      createStoryLabel: l10n.communityCreateStoryAction,
      emptyTitle: state.mineOnly
          ? l10n.communityMyPostsEmptyTitle
          : l10n.communityEmptyTitle,
      emptySubtitle: l10n.communityEmptySubtitle,
      composerPrompt: l10n.communityComposerPrompt,
      createLabel: l10n.communityPublishAction,
      movieHintLabel: l10n.communityMovieHint,
      imageActionLabel: l10n.communityPickImageAction,
      movieAttachmentLabel: l10n.communityPostMovieLabel,
      likeLabel: l10n.communityLikeAction,
      commentLabel: l10n.communityCommentAction,
      editLabel: l10n.communityEditAction,
      deleteLabel: l10n.communityDeleteAction,
      hasMore: state.hasMore,
      onRefresh: cubit.refresh,
      onCreateStoryTap: () =>
          context.router.root.push(const CommunityStoryEditorRoute()),
      onDeleteStoryTap: (story) => cubit.deleteStory(
        story: story,
        successMessage: l10n.communityDeleteStorySuccess,
      ),
      onCreateTap: () => context.router.root.push(CommunityComposeRoute()),
      onLoadMore: () async {
        final success = await cubit.loadMore();
        return success
            ? IMovieLoadMoreResult.success(hasMore: cubit.state.hasMore)
            : const IMovieLoadMoreResult.failure();
      },
      onReactionTap: cubit.toggleReaction,
      onCommentTap: (post) => _openComments(context, cubit, post),
      onEditTap: (post) =>
          context.router.root.push(CommunityComposeRoute(initialPost: post)),
      onDeleteTap: (post) => cubit.deletePost(
        post: post,
        successMessage: l10n.communityDeleteSuccess,
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
    CommunityCubit cubit,
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
        child: CommunityCommentsSheet(post: post),
      ),
    );
  }
}
