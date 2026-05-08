import 'package:flutter/material.dart';
import 'package:imovie_app/domain/entities/community/community_post.dart';
import 'package:imovie_app/presentation/ui/community/feed/widgets/community_post_card.dart';

class CommunityPostDetailContent extends StatelessWidget {
  const CommunityPostDetailContent({
    super.key,
    required this.post,
    required this.movieAttachmentLabel,
    required this.likeLabel,
    required this.commentLabel,
    required this.editLabel,
    required this.deleteLabel,
    required this.onAuthorTap,
    required this.onReactionTap,
    required this.onCommentTap,
    required this.onEditTap,
    required this.onDeleteTap,
  });

  final CommunityPost post;
  final String movieAttachmentLabel;
  final String likeLabel;
  final String commentLabel;
  final String editLabel;
  final String deleteLabel;
  final VoidCallback onAuthorTap;
  final VoidCallback onReactionTap;
  final VoidCallback onCommentTap;
  final VoidCallback onEditTap;
  final VoidCallback onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        CommunityPostCard(
          post: post,
          movieAttachmentLabel: movieAttachmentLabel,
          likeLabel: likeLabel,
          commentLabel: commentLabel,
          editLabel: editLabel,
          deleteLabel: deleteLabel,
          onAuthorTap: onAuthorTap,
          onReactionTap: onReactionTap,
          onCommentTap: onCommentTap,
          onEditTap: onEditTap,
          onDeleteTap: onDeleteTap,
        ),
      ],
    );
  }
}
