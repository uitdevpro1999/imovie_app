import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/presentation/ui/community/feed/widgets/community_image_full_preview.dart';
import 'package:imovie_app/presentation/widgets/imovie_remote_image.dart';

class CommunityImagePreview extends StatelessWidget {
  const CommunityImagePreview({
    super.key,
    required this.selectedImages,
    required this.existingImageUrls,
    required this.onPickTap,
    required this.onRemoveSelectedImageTap,
    required this.onRemoveExistingImageTap,
    required this.pickLabel,
    required this.removeLabel,
    this.maxImages = 5,
  });

  final List<XFile> selectedImages;
  final List<String> existingImageUrls;
  final VoidCallback onPickTap;
  final ValueChanged<XFile> onRemoveSelectedImageTap;
  final ValueChanged<String> onRemoveExistingImageTap;
  final String pickLabel;
  final String removeLabel;
  final int maxImages;

  @override
  Widget build(BuildContext context) {
    final images = _previewImages;
    if (images.isEmpty) {
      return _ImagePickerPlaceholder(label: pickLabel, onTap: onPickTap);
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.grayscale900,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.grayscale800),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.16),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          _ImagePreviewGrid(
            images: images,
            removeLabel: removeLabel,
            onRemoveSelectedImageTap: onRemoveSelectedImageTap,
            onRemoveExistingImageTap: onRemoveExistingImageTap,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _PreviewActionButton(
                  icon: FluentIcons.image_add_24_regular,
                  label: '$pickLabel (${images.length}/$maxImages)',
                  onTap: images.length >= maxImages ? null : onPickTap,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<_PreviewImageItem> get _previewImages {
    return [
      ...existingImageUrls
          .map((url) => url.trim())
          .where((url) => url.isNotEmpty)
          .map(_PreviewImageItem.remote),
      ...selectedImages.map(_PreviewImageItem.local),
    ].take(maxImages).toList(growable: false);
  }
}

class _ImagePreviewGrid extends StatelessWidget {
  const _ImagePreviewGrid({
    required this.images,
    required this.removeLabel,
    required this.onRemoveSelectedImageTap,
    required this.onRemoveExistingImageTap,
  });

  final List<_PreviewImageItem> images;
  final String removeLabel;
  final ValueChanged<XFile> onRemoveSelectedImageTap;
  final ValueChanged<String> onRemoveExistingImageTap;

  @override
  Widget build(BuildContext context) {
    if (images.length == 1) {
      return AspectRatio(
        aspectRatio: 16 / 10,
        child: _ImagePreviewTile(
          image: images.first,
          images: images,
          index: 0,
          removeLabel: removeLabel,
          onRemoveSelectedImageTap: onRemoveSelectedImageTap,
          onRemoveExistingImageTap: onRemoveExistingImageTap,
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return _ImagePreviewTile(
          image: images[index],
          images: images,
          index: index,
          removeLabel: removeLabel,
          onRemoveSelectedImageTap: onRemoveSelectedImageTap,
          onRemoveExistingImageTap: onRemoveExistingImageTap,
        );
      },
    );
  }
}

class _ImagePreviewTile extends StatelessWidget {
  const _ImagePreviewTile({
    required this.image,
    required this.images,
    required this.index,
    required this.removeLabel,
    required this.onRemoveSelectedImageTap,
    required this.onRemoveExistingImageTap,
  });

  final _PreviewImageItem image;
  final List<_PreviewImageItem> images;
  final int index;
  final String removeLabel;
  final ValueChanged<XFile> onRemoveSelectedImageTap;
  final ValueChanged<String> onRemoveExistingImageTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.grayscale800,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => CommunityImageFullPreview.show(
          context: context,
          images: images.map((image) => image.toPreviewImage()).toList(),
          initialIndex: index,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            image.when(
              local: (file) => _LocalPreviewImage(image: file),
              remote: (url) =>
                  IMovieRemoteImage(imageUrl: url, placeholderLabel: url),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: _RemovePreviewButton(
                tooltip: removeLabel,
                onTap: () => image.when(
                  local: onRemoveSelectedImageTap,
                  remote: onRemoveExistingImageTap,
                ),
              ),
            ),
          ],
        ),
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
          return const Center(
            child: CupertinoActivityIndicator(color: AppColors.yellow500),
          );
        }

        return Image.memory(bytes, fit: BoxFit.cover);
      },
    );
  }
}

class _ImagePickerPlaceholder extends StatelessWidget {
  const _ImagePickerPlaceholder({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          height: 112,
          decoration: BoxDecoration(
            color: AppColors.grayscale900,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.grayscale800),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: AppColors.yellow950,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.yellow900),
                ),
                child: const Icon(
                  FluentIcons.image_add_24_regular,
                  color: AppColors.yellow500,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.body2Medium.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Icon(
                FluentIcons.chevron_right_24_regular,
                color: AppColors.grayscale400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PreviewActionButton extends StatelessWidget {
  const _PreviewActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: onTap == null ? 0.5 : 1,
      child: Material(
        color: AppColors.black.withValues(alpha: 0.58),
        borderRadius: BorderRadius.circular(999),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(999),
          child: SizedBox(
            height: 42,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 18, color: AppColors.white),
                  const SizedBox(width: 8),
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
            ),
          ),
        ),
      ),
    );
  }
}

class _RemovePreviewButton extends StatelessWidget {
  const _RemovePreviewButton({required this.tooltip, required this.onTap});

  final String tooltip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: AppColors.black.withValues(alpha: 0.62),
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: const SizedBox.square(
            dimension: 34,
            child: Icon(
              FluentIcons.dismiss_24_regular,
              color: AppColors.white,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}

class _PreviewImageItem {
  const _PreviewImageItem.local(this.localImage) : remoteUrl = '';

  const _PreviewImageItem.remote(this.remoteUrl) : localImage = null;

  final XFile? localImage;
  final String remoteUrl;

  T when<T>({
    required T Function(XFile image) local,
    required T Function(String url) remote,
  }) {
    final image = localImage;
    if (image != null) {
      return local(image);
    }

    return remote(remoteUrl);
  }

  CommunityPreviewImage toPreviewImage() {
    final image = localImage;
    if (image != null) {
      return CommunityPreviewImage.local(image);
    }

    return CommunityPreviewImage.remote(remoteUrl);
  }
}
