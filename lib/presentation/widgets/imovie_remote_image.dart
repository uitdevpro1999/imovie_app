import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';

const _isFlutterTest = bool.fromEnvironment('FLUTTER_TEST');

class IMovieRemoteImage extends StatelessWidget {
  const IMovieRemoteImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.width,
    this.height,
    this.placeholderLabel,
  });

  final String imageUrl;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  final String? placeholderLabel;

  @override
  Widget build(BuildContext context) {
    final normalizedUrl = imageUrl.trim();
    final placeholder = _RemoteImagePlaceholder(label: placeholderLabel);
    final image = _isFlutterTest || normalizedUrl.isEmpty
        ? placeholder
        : CachedNetworkImage(
            imageUrl: normalizedUrl,
            fit: fit,
            width: width,
            height: height,
            fadeInDuration: Duration.zero,
            fadeOutDuration: Duration.zero,
            placeholder: (context, url) => placeholder,
            errorWidget: (context, url, error) => placeholder,
          );

    if (borderRadius == null) {
      return image;
    }

    return ClipRRect(borderRadius: borderRadius!, child: image);
  }
}

class _RemoteImagePlaceholder extends StatelessWidget {
  const _RemoteImagePlaceholder({this.label});

  final String? label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.grayscale300, AppColors.grayscale700],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            label ?? 'Image',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),
        ),
      ),
    );
  }
}
