import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/services/location_service.dart';
import 'package:imovie_app/domain/entities/community/community_story.dart';
import 'package:imovie_app/presentation/widgets/imovie_remote_image.dart';

Future<void> showCommunityStoryViewerDialog({
  required BuildContext context,
  required List<CommunityStory> stories,
  required int initialIndex,
  required String deleteLabel,
  ValueChanged<CommunityStory>? onDeleteTap,
  ValueChanged<String>? onAuthorTap,
}) {
  return showDialog<void>(
    context: context,
    useSafeArea: false,
    barrierColor: AppColors.black88,
    builder: (dialogContext) {
      return CommunityStoryViewerDialog(
        stories: stories,
        initialIndex: initialIndex,
        deleteLabel: deleteLabel,
        onDeleteTap: onDeleteTap,
        onAuthorTap: onAuthorTap,
        fullscreenModal: true,
      );
    },
  );
}

class CommunityStoryViewerDialog extends StatefulWidget {
  const CommunityStoryViewerDialog({
    super.key,
    required this.stories,
    required this.initialIndex,
    required this.deleteLabel,
    this.onDeleteTap,
    this.onAuthorTap,
    this.fullscreenModal = true,
  });

  final List<CommunityStory> stories;
  final int initialIndex;
  final String deleteLabel;
  final ValueChanged<CommunityStory>? onDeleteTap;
  final ValueChanged<String>? onAuthorTap;
  final bool fullscreenModal;

  @override
  State<CommunityStoryViewerDialog> createState() =>
      _CommunityStoryViewerDialogState();
}

class _CommunityStoryViewerDialogState extends State<CommunityStoryViewerDialog>
    with SingleTickerProviderStateMixin {
  static const _storyDuration = Duration(seconds: 10);

  late final AnimationController _timelineController;
  late int _currentIndex;
  bool _pausedByHold = false;

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

  @override
  void didUpdateWidget(covariant CommunityStoryViewerDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.stories.isEmpty) {
      return;
    }

    final nextIndex = _currentIndex.clamp(0, widget.stories.length - 1).toInt();
    if (nextIndex != _currentIndex) {
      setState(() => _currentIndex = nextIndex);
      _restartTimeline();
    }
  }

  void _handleTimelineStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _showNextStory();
    }
  }

  void _restartTimeline() {
    _pausedByHold = false;
    _timelineController
      ..stop()
      ..reset()
      ..forward();
  }

  void _pauseTimeline() {
    if (_pausedByHold) {
      return;
    }
    _pausedByHold = true;
    _timelineController.stop();
  }

  void _resumeTimeline() {
    if (!_pausedByHold) {
      return;
    }
    _pausedByHold = false;
    if (_timelineController.value >= 1) {
      _showNextStory();
      return;
    }
    _timelineController.forward();
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
    if (widget.fullscreenModal) {
      Navigator.of(context).pop();
    }
    widget.onDeleteTap?.call(story);
  }

  String _postedTimeLabel(DateTime? createdAt) {
    if (createdAt == null) {
      return '';
    }

    final diff = DateTime.now().difference(createdAt.toLocal());
    if (diff.inMinutes < 1) {
      return 'Vừa xong';
    }
    if (diff.inHours < 1) {
      return '${diff.inMinutes}m';
    }
    if (diff.inDays < 1) {
      return '${diff.inHours}h';
    }

    return '${diff.inDays}d';
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

    final content = AnimatedSwitcher(
      duration: const Duration(milliseconds: 220),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      child: _StoryViewerContent(
        key: ValueKey(story.id),
        story: story,
        authorName: authorName,
        postedTimeLabel: _postedTimeLabel(story.createdAt),
        storyCount: widget.stories.length,
        currentIndex: _currentIndex,
        progress: _timelineController,
        onPreviousTap: _showPreviousStory,
        onNextTap: _showNextStory,
        onDeleteTap: _deleteCurrentStory,
        onCloseTap: () => Navigator.of(context).pop(),
        onHoldStart: _pauseTimeline,
        onHoldEnd: _resumeTimeline,
        onAuthorTap: widget.onAuthorTap == null
            ? null
            : (userId) {
                Navigator.of(context).pop();
                widget.onAuthorTap!(userId);
              },
      ),
    );

    if (!widget.fullscreenModal) {
      return content;
    }

    return Dialog.fullscreen(backgroundColor: AppColors.black, child: content);
  }
}

