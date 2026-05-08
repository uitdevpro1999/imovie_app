import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/presentation/widgets/imovie_remote_image.dart';

class CommunityPreviewImage {
  const CommunityPreviewImage.remote(this.url) : image = null;

  const CommunityPreviewImage.local(this.image) : url = '';

  final String url;
  final XFile? image;

  String get label {
    final localImage = image;
    if (localImage != null) {
      return localImage.name;
    }

    return url;
  }
}

class CommunityImageFullPreview extends StatefulWidget {
  const CommunityImageFullPreview({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  final List<CommunityPreviewImage> images;
  final int initialIndex;

  static Future<void> show({
    required BuildContext context,
    required List<CommunityPreviewImage> images,
    int initialIndex = 0,
  }) {
    final normalizedImages = images
        .where((image) => image.image != null || image.url.trim().isNotEmpty)
        .toList(growable: false);
    if (normalizedImages.isEmpty) {
      return Future.value();
    }

    return showDialog<void>(
      context: context,
      barrierColor: AppColors.black,
      builder: (_) => CommunityImageFullPreview(
        images: normalizedImages,
        initialIndex: initialIndex.clamp(0, normalizedImages.length - 1),
      ),
    );
  }

  @override
  State<CommunityImageFullPreview> createState() =>
      _CommunityImageFullPreviewState();
}

class _CommunityImageFullPreviewState extends State<CommunityImageFullPreview> {
  late final PageController _controller;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _controller = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: AppColors.black,
      child: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                return _PreviewImageView(image: widget.images[index]);
              },
            ),
            Positioned(
              top: 12,
              left: 12,
              child: _PreviewCloseButton(onTap: () => Navigator.pop(context)),
            ),
            Positioned(
              top: 18,
              left: 72,
              right: 72,
              child: Text(
                '${_currentIndex + 1}/${widget.images.length}',
                textAlign: TextAlign.center,
                style: AppTypography.body2Medium.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PreviewImageView extends StatelessWidget {
  const _PreviewImageView({required this.image});

  final CommunityPreviewImage image;

  @override
  Widget build(BuildContext context) {
    final localImage = image.image;
    return InteractiveViewer(
      minScale: 1,
      maxScale: 4,
      child: Center(
        child: localImage == null
            ? IMovieRemoteImage(
                imageUrl: image.url,
                fit: BoxFit.contain,
                placeholderLabel: image.label,
              )
            : _LocalPreviewImage(image: localImage),
      ),
    );
  }
}

class _LocalPreviewImage extends StatelessWidget {
  const _LocalPreviewImage({required this.image});

  final XFile image;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: image.readAsBytes(),
      builder: (context, snapshot) {
        final bytes = snapshot.data;
        if (bytes == null) {
          return const CupertinoActivityIndicator(color: AppColors.yellow500);
        }

        return Image.memory(bytes, fit: BoxFit.contain);
      },
    );
  }
}

class _PreviewCloseButton extends StatelessWidget {
  const _PreviewCloseButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.black.withValues(alpha: 0.68),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: const SizedBox.square(
          dimension: 44,
          child: Icon(FluentIcons.dismiss_24_regular, color: AppColors.white),
        ),
      ),
    );
  }
}
