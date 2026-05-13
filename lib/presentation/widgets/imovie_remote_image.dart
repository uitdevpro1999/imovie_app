import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';

const _isFlutterTest = bool.fromEnvironment('FLUTTER_TEST');
final Set<String> _paintedImageUrls = <String>{};

class IMovieRemoteImage extends StatefulWidget {
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
  State<IMovieRemoteImage> createState() => _IMovieRemoteImageState();
}

class _IMovieRemoteImageState extends State<IMovieRemoteImage> {
  late String _normalizedUrl;
  late bool _hasPaintedBefore;

  @override
  void initState() {
    super.initState();
    _syncUrlState();
  }

  @override
  void didUpdateWidget(covariant IMovieRemoteImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageUrl != widget.imageUrl) {
      _syncUrlState();
    }
  }

  void _syncUrlState() {
    _normalizedUrl = widget.imageUrl.trim();
    _hasPaintedBefore = _paintedImageUrls.contains(_normalizedUrl);
  }

  @override
  Widget build(BuildContext context) {
    final placeholder = _RemoteImagePlaceholder(label: widget.placeholderLabel);
    final image = _isFlutterTest || _normalizedUrl.isEmpty
        ? placeholder
        : Image(
            image: CachedNetworkImageProvider(
              _normalizedUrl,
              cacheKey: _normalizedUrl,
            ),
            fit: widget.fit,
            width: widget.width,
            height: widget.height,
            gaplessPlayback: true,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded || frame != null) {
                _markPainted();
                return child;
              }
              return _hasPaintedBefore ? child : placeholder;
            },
            errorBuilder: (context, error, stackTrace) => placeholder,
          );

    if (widget.borderRadius == null) {
      return image;
    }

    return ClipRRect(borderRadius: widget.borderRadius!, child: image);
  }

  void _markPainted() {
    if (_normalizedUrl.isEmpty || _hasPaintedBefore) {
      return;
    }
    _paintedImageUrls.add(_normalizedUrl);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _hasPaintedBefore) {
        return;
      }
      setState(() => _hasPaintedBefore = true);
    });
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
