import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/domain/entities/community/community_post.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/common/pages/base_page.dart';
import 'package:imovie_app/presentation/ui/community/feed/widgets/community_comments_sheet.dart';
import 'package:imovie_app/presentation/ui/community/profile/community_profile_cubit.dart';
import 'package:imovie_app/presentation/ui/community/profile/community_profile_state.dart';
import 'package:imovie_app/presentation/ui/community/profile/widgets/community_profile_view.dart';
import 'package:imovie_app/presentation/widgets/imovie_app_bar.dart';
import 'package:imovie_app/presentation/widgets/imovie_buttons.dart';
import 'package:imovie_app/presentation/widgets/imovie_smart_refresher.dart';

@RoutePage()
class CommunityProfilePage
    extends BasePage<CommunityProfileCubit, CommunityProfileState>
    implements AutoRouteWrapper {
  const CommunityProfilePage({
    super.key,
    @PathParam('userId') this.userId = '',
  });

  final String userId;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CommunityProfileCubit>(param1: userId),
      child: this,
    );
  }

  @override
  Widget wrapPage(
    BuildContext context,
    CommunityProfileState state,
    Widget child,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final profileName = state.profile?.displayName.trim() ?? '';
    return Scaffold(
      backgroundColor: AppColors.grayscale950,
      appBar: IMovieAppBar(
        title: profileName.isEmpty ? l10n.communityProfileTitle : profileName,
        centerTitle: false,
        actions: state.profile?.isMe == true
            ? [
                _CommunityProfileOptionsButton(
                  editProfileLabel: l10n.profileSettingsProfile,
                  onEditProfile: () => _openEditProfile(context),
                ),
                const SizedBox(width: 8),
              ]
            : null,
      ),
      body: SafeArea(top: false, child: child),
    );
  }

  @override
  bool buildWhen(
    CommunityProfileState previous,
    CommunityProfileState current,
  ) {
    return previous.pageStatus != current.pageStatus ||
        previous.processing != current.processing ||
        previous.failure != current.failure ||
        previous.profile != current.profile ||
        previous.stories != current.stories ||
        previous.posts != current.posts ||
        previous.hasMore != current.hasMore ||
        previous.loadingMore != current.loadingMore ||
        previous.followProcessing != current.followProcessing;
  }

  @override
  Widget buildPage(
    BuildContext context,
    CommunityProfileCubit cubit,
    CommunityProfileState state,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final profile = state.profile;
    if (profile == null) {
      return buildError(context, l10n, l10n.communityLoadError, cubit.retry);
    }

    return CommunityProfileView(
      profile: profile,
      stories: state.stories,
      posts: state.posts,
      fallbackName: l10n.communityUserFallbackName,
      followLabel: l10n.communityFollowAction,
      followingLabel: l10n.communityFollowingAction,
      followersLabel: l10n.communityFollowersLabel,
      followingCountLabel: l10n.communityFollowingLabel,
      postsLabel: l10n.communityPostsLabel,
      storiesLabel: l10n.communityStoriesMetricLabel,
      storiesTitle: l10n.communityStoriesTitle,
      createStoryLabel: l10n.communityCreateStoryAction,
      emptyTitle: profile.isMe
          ? l10n.communityMyPostsEmptyTitle
          : l10n.communityProfileEmptyTitle,
      emptySubtitle: l10n.communityProfileEmptySubtitle,
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
      followProcessing: state.followProcessing,
      onRefresh: cubit.refresh,
      onLoadMore: () async {
        final success = await cubit.loadMore();
        return success
            ? IMovieLoadMoreResult.success(hasMore: cubit.state.hasMore)
            : const IMovieLoadMoreResult.failure();
      },
      onFollowTap: () => cubit.toggleFollow(
        followSuccessMessage: l10n.communityFollowSuccess,
        unfollowSuccessMessage: l10n.communityUnfollowSuccess,
      ),
      onChatTap: () async {
        final conversation = await cubit.openDirectConversation();
        if (conversation == null || !context.mounted) {
          return;
        }
        await context.router.push(
          ChatThreadRoute(
            conversationId: conversation.id,
            title: conversation.title,
            avatarUrl: conversation.avatarUrl,
          ),
        );
      },
      onDeleteStoryTap: (story) => cubit.deleteStory(
        storyId: story.id,
        successMessage: l10n.communityDeleteStorySuccess,
      ),
      onCreateStoryTap: () async =>
          context.router.root.push(const CommunityStoryEditorRoute()),
      onCreateTap: () async {},
      onReactionTap: cubit.toggleReaction,
      onCommentTap: (post) => _openComments(context, cubit, post),
      onEditTap: (post) =>
          context.router.root.push(CommunityComposeRoute(initialPost: post)),
      onDeleteTap: (post) => cubit.deletePost(
        post: post,
        successMessage: l10n.communityDeleteSuccess,
      ),
      onAuthorTap: (targetUserId) => _openProfile(context, targetUserId),
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
    CommunityProfileCubit cubit,
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
        child: BlocBuilder<CommunityProfileCubit, CommunityProfileState>(
          buildWhen: (previous, current) =>
              previous.commentsByPost[post.id] !=
                  current.commentsByPost[post.id] ||
              previous.loadingCommentPostIds.contains(post.id) !=
                  current.loadingCommentPostIds.contains(post.id),
          builder: (context, state) {
            return CommunityCommentsSheet(
              post: post,
              comments: state.commentsByPost[post.id] ?? const [],
              loading: state.loadingCommentPostIds.contains(post.id),
              onLoad: () => cubit.loadComments(post.id),
              onSubmit: (content) => cubit.addComment(
                post: post,
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

  void _openProfile(BuildContext context, String targetUserId) {
    final normalizedUserId = targetUserId.trim();
    if (normalizedUserId.isEmpty || normalizedUserId == userId) {
      return;
    }

    context.router.root.push(CommunityProfileRoute(userId: normalizedUserId));
  }

  Future<void> _openEditProfile(BuildContext context) async {
    final cubit = context.read<CommunityProfileCubit>();
    await context.router.root.push(ProfileRoute());
    await cubit.refresh();
  }
}

enum _CommunityProfileOption { editProfile }

class _CommunityProfileOptionsButton extends StatelessWidget {
  const _CommunityProfileOptionsButton({
    required this.editProfileLabel,
    required this.onEditProfile,
  });

  final String editProfileLabel;
  final VoidCallback onEditProfile;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_CommunityProfileOption>(
      color: AppColors.grayscale900,
      iconColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.grayscale800),
      ),
      icon: const Icon(FluentIcons.more_vertical_24_regular),
      onSelected: (option) {
        switch (option) {
          case _CommunityProfileOption.editProfile:
            onEditProfile();
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: _CommunityProfileOption.editProfile,
          child: Row(
            children: [
              const Icon(
                FluentIcons.person_edit_24_regular,
                size: 18,
                color: AppColors.white,
              ),
              const SizedBox(width: 10),
              Text(
                editProfileLabel,
                style: AppTypography.body2Medium.copyWith(
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
