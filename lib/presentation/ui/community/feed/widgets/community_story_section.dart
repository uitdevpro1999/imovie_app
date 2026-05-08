import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/domain/entities/community/community_story.dart';
import 'package:imovie_app/presentation/ui/community/feed/widgets/community_story_viewer_dialog.dart';
import 'package:imovie_app/presentation/widgets/imovie_remote_image.dart';

class CommunityStorySection extends StatelessWidget {
  const CommunityStorySection({
    super.key,
    required this.stories,
    required this.title,
    required this.createLabel,
    required this.deleteLabel,
    this.showCreateCard = true,
    required this.onCreateTap,
    required this.onDeleteTap,
    this.onAuthorTap,
  });

  final List<CommunityStory> stories;
  final String title;
  final String createLabel;
  final String deleteLabel;
  final bool showCreateCard;
  final VoidCallback onCreateTap;
  final ValueChanged<CommunityStory> onDeleteTap;
  final ValueChanged<String>? onAuthorTap;

  @override
  Widget build(BuildContext context) {
    final visibleStories = stories
        .where((story) => !story.isExpired)
        .toList(growable: false);
    final storyGroups = _groupStoriesByUser(visibleStories);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 18,
                decoration: BoxDecoration(
                  color: AppColors.yellow500,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: AppTypography.button1Semibold.copyWith(
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 188,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: storyGroups.length + (showCreateCard ? 1 : 0),
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              if (showCreateCard && index == 0) {
                return _CreateStoryCard(label: createLabel, onTap: onCreateTap);
              }

              final group = storyGroups[index - (showCreateCard ? 1 : 0)];
              return _StoryCard(
                group: group,
                onTap: () => showCommunityStoryViewerDialog(
                  context: context,
                  stories: group.stories,
                  initialIndex: 0,
                  deleteLabel: deleteLabel,
                  onDeleteTap: onDeleteTap,
                  onAuthorTap: onAuthorTap,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  List<_StoryGroup> _groupStoriesByUser(List<CommunityStory> stories) {
    final groupedStories = <String, List<CommunityStory>>{};
    for (final story in stories) {
      final userKey = story.userId.trim().isEmpty ? story.id : story.userId;
      groupedStories.putIfAbsent(userKey, () => <CommunityStory>[]).add(story);
    }

    return groupedStories.values
        .map((items) => _StoryGroup(stories: items))
        .toList(growable: false);
  }
}

class _StoryGroup {
  const _StoryGroup({required this.stories});

  final List<CommunityStory> stories;

  CommunityStory get coverStory => stories.first;

  int get count => stories.length;
}

class _CreateStoryCard extends StatelessWidget {
  const _CreateStoryCard({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Ink(
          width: 118,
          decoration: BoxDecoration(
            color: AppColors.grayscale900,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.grayscale800),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.16),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.grayscale800,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: const Center(
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: AppColors.yellow500,
                      child: Icon(
                        FluentIcons.add_24_regular,
                        color: AppColors.grayscale950,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
                child: Text(
                  label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppTypography.captionMedium.copyWith(
                    color: AppColors.white,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({required this.group, required this.onTap});

  final _StoryGroup group;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final story = group.coverStory;
    final authorName = story.authorName.trim().isEmpty
        ? 'iMovie user'
        : story.authorName.trim();

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Ink(
          width: 118,
          decoration: BoxDecoration(
            color: AppColors.grayscale900,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.grayscale800),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.18),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              IMovieRemoteImage(
                imageUrl: story.imageUrl,
                borderRadius: BorderRadius.circular(24),
                placeholderLabel: authorName,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.black.withValues(alpha: 0.1),
                      AppColors.black.withValues(alpha: 0.72),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: _StoryAvatar(story: story, size: 34),
              ),
              if (group.count > 1)
                Positioned(
                  top: 10,
                  right: 10,
                  child: _StoryCountBadge(count: group.count),
                ),
              Positioned(
                left: 10,
                right: 10,
                bottom: 10,
                child: Text(
                  authorName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.captionMedium.copyWith(
                    color: AppColors.white,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StoryCountBadge extends StatelessWidget {
  const _StoryCountBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      constraints: const BoxConstraints(minWidth: 24),
      padding: const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: 0.68),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.16)),
      ),
      alignment: Alignment.center,
      child: Text(
        count.toString(),
        style: AppTypography.captionMedium.copyWith(color: AppColors.white),
      ),
    );
  }
}

class _StoryAvatar extends StatelessWidget {
  const _StoryAvatar({required this.story, required this.size});

  final CommunityStory story;
  final double size;

  @override
  Widget build(BuildContext context) {
    final initials = story.authorName.trim().isEmpty
        ? 'U'
        : story.authorName.characters.first.toUpperCase();

    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.yellow500, width: 1.5),
      ),
      child: ClipOval(
        child: IMovieRemoteImage(
          imageUrl: story.authorAvatarUrl,
          placeholderLabel: initials,
        ),
      ),
    );
  }
}
