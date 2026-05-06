import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/domain/entities/community/community_story.dart';
import 'package:imovie_app/presentation/widgets/imovie_remote_image.dart';

class CommunityStorySection extends StatelessWidget {
  const CommunityStorySection({
    super.key,
    required this.stories,
    required this.title,
    required this.createLabel,
    required this.deleteLabel,
    required this.onCreateTap,
    required this.onDeleteTap,
  });

  final List<CommunityStory> stories;
  final String title;
  final String createLabel;
  final String deleteLabel;
  final VoidCallback onCreateTap;
  final ValueChanged<CommunityStory> onDeleteTap;

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
          child: Text(
            title,
            style: AppTypography.button1Semibold.copyWith(
              color: AppColors.white,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 176,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: storyGroups.length + 1,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              if (index == 0) {
                return _CreateStoryCard(label: createLabel, onTap: onCreateTap);
              }

              final group = storyGroups[index - 1];
              return _StoryCard(
                group: group,
                onTap: () => _openStoryViewer(
                  context: context,
                  stories: group.stories,
                  initialIndex: 0,
                  deleteLabel: deleteLabel,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _openStoryViewer({
    required BuildContext context,
    required List<CommunityStory> stories,
    required int initialIndex,
    required String deleteLabel,
  }) {
    showDialog<void>(
      context: context,
      barrierColor: AppColors.black88,
      builder: (dialogContext) {
        return _StoryViewerDialog(
          stories: stories,
          initialIndex: initialIndex,
          deleteLabel: deleteLabel,
          onDeleteTap: onDeleteTap,
        );
      },
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
      color: AppColors.grayscale900,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          width: 112,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: AppColors.grayscale800),
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.grayscale800,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(22),
                    ),
                  ),
                  child: const Center(
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: AppColors.yellow500,
                      child: Icon(
                        Icons.add_rounded,
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
      color: AppColors.grayscale900,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          width: 112,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: AppColors.grayscale800),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              IMovieRemoteImage(
                imageUrl: story.imageUrl,
                borderRadius: BorderRadius.circular(22),
                placeholderLabel: authorName,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
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

class _StoryViewerDialog extends StatefulWidget {
  const _StoryViewerDialog({
    required this.stories,
    required this.initialIndex,
    required this.deleteLabel,
    required this.onDeleteTap,
  });

  final List<CommunityStory> stories;
  final int initialIndex;
  final String deleteLabel;
  final ValueChanged<CommunityStory> onDeleteTap;

  @override
  State<_StoryViewerDialog> createState() => _StoryViewerDialogState();
}

class _StoryViewerDialogState extends State<_StoryViewerDialog>
    with SingleTickerProviderStateMixin {
  static const _storyDuration = Duration(seconds: 10);

  late final AnimationController _timelineController;
  late int _currentIndex;

  CommunityStory get _story => widget.stories[_currentIndex];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.stories.isEmpty
        ? 0
        : widget.initialIndex.clamp(0, widget.stories.length - 1).toInt();
    _timelineController = AnimationController(
      vsync: this,
      duration: _storyDuration,
    )..addStatusListener(_handleTimelineStatus);
    _restartTimeline();
  }

  @override
  void dispose() {
    _timelineController
      ..removeStatusListener(_handleTimelineStatus)
      ..dispose();
    super.dispose();
  }

  void _handleTimelineStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _showNextStory();
    }
  }

  void _restartTimeline() {
    _timelineController
      ..stop()
      ..reset()
      ..forward();
  }

  void _showPreviousStory() {
    if (_currentIndex == 0) {
      _restartTimeline();
      return;
    }

    setState(() => _currentIndex -= 1);
    _restartTimeline();
  }

  void _showNextStory() {
    if (_currentIndex >= widget.stories.length - 1) {
      if (mounted) {
        Navigator.of(context).maybePop();
      }
      return;
    }

    setState(() => _currentIndex += 1);
    _restartTimeline();
  }

  void _deleteCurrentStory() {
    final story = _story;
    Navigator.of(context).pop();
    widget.onDeleteTap(story);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.stories.isEmpty) {
      return const SizedBox.shrink();
    }

    final story = _story;
    final authorName = story.authorName.trim().isEmpty
        ? 'iMovie user'
        : story.authorName.trim();

    return Dialog.fullscreen(
      backgroundColor: AppColors.black,
      child: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              child: Center(
                key: ValueKey(story.id),
                child: AspectRatio(
                  aspectRatio: 9 / 16,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        IMovieRemoteImage(
                          imageUrl: story.imageUrl,
                          placeholderLabel: authorName,
                        ),
                        _StoryViewerMeta(story: story),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: _showPreviousStory,
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: _showNextStory,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 16,
              left: 14,
              right: 14,
              child: Column(
                children: [
                  _StoryTimeline(
                    count: widget.stories.length,
                    currentIndex: _currentIndex,
                    progress: _timelineController,
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      _StoryAvatar(story: story, size: 42),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              authorName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.button2Semibold.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              _timeLeftLabel(story.expiresAt),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.captionRegular1.copyWith(
                                color: AppColors.grayscale300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (story.isOwner)
                        IconButton(
                          tooltip: widget.deleteLabel,
                          onPressed: _deleteCurrentStory,
                          icon: const Icon(
                            Icons.delete_outline_rounded,
                            color: AppColors.red400,
                          ),
                        ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.close_rounded,
                          color: AppColors.white,
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
    );
  }

  String _timeLeftLabel(DateTime? expiresAt) {
    if (expiresAt == null) {
      return '24h';
    }

    final diff = expiresAt.toLocal().difference(DateTime.now());
    if (diff.inMinutes <= 0) {
      return '0m';
    }
    if (diff.inHours < 1) {
      return '${diff.inMinutes}m';
    }

    return '${diff.inHours}h';
  }
}

class _StoryViewerMeta extends StatelessWidget {
  const _StoryViewerMeta({required this.story});

  final CommunityStory story;

  @override
  Widget build(BuildContext context) {
    final hasCaption = story.caption.trim().isNotEmpty;
    final hasMovie = story.movieTitle.trim().isNotEmpty;
    final hasLocation = story.locationName.trim().isNotEmpty;
    if (!hasCaption && !hasMovie && !hasLocation) {
      return const SizedBox.shrink();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final canvasSize = Size(constraints.maxWidth, constraints.maxHeight);
        return Stack(
          fit: StackFit.expand,
          children: [
            if (hasCaption)
              _ViewerPositionedOverlay(
                canvasSize: canvasSize,
                position: Offset(story.textPositionX, story.textPositionY),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: canvasSize.width * 0.72,
                  ),
                  child: Text(
                    story.caption.trim(),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: AppTypography.h2.copyWith(
                      color: AppColors.white,
                      shadows: [
                        Shadow(
                          color: AppColors.black.withValues(alpha: 0.58),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            if (hasMovie)
              _ViewerPositionedOverlay(
                canvasSize: canvasSize,
                position: Offset(story.moviePositionX, story.moviePositionY),
                child: _StoryViewerChip(
                  icon: Icons.movie_filter_rounded,
                  label: story.movieTitle,
                  maxWidth: canvasSize.width - 28,
                ),
              ),
            if (hasLocation)
              _ViewerPositionedOverlay(
                canvasSize: canvasSize,
                position: Offset(
                  story.locationPositionX,
                  story.locationPositionY,
                ),
                child: _StoryViewerChip(
                  icon: Icons.place_outlined,
                  label: story.locationName,
                  maxWidth: canvasSize.width - 28,
                ),
              ),
          ],
        );
      },
    );
  }
}

class _ViewerPositionedOverlay extends StatelessWidget {
  const _ViewerPositionedOverlay({
    required this.canvasSize,
    required this.position,
    required this.child,
  });

  final Size canvasSize;
  final Offset position;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx.clamp(0.0, 1.0) * canvasSize.width,
      top: position.dy.clamp(0.0, 1.0) * canvasSize.height,
      child: FractionalTranslation(
        translation: const Offset(-0.5, -0.5),
        child: child,
      ),
    );
  }
}

class _StoryViewerChip extends StatelessWidget {
  const _StoryViewerChip({
    required this.icon,
    required this.label,
    required this.maxWidth,
  });

  final IconData icon;
  final String label;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: 0.58),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.yellow500, size: 16),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.captionMedium.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StoryTimeline extends StatelessWidget {
  const _StoryTimeline({
    required this.count,
    required this.currentIndex,
    required this.progress,
  });

  final int count;
  final int currentIndex;
  final Animation<double> progress;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, _) {
        return Row(
          children: List.generate(count, (index) {
            final value = index < currentIndex
                ? 1.0
                : index == currentIndex
                ? progress.value
                : 0.0;

            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: index == count - 1 ? 0 : 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    minHeight: 3,
                    value: value,
                    backgroundColor: AppColors.grayscale700,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.white,
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

class _StoryAvatar extends StatelessWidget {
  const _StoryAvatar({required this.story, required this.size});

  final CommunityStory story;
  final double size;

  @override
  Widget build(BuildContext context) {
    final authorName = story.authorName.trim();
    final initials = authorName.isEmpty
        ? 'U'
        : authorName.characters.first.toUpperCase();

    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.yellow500, width: 2),
      ),
      child: ClipOval(
        child: DecoratedBox(
          decoration: const BoxDecoration(color: AppColors.grayscale800),
          child: story.authorAvatarUrl.trim().isEmpty
              ? Center(
                  child: Text(
                    initials,
                    style: AppTypography.captionMedium.copyWith(
                      color: AppColors.yellow500,
                    ),
                  ),
                )
              : IMovieRemoteImage(
                  imageUrl: story.authorAvatarUrl,
                  placeholderLabel: initials,
                ),
        ),
      ),
    );
  }
}
