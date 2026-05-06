import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/presentation/widgets/imovie_remote_image.dart';

class CommunityStoryImageCanvas extends StatelessWidget {
  const CommunityStoryImageCanvas({
    super.key,
    required this.selectedImage,
    required this.storyText,
    required this.textPosition,
    required this.movieTitle,
    required this.moviePosterUrl,
    required this.moviePosition,
    required this.locationName,
    required this.locationPosition,
    required this.pickLabel,
    required this.changeLabel,
    required this.onPickTap,
    required this.onRemoveTap,
    required this.onTextPositionChanged,
    required this.onMoviePositionChanged,
    required this.onLocationPositionChanged,
  });

  final XFile? selectedImage;
  final String storyText;
  final Offset textPosition;
  final String movieTitle;
  final String moviePosterUrl;
  final Offset moviePosition;
  final String locationName;
  final Offset locationPosition;
  final String pickLabel;
  final String changeLabel;
  final VoidCallback onPickTap;
  final VoidCallback onRemoveTap;
  final ValueChanged<Offset> onTextPositionChanged;
  final ValueChanged<Offset> onMoviePositionChanged;
  final ValueChanged<Offset> onLocationPositionChanged;

  @override
  Widget build(BuildContext context) {
    final image = selectedImage;
    return AspectRatio(
      aspectRatio: 9 / 16,
      child: Material(
        color: AppColors.grayscale900,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          onTap: image == null ? onPickTap : null,
          borderRadius: BorderRadius.circular(24),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.grayscale800),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final canvasSize = Size(
                    constraints.maxWidth,
                    constraints.maxHeight,
                  );
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      if (image == null)
                        _StoryImagePlaceholder(label: pickLabel)
                      else
                        _LocalStoryImage(image: image),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.black.withValues(alpha: 0.08),
                              AppColors.black.withValues(alpha: 0.18),
                              AppColors.black.withValues(alpha: 0.72),
                            ],
                          ),
                        ),
                      ),
                      if (storyText.trim().isNotEmpty)
                        _DraggableStoryOverlay(
                          canvasSize: canvasSize,
                          position: textPosition,
                          onPositionChanged: onTextPositionChanged,
                          child: _StoryTextOverlay(text: storyText.trim()),
                        ),
                      if (movieTitle.trim().isNotEmpty)
                        _DraggableStoryOverlay(
                          canvasSize: canvasSize,
                          position: moviePosition,
                          onPositionChanged: onMoviePositionChanged,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: canvasSize.width - 28,
                            ),
                            child: _StoryMovieChip(
                              title: movieTitle,
                              posterUrl: moviePosterUrl,
                            ),
                          ),
                        ),
                      if (locationName.trim().isNotEmpty)
                        _DraggableStoryOverlay(
                          canvasSize: canvasSize,
                          position: locationPosition,
                          onPositionChanged: onLocationPositionChanged,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: canvasSize.width - 28,
                            ),
                            child: _StoryMetaChip(
                              icon: Icons.place_outlined,
                              label: locationName,
                            ),
                          ),
                        ),
                      if (image != null)
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Row(
                            children: [
                              _CanvasActionButton(
                                icon: Icons.image_search_rounded,
                                tooltip: changeLabel,
                                onTap: onPickTap,
                              ),
                              const SizedBox(width: 8),
                              _CanvasActionButton(
                                icon: Icons.close_rounded,
                                tooltip: changeLabel,
                                onTap: onRemoveTap,
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DraggableStoryOverlay extends StatelessWidget {
  const _DraggableStoryOverlay({
    required this.canvasSize,
    required this.position,
    required this.onPositionChanged,
    required this.child,
  });

  final Size canvasSize;
  final Offset position;
  final ValueChanged<Offset> onPositionChanged;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx * canvasSize.width,
      top: position.dy * canvasSize.height,
      child: FractionalTranslation(
        translation: const Offset(-0.5, -0.5),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanUpdate: (details) {
            onPositionChanged(
              Offset(
                (position.dx + details.delta.dx / canvasSize.width)
                    .clamp(0.06, 0.94)
                    .toDouble(),
                (position.dy + details.delta.dy / canvasSize.height)
                    .clamp(0.06, 0.94)
                    .toDouble(),
              ),
            );
          },
          child: child,
        ),
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
        color: AppColors.black.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
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

class _LocalStoryImage extends StatefulWidget {
  const _LocalStoryImage({required this.image});

  final XFile image;

  @override
  State<_LocalStoryImage> createState() => _LocalStoryImageState();
}

class _LocalStoryImageState extends State<_LocalStoryImage> {
  late Future<Uint8List> _bytesFuture;

  @override
  void initState() {
    super.initState();
    _bytesFuture = widget.image.readAsBytes();
  }

  @override
  void didUpdateWidget(covariant _LocalStoryImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.image.path != widget.image.path) {
      _bytesFuture = widget.image.readAsBytes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: _bytesFuture,
      builder: (context, snapshot) {
        final bytes = snapshot.data;
        if (bytes == null || bytes.isEmpty) {
          return const ColoredBox(color: AppColors.grayscale800);
        }

        return Image.memory(bytes, fit: BoxFit.cover);
      },
    );
  }
}

class _StoryImagePlaceholder extends StatelessWidget {
  const _StoryImagePlaceholder({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: AppColors.grayscale800),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.yellow500,
                child: Icon(
                  Icons.add_photo_alternate_rounded,
                  color: AppColors.grayscale950,
                  size: 30,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                label,
                textAlign: TextAlign.center,
                style: AppTypography.body2Medium.copyWith(
                  color: AppColors.white,
                ),
              ),
            ],
          ),
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
        color: AppColors.black.withValues(alpha: 0.58),
        borderRadius: BorderRadius.circular(14),
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
              Icons.movie_filter_rounded,
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

class _StoryMetaChip extends StatelessWidget {
  const _StoryMetaChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
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

class _CanvasActionButton extends StatelessWidget {
  const _CanvasActionButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: AppColors.black.withValues(alpha: 0.64),
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: SizedBox.square(
            dimension: 38,
            child: Icon(icon, color: AppColors.white, size: 20),
          ),
        ),
      ),
    );
  }
}
