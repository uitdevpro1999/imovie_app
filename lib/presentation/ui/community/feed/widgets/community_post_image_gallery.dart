import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/presentation/ui/community/feed/widgets/community_image_full_preview.dart';
import 'package:imovie_app/presentation/widgets/imovie_remote_image.dart';

class CommunityPostImageGallery extends StatelessWidget {
  const CommunityPostImageGallery({
    super.key,
    required this.imageUrls,
    required this.placeholderLabel,
  });

  final List<String> imageUrls;
  final String placeholderLabel;

  @override
  Widget build(BuildContext context) {
    final normalizedUrls = imageUrls
        .map((url) => url.trim())
        .where((url) => url.isNotEmpty)
        .take(5)
        .toList(growable: false);
    if (normalizedUrls.isEmpty) {
      return const SizedBox.shrink();
    }

    if (normalizedUrls.length == 1) {
      return AspectRatio(
        aspectRatio: 4 / 3,
        child: _GalleryImageTile(
          imageUrls: normalizedUrls,
          imageUrl: normalizedUrls.first,
          index: 0,
          placeholderLabel: placeholderLabel,
        ),
      );
    }

    return _GalleryGrid(
      imageUrls: normalizedUrls,
      placeholderLabel: placeholderLabel,
    );
  }
}

class _GalleryGrid extends StatelessWidget {
  const _GalleryGrid({required this.imageUrls, required this.placeholderLabel});

  final List<String> imageUrls;
  final String placeholderLabel;

  @override
  Widget build(BuildContext context) {
    if (imageUrls.length == 2) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Row(
          children: [
            Expanded(
              child: _GalleryImageTile(
                imageUrls: imageUrls,
                imageUrl: imageUrls[0],
                index: 0,
                placeholderLabel: placeholderLabel,
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: _GalleryImageTile(
                imageUrls: imageUrls,
                imageUrl: imageUrls[1],
                index: 1,
                placeholderLabel: placeholderLabel,
              ),
            ),
          ],
        ),
      );
    }

    if (imageUrls.length == 3) {
      return AspectRatio(
        aspectRatio: 16 / 10,
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: _GalleryImageTile(
                imageUrls: imageUrls,
                imageUrl: imageUrls[0],
                index: 0,
                placeholderLabel: placeholderLabel,
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Expanded(
                    child: _GalleryImageTile(
                      imageUrls: imageUrls,
                      imageUrl: imageUrls[1],
                      index: 1,
                      placeholderLabel: placeholderLabel,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    child: _GalleryImageTile(
                      imageUrls: imageUrls,
                      imageUrl: imageUrls[2],
                      index: 2,
                      placeholderLabel: placeholderLabel,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
      ),
      itemCount: imageUrls.length,
      itemBuilder: (context, index) {
        return _GalleryImageTile(
          imageUrls: imageUrls,
          imageUrl: imageUrls[index],
          index: index,
          placeholderLabel: placeholderLabel,
        );
      },
    );
  }
}

class _GalleryImageTile extends StatelessWidget {
  const _GalleryImageTile({
    required this.imageUrls,
    required this.imageUrl,
    required this.index,
    required this.placeholderLabel,
  });

  final List<String> imageUrls;
  final String imageUrl;
  final int index;
  final String placeholderLabel;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.grayscale800,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => CommunityImageFullPreview.show(
          context: context,
          images: imageUrls.map(CommunityPreviewImage.remote).toList(),
          initialIndex: index,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            IMovieRemoteImage(
              imageUrl: imageUrl,
              borderRadius: BorderRadius.circular(16),
              placeholderLabel: placeholderLabel,
            ),
          ],
        ),
      ),
    );
  }
}
