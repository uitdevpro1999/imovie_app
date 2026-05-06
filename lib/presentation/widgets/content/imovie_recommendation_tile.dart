import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/presentation/widgets/imovie_remote_image.dart';

class IMovieRecommendationTile extends StatelessWidget {
  const IMovieRecommendationTile({
    super.key,
    required this.imageUrl,
    required this.imageLabel,
  });

  final String imageUrl;
  final String imageLabel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 156,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IMovieRemoteImage(
            imageUrl: imageUrl,
            width: 156,
            height: 156,
            borderRadius: BorderRadius.circular(24),
            placeholderLabel: imageLabel,
          ),
          const SizedBox(height: 10),
          Text(
            imageLabel,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.body2Medium,
          ),
        ],
      ),
    );
  }
}
