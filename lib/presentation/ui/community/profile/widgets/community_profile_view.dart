import 'dart:async';

import 'package:flutter/material.dart';
import 'package:imovie_app/domain/entities/community/community_post.dart';
import 'package:imovie_app/domain/entities/community/community_profile.dart';
import 'package:imovie_app/domain/entities/community/community_story.dart';
import 'package:imovie_app/presentation/ui/community/feed/widgets/community_empty_view.dart';
import 'package:imovie_app/presentation/ui/community/feed/widgets/community_inline_composer.dart';
import 'package:imovie_app/presentation/ui/community/feed/widgets/community_post_card.dart';
import 'package:imovie_app/presentation/ui/community/feed/widgets/community_story_section.dart';
import 'package:imovie_app/presentation/ui/community/profile/widgets/community_profile_header.dart';
import 'package:imovie_app/presentation/widgets/imovie_smart_refresher.dart';

class CommunityProfileView extends StatelessWidget {
  const CommunityProfileView({
    super.key,
    required this.profile,
    required this.stories,
    required this.posts,
    required this.fallbackName,
    required this.followLabel,
    required this.followingLabel,
    required this.followersLabel,
    required this.followingCountLabel,
    required this.postsLabel,
    required this.storiesLabel,
    required this.storiesTitle,
    required this.createStoryLabel,
    required this.emptyTitle,
    required this.emptySubtitle,
    required this.composerPrompt,
    required this.createLabel,
    required this.movieHintLabel,
    required this.imageActionLabel,
    required this.movieAttachmentLabel,
    required this.likeLabel,
    required this.commentLabel,
    required this.editLabel,
    required this.deleteLabel,
    required this.hasMore,
    required this.followProcessing,
    required this.onRefresh,
    required this.onLoadMore,
    required this.onFollowTap,
    required this.onChatTap,
    required this.onDeleteStoryTap,
    required this.onCreateStoryTap,
    required this.onCreateTap,
    required this.onReactionTap,
    required this.onCommentTap,
    required this.onEditTap,
    required this.onDeleteTap,
    required this.onAuthorTap,
  });

  final CommunityProfile profile;
  final List<CommunityStory> stories;
  final List<CommunityPost> posts;
  final String fallbackName;
  final String followLabel;
  final String followingLabel;
  final String followersLabel;
  final String followingCountLabel;
  final String postsLabel;
  final String storiesLabel;
  final String storiesTitle;
  final String createStoryLabel;
  final String emptyTitle;
  final String emptySubtitle;
  final String composerPrompt;
  final String createLabel;
  final String movieHintLabel;
  final String imageActionLabel;
  final String movieAttachmentLabel;
  final String likeLabel;
  final String commentLabel;
  final String editLabel;
  final String deleteLabel;
  final bool hasMore;
  final bool followProcessing;
  final Future<bool> Function() onRefresh;
  final Future<IMovieLoadMoreResult> Function() onLoadMore;
  final VoidCallback onFollowTap;
  final VoidCallback onChatTap;
  final ValueChanged<CommunityStory> onDeleteStoryTap;
  final VoidCallback onCreateStoryTap;
  final FutureOr<void> Function() onCreateTap;
  final ValueChanged<CommunityPost> onReactionTap;
  final ValueChanged<CommunityPost> onCommentTap;
  final ValueChanged<CommunityPost> onEditTap;
  final ValueChanged<CommunityPost> onDeleteTap;
  final ValueChanged<String> onAuthorTap;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      CommunityProfileHeader(
        profile: profile,
        fallbackName: fallbackName,
        followLabel: followLabel,
        followingLabel: followingLabel,
        followersLabel: followersLabel,
        followingCountLabel: followingCountLabel,
        postsLabel: postsLabel,
        storiesLabel: storiesLabel,
        followProcessing: followProcessing,
        onFollowTap: onFollowTap,
        onChatTap: onChatTap,
      ),
      if (profile.isMe)
        CommunityInlineComposer(
          prompt: composerPrompt,
          createLabel: createLabel,
          movieLabel: movieHintLabel,
          imageLabel: imageActionLabel,
          onSubmitted: onCreateTap,
        ),
      if (profile.isMe || stories.isNotEmpty)
        CommunityStorySection(
          stories: stories,
          title: storiesTitle,
          createLabel: profile.isMe ? createStoryLabel : '',
          deleteLabel: deleteLabel,
          showCreateCard: profile.isMe,
          onCreateTap: onCreateStoryTap,
          onDeleteTap: onDeleteStoryTap,
          onAuthorTap: onAuthorTap,
        ),
      if (posts.isEmpty)
        CommunityEmptyView(title: emptyTitle, subtitle: emptySubtitle)
      else
        ...posts.map(
          (post) => CommunityPostCard(
            post: post,
            movieAttachmentLabel: movieAttachmentLabel,
            likeLabel: likeLabel,
            commentLabel: commentLabel,
            editLabel: editLabel,
            deleteLabel: deleteLabel,
            onAuthorTap: () => onAuthorTap(post.userId),
            onReactionTap: () => onReactionTap(post),
            onCommentTap: () => onCommentTap(post),
            onEditTap: () => onEditTap(post),
            onDeleteTap: () => onDeleteTap(post),
          ),
        ),
    ];

    return IMovieSmartRefresher(
      onRefresh: onRefresh,
      onLoadMore: onLoadMore,
      enablePullUp: posts.isNotEmpty,
      hasMore: hasMore,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 112),
        itemBuilder: (context, index) => children[index],
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemCount: children.length,
      ),
    );
  }
}
