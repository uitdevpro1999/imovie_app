import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/presentation/widgets/imovie_remote_image.dart';

class IMovieActorCard extends StatelessWidget {
  const IMovieActorCard({
    super.key,
    required this.imageUrl,
    required this.name,
    this.width = 88,
    this.imageSize = 64,
    this.textColor = AppColors.textPrimary,
  });

  final String imageUrl;
  final String name;
  final double width;
  final double imageSize;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IMovieRemoteImage(
            imageUrl: imageUrl,
            width: imageSize,
            height: imageSize,
            borderRadius: BorderRadius.circular(24),
            placeholderLabel: name,
          ),
          const SizedBox(height: 8),
          Text(
            name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: AppTypography.captionRegular1.copyWith(color: textColor),
          ),
        ],
      ),
    );
  }
}
