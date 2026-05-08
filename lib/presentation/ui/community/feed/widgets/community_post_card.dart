import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/services/location_service.dart';
import 'package:imovie_app/domain/entities/community/community_post.dart';
import 'package:imovie_app/presentation/ui/community/feed/widgets/community_post_image_gallery.dart';
import 'package:imovie_app/presentation/widgets/imovie_remote_image.dart';

enum CommunityPostMenuAction { edit, delete }

class CommunityPostCard extends StatelessWidget {
  const CommunityPostCard({
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
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grayscale900,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.grayscale800),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.18),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CommunityPostHeader(
              post: post,
              editLabel: editLabel,
              deleteLabel: deleteLabel,
              onAuthorTap: onAuthorTap,
              onEditTap: onEditTap,
              onDeleteTap: onDeleteTap,
            ),
            if (post.content.trim().isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                post.content,
                style: AppTypography.body1Regular.copyWith(
                  color: AppColors.grayscale100,
                  height: 1.45,
                ),
              ),
            ],
            if (post.imageUrls.isNotEmpty) ...[
              const SizedBox(height: 14),
              CommunityPostImageGallery(
                imageUrls: post.imageUrls,
                placeholderLabel: post.content,
              ),
            ],
            if (post.movieTitle.trim().isNotEmpty) ...[
              const SizedBox(height: 14),
              _CommunityMovieAttachment(
                label: movieAttachmentLabel,
                title: post.movieTitle.trim(),
                posterUrl: post.moviePosterUrl,
              ),
            ],
            if (post.locationName.trim().isNotEmpty) ...[
              const SizedBox(height: 10),
              _CommunityMetaChip(
                icon: FluentIcons.location_24_regular,
                label: LocationAddress.shortestLabel(post.locationName),
                tooltip: post.locationName,
              ),
            ],
            const SizedBox(height: 14),
            _CommunityEngagementSummary(post: post, commentLabel: commentLabel),
            const SizedBox(height: 12),
            const Divider(height: 1, color: AppColors.grayscale800),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _CommunityActionButton(
                    icon: post.isReactedByMe
                        ? FluentIcons.heart_24_filled
                        : FluentIcons.heart_24_regular,
                    label: likeLabel,
                    color: post.isReactedByMe
                        ? AppColors.red400
                        : AppColors.grayscale300,
                    isActive: post.isReactedByMe,
                    onTap: onReactionTap,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _CommunityActionButton(
                    icon: FluentIcons.comment_24_regular,
                    label: commentLabel,
                    color: AppColors.grayscale300,
                    onTap: onCommentTap,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CommunityPostHeader extends StatelessWidget {
  const _CommunityPostHeader({
    required this.post,
    required this.editLabel,
    required this.deleteLabel,
    required this.onAuthorTap,
    required this.onEditTap,
    required this.onDeleteTap,
  });

  final CommunityPost post;
  final String editLabel;
  final String deleteLabel;
  final VoidCallback onAuthorTap;
  final VoidCallback onEditTap;
  final VoidCallback onDeleteTap;

  @override
  Widget build(BuildContext context) {
    final initials = post.authorName.trim().isEmpty
        ? 'U'
        : post.authorName.trim().characters.first.toUpperCase();

    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: onAuthorTap,
            borderRadius: BorderRadius.circular(14),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: post.isOwner
                          ? AppColors.yellow500
                          : AppColors.grayscale700,
                    ),
                  ),
                  child: ClipOval(
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: AppColors.grayscale800,
                      ),
                      child: post.authorAvatarUrl.trim().isEmpty
                          ? Center(
                              child: Text(
                                initials,
                                style: AppTypography.h4.copyWith(
                                  color: AppColors.yellow500,
                                ),
                              ),
                            )
                          : IMovieRemoteImage(
                              imageUrl: post.authorAvatarUrl,
                              placeholderLabel: initials,
                            ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.authorName.trim().isEmpty
                            ? 'iMovie user'
                            : post.authorName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.body2Medium.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            FluentIcons.globe_24_regular,
                            size: 13,
                            color: AppColors.grayscale500,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              _timeLabel(post.createdAt),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.captionRegular1.copyWith(
                                color: AppColors.grayscale400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (post.isOwner)
          PopupMenuButton<CommunityPostMenuAction>(
            color: AppColors.grayscale900,
            iconColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: const BorderSide(color: AppColors.grayscale800),
            ),
            icon: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: AppColors.grayscale800,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                FluentIcons.more_horizontal_24_regular,
                size: 20,
              ),
            ),
            onSelected: (action) {
              switch (action) {
                case CommunityPostMenuAction.edit:
                  onEditTap();
                case CommunityPostMenuAction.delete:
                  onDeleteTap();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: CommunityPostMenuAction.edit,
                child: Text(
                  editLabel,
                  style: AppTypography.body2Regular.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
              PopupMenuItem(
                value: CommunityPostMenuAction.delete,
                child: Text(
                  deleteLabel,
                  style: AppTypography.body2Regular.copyWith(
                    color: AppColors.red400,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  String _timeLabel(DateTime? createdAt) {
    if (createdAt == null) {
      return '';
    }

    final now = DateTime.now();
    final diff = now.difference(createdAt.toLocal());
    if (diff.inMinutes < 1) {
      return 'Now';
    }
    if (diff.inHours < 1) {
      return '${diff.inMinutes}m';
    }
    if (diff.inDays < 1) {
      return '${diff.inHours}h';
    }
    return '${diff.inDays}d';
  }
}

class _CommunityEngagementSummary extends StatelessWidget {
  const _CommunityEngagementSummary({
    required this.post,
    required this.commentLabel,
  });

  final CommunityPost post;
  final String commentLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 28,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: post.isReactedByMe
                ? AppColors.red950
                : AppColors.grayscale800,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            children: [
              Icon(
                FluentIcons.heart_24_filled,
                size: 16,
                color: post.isReactedByMe
                    ? AppColors.red400
                    : AppColors.grayscale400,
              ),
              const SizedBox(width: 6),
              Text(
                '${post.reactionCount}',
                style: AppTypography.captionMedium.copyWith(
                  color: AppColors.grayscale200,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Text(
          '${post.commentCount} $commentLabel',
          style: AppTypography.captionRegular1.copyWith(
            color: AppColors.grayscale300,
          ),
        ),
      ],
    );
  }
}

class _CommunityMovieAttachment extends StatelessWidget {
  const _CommunityMovieAttachment({
    required this.label,
    required this.title,
    required this.posterUrl,
  });

  final String label;
  final String title;
  final String posterUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.grayscale800,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grayscale700),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 54,
            height: 78,
            child: IMovieRemoteImage(
              imageUrl: posterUrl,
              borderRadius: BorderRadius.circular(12),
              placeholderLabel: title,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      FluentIcons.movies_and_tv_24_regular,
                      size: 16,
                      color: AppColors.yellow500,
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.captionMedium.copyWith(
                          color: AppColors.yellow500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.body2Medium.copyWith(
                    color: AppColors.white,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CommunityMetaChip extends StatelessWidget {
  const _CommunityMetaChip({
    required this.icon,
    required this.label,
    this.tooltip = '',
  });

  final IconData icon;
  final String label;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    final chip = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.grayscale800,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.yellow500),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.captionMedium.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );

    final normalizedTooltip = tooltip.trim();
    if (normalizedTooltip.isEmpty || normalizedTooltip == label.trim()) {
      return chip;
    }

    return Tooltip(
      message: normalizedTooltip,
      triggerMode: TooltipTriggerMode.tap,
      child: chip,
    );
  }
}

class _CommunityActionButton extends StatelessWidget {
  const _CommunityActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    this.isActive = false,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isActive ? AppColors.red950 : AppColors.grayscale800,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 42,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: color),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.captionMedium.copyWith(color: color),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