class _StoryViewerContent extends StatelessWidget {
  const _StoryViewerContent({
    super.key,
    required this.story,
    required this.authorName,
    required this.postedTimeLabel,
    required this.storyCount,
    required this.currentIndex,
    required this.progress,
    required this.onPreviousTap,
    required this.onNextTap,
    required this.onDeleteTap,
    required this.onCloseTap,
    required this.onHoldStart,
    required this.onHoldEnd,
    this.onAuthorTap,
  });

  final CommunityStory story;
  final String authorName;
  final String postedTimeLabel;
  final int storyCount;
  final int currentIndex;
  final Animation<double> progress;
  final VoidCallback onPreviousTap;
  final VoidCallback onNextTap;
  final VoidCallback? onDeleteTap;
  final VoidCallback onCloseTap;
  final VoidCallback onHoldStart;
  final VoidCallback onHoldEnd;
  final ValueChanged<String>? onAuthorTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _StoryViewerBackdrop(story: story, placeholderLabel: authorName),
        LayoutBuilder(
          builder: (context, constraints) {
            final fullBleed =
                constraints.maxWidth <= 520 &&
                constraints.maxHeight > constraints.maxWidth;

            if (fullBleed) {
              return _StoryViewerFrame(
                story: story,
                authorName: authorName,
                postedTimeLabel: postedTimeLabel,
                storyCount: storyCount,
                currentIndex: currentIndex,
                progress: progress,
                onPreviousTap: onPreviousTap,
                onNextTap: onNextTap,
                onDeleteTap: onDeleteTap,
                onCloseTap: onCloseTap,
                onHoldStart: onHoldStart,
                onHoldEnd: onHoldEnd,
                onAuthorTap: onAuthorTap,
                fullBleed: true,
              );
            }

            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 430,
                    maxHeight: constraints.maxHeight - 20,
                  ),
                  child: AspectRatio(
                    aspectRatio: 9 / 16,
                    child: _StoryViewerFrame(
                      story: story,
                      authorName: authorName,
                      postedTimeLabel: postedTimeLabel,
                      storyCount: storyCount,
                      currentIndex: currentIndex,
                      progress: progress,
                      onPreviousTap: onPreviousTap,
                      onNextTap: onNextTap,
                      onDeleteTap: onDeleteTap,
                      onCloseTap: onCloseTap,
                      onHoldStart: onHoldStart,
                      onHoldEnd: onHoldEnd,
                      onAuthorTap: onAuthorTap,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _StoryViewerBackdrop extends StatelessWidget {
  const _StoryViewerBackdrop({
    required this.story,
    required this.placeholderLabel,
  });

  final CommunityStory story;
  final String placeholderLabel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Transform.scale(
          scale: 1.08,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
            child: IMovieRemoteImage(
              imageUrl: story.imageUrl,
              placeholderLabel: placeholderLabel,
            ),
          ),
        ),
        ColoredBox(color: AppColors.black.withValues(alpha: 0.68)),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.black.withValues(alpha: 0.14),
                AppColors.black.withValues(alpha: 0.22),
                AppColors.black.withValues(alpha: 0.78),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StoryViewerFrame extends StatelessWidget {
  const _StoryViewerFrame({
    required this.story,
    required this.authorName,
    required this.postedTimeLabel,
    required this.storyCount,
    required this.currentIndex,
    required this.progress,
    required this.onPreviousTap,
    required this.onNextTap,
    required this.onDeleteTap,
    required this.onCloseTap,
    required this.onHoldStart,
    required this.onHoldEnd,
    this.onAuthorTap,
    this.fullBleed = false,
  });

  final CommunityStory story;
  final String authorName;
  final String postedTimeLabel;
  final int storyCount;
  final int currentIndex;
  final Animation<double> progress;
  final VoidCallback onPreviousTap;
  final VoidCallback onNextTap;
  final VoidCallback? onDeleteTap;
  final VoidCallback onCloseTap;
  final VoidCallback onHoldStart;
  final VoidCallback onHoldEnd;
  final ValueChanged<String>? onAuthorTap;
  final bool fullBleed;

  @override
  Widget build(BuildContext context) {
    final borderRadius = fullBleed
        ? BorderRadius.zero
        : BorderRadius.circular(28);
    final mediaPadding = MediaQuery.paddingOf(context);
    return ClipRRect(
      borderRadius: borderRadius,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onLongPressStart: (_) => onHoldStart(),
        onLongPressEnd: (_) => onHoldEnd(),
        onLongPressCancel: onHoldEnd,
        onVerticalDragEnd: (details) {
          final velocity = details.primaryVelocity ?? 0;
          if (velocity > 900) {
            onCloseTap();
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            IMovieRemoteImage(
              imageUrl: story.imageUrl,
              placeholderLabel: authorName,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.black.withValues(alpha: 0.34),
                    AppColors.black.withValues(alpha: 0.08),
                    AppColors.black.withValues(alpha: 0.62),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: onPreviousTap,
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: onNextTap,
                  ),
                ),
              ],
            ),
            _StoryOverlayLayer(story: story),
            Padding(
              padding: EdgeInsets.fromLTRB(
                14,
                (fullBleed ? mediaPadding.top : 0) + 12,
                14,
                (fullBleed ? mediaPadding.bottom : 0) + 18,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _StoryProgressBar(
                    storyCount: storyCount,
                    currentIndex: currentIndex,
                    progress: progress,
                  ),
                  const SizedBox(height: 12),
                  _StoryTopBar(
                    story: story,
                    authorName: authorName,
                    postedTimeLabel: postedTimeLabel,
                    onDeleteTap: onDeleteTap,
                    onCloseTap: onCloseTap,
                    onAuthorTap: onAuthorTap,
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StoryOverlayLayer extends StatelessWidget {
  const _StoryOverlayLayer({required this.story});

  final CommunityStory story;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        return Stack(
          fit: StackFit.expand,
          children: [
            if (story.caption.trim().isNotEmpty)
              _StoryPositionedOverlay(
                canvasSize: size,
                position: Offset(story.textPositionX, story.textPositionY),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: size.width - 28),
                  child: _StoryTextOverlay(text: story.caption.trim()),
                ),
              ),
            if (story.movieTitle.trim().isNotEmpty)
              _StoryPositionedOverlay(
                canvasSize: size,
                position: Offset(story.moviePositionX, story.moviePositionY),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: size.width - 28),
                  child: _StoryMovieChip(
                    title: story.movieTitle,
                    posterUrl: story.moviePosterUrl,
                  ),
                ),
              ),
            if (story.locationName.trim().isNotEmpty)
              _StoryPositionedOverlay(
                canvasSize: size,
                position: Offset(
                  story.locationPositionX,
                  story.locationPositionY,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: size.width - 28),
                  child: _StoryMetaPill(
                    icon: FluentIcons.location_24_regular,
                    label: LocationAddress.shortestLabel(story.locationName),
                    tooltip: story.locationName,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _StoryPositionedOverlay extends StatelessWidget {
  const _StoryPositionedOverlay({
    required this.canvasSize,
    required this.position,
    required this.child,
  });

  final Size canvasSize;
  final Offset position;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final clampedPosition = Offset(
      position.dx.clamp(0.06, 0.94).toDouble(),
      position.dy.clamp(0.06, 0.94).toDouble(),
    );

    return Positioned(
      left: clampedPosition.dx * canvasSize.width,
      top: clampedPosition.dy * canvasSize.height,
      child: FractionalTranslation(
        translation: const Offset(-0.5, -0.5),
        child: IgnorePointer(child: child),
      ),
    );
  }
}

class _StoryTextOverlay extends StatelessWidget {
  const _StoryTextOverlay({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width * 0.7,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.12)),
      ),
      child: Text(
        text,
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: AppTypography.h2.copyWith(
          color: AppColors.white,
          shadows: [
            Shadow(
              color: AppColors.black.withValues(alpha: 0.55),
              blurRadius: 12,
            ),
          ],
        ),
      ),
    );
  }
}

class _StoryMovieChip extends StatelessWidget {
  const _StoryMovieChip({required this.title, required this.posterUrl});

  final String title;
  final String posterUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: 0.62),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (posterUrl.trim().isNotEmpty)
            IMovieRemoteImage(
              imageUrl: posterUrl,
              width: 28,
              height: 40,
              borderRadius: BorderRadius.circular(7),
              placeholderLabel: title,
            )
          else
            const Icon(
              FluentIcons.movies_and_tv_24_regular,
              color: AppColors.yellow500,
              size: 18,
            ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              title,
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

class _StoryProgressBar extends StatelessWidget {
  const _StoryProgressBar({
    required this.storyCount,
    required this.currentIndex,
    required this.progress,
  });

  final int storyCount;
  final int currentIndex;
  final Animation<double> progress;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(storyCount, (index) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: index == storyCount - 1 ? 0 : 4),
            child: AnimatedBuilder(
              animation: progress,
              builder: (context, _) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: index < currentIndex
                        ? 1
                        : index == currentIndex
                        ? progress.value
                        : 0,
                    minHeight: 4,
                    backgroundColor: AppColors.white.withValues(alpha: 0.18),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.white,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}

class _StoryTopBar extends StatelessWidget {
  const _StoryTopBar({
    required this.story,
    required this.authorName,
    required this.postedTimeLabel,
    required this.onDeleteTap,
    required this.onCloseTap,
    this.onAuthorTap,
  });

  final CommunityStory story;
  final String authorName;
  final String postedTimeLabel;
  final VoidCallback? onDeleteTap;
  final VoidCallback onCloseTap;
  final ValueChanged<String>? onAuthorTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: InkWell(
            onTap: onAuthorTap == null
                ? null
                : () => onAuthorTap!(story.userId),
            borderRadius: BorderRadius.circular(18),
            child: Row(
              children: [
                _StoryAvatar(story: story, size: 38),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authorName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.button1Semibold.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      if (postedTimeLabel.trim().isNotEmpty)
                        Text(
                          postedTimeLabel,
                          style: AppTypography.captionRegular1.copyWith(
                            color: AppColors.grayscale200,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (story.isOwner && onDeleteTap != null) ...[
          _StoryTopActionButton(
            icon: FluentIcons.delete_24_regular,
            onTap: onDeleteTap!,
            iconColor: AppColors.red400,
          ),
          const SizedBox(width: 8),
        ],
        _StoryTopActionButton(
          icon: FluentIcons.dismiss_24_regular,
          onTap: onCloseTap,
        ),
      ],
    );
  }
}

class _StoryTopActionButton extends StatelessWidget {
  const _StoryTopActionButton({
    required this.icon,
    required this.onTap,
    this.iconColor = AppColors.white,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.black.withValues(alpha: 0.26),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 38,
          height: 38,
          child: Icon(icon, color: iconColor, size: 20),
        ),
      ),
    );
  }
}

class _StoryMetaPill extends StatelessWidget {
  const _StoryMetaPill({required this.icon, required this.label, this.tooltip});

  final IconData icon;
  final String label;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final child = DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: AppColors.yellow500),
            const SizedBox(width: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 210),
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.body2Medium.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    final fullLabel = tooltip?.trim() ?? '';
    if (fullLabel.isEmpty) {
      return child;
    }

    return Tooltip(message: fullLabel, child: child);
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
