import 'dart:async';

import 'package:flutter/material.dart';
import 'package:imovie_app/domain/entities/community/community_post.dart';
import 'package:imovie_app/domain/entities/community/community_story.dart';
import 'package:imovie_app/presentation/ui/community/feed/widgets/community_empty_view.dart';
import 'package:imovie_app/presentation/ui/community/feed/widgets/community_inline_composer.dart';
import 'package:imovie_app/presentation/ui/community/feed/widgets/community_post_card.dart';
import 'package:imovie_app/presentation/ui/community/feed/widgets/community_story_section.dart';
import 'package:imovie_app/presentation/widgets/imovie_smart_refresher.dart';

class CommunityFeedView extends StatelessWidget {
  const CommunityFeedView({
    super.key,
    required this.showStories,
    required this.stories,
    required this.posts,
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
    required this.onRefresh,
    required this.onCreateStoryTap,
    required this.onDeleteStoryTap,
    required this.onCreateTap,
    required this.onLoadMore,
    required this.onReactionTap,
    required this.onCommentTap,
    required this.onEditTap,
    required this.onDeleteTap,
    required this.onAuthorTap,
  });

  final bool showStories;
  final List<CommunityStory> stories;
  final List<CommunityPost> posts;
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
  final Future<bool> Function() onRefresh;
  final VoidCallback onCreateStoryTap;
  final ValueChanged<CommunityStory> onDeleteStoryTap;
  final FutureOr<void> Function() onCreateTap;
  final Future<IMovieLoadMoreResult> Function() onLoadMore;
  final ValueChanged<CommunityPost> onReactionTap;
  final ValueChanged<CommunityPost> onCommentTap;
  final ValueChanged<CommunityPost> onEditTap;
  final ValueChanged<CommunityPost> onDeleteTap;
  final ValueChanged<String> onAuthorTap;

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return IMovieSmartRefresher(
        onRefresh: onRefresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 112),
          children: [
            CommunityInlineComposer(
              prompt: composerPrompt,
              createLabel: createLabel,
              movieLabel: movieHintLabel,
              imageLabel: imageActionLabel,
              onSubmitted: onCreateTap,
            ),
            if (showStories) ...[
              const SizedBox(height: 18),
              CommunityStorySection(
                stories: stories,
                title: storiesTitle,
                createLabel: createStoryLabel,
                deleteLabel: deleteLabel,
                onCreateTap: onCreateStoryTap,
                onDeleteTap: onDeleteStoryTap,
                onAuthorTap: onAuthorTap,
              ),
            ],
            const SizedBox(height: 18),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.46,
              child: CommunityEmptyView(
                title: emptyTitle,
                subtitle: emptySubtitle,
              ),
            ),
          ],
        ),
      );
    }

    return IMovieSmartRefresher(
      onRefresh: onRefresh,
      onLoadMore: onLoadMore,
      enablePullUp: true,
      hasMore: hasMore,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 112),
        itemBuilder: (context, index) {
          if (index == 0) {
            return CommunityInlineComposer(
              prompt: composerPrompt,
              createLabel: createLabel,
              movieLabel: movieHintLabel,
              imageLabel: imageActionLabel,
              onSubmitted: onCreateTap,
            );
          }

          if (showStories && index == 1) {
            return CommunityStorySection(
              stories: stories,
              title: storiesTitle,
              createLabel: createStoryLabel,
              deleteLabel: deleteLabel,
              onCreateTap: onCreateStoryTap,
              onDeleteTap: onDeleteStoryTap,
              onAuthorTap: onAuthorTap,
            );
          }

          final postIndex = index - (showStories ? 2 : 1);
          final post = posts[postIndex];
          return CommunityPostCard(
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
          );
        },
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemCount: posts.length + (showStories ? 2 : 1),
      ),
    );
  }
}
