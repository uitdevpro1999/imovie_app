import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/presentation/widgets/moviego_buttons.dart';
import 'package:imovie_app/presentation/widgets/moviego_remote_image.dart';

class MovieGoHeroMovieCard extends StatelessWidget {
  const MovieGoHeroMovieCard({
    super.key,
    required this.imageUrl,
    required this.imageLabel,
  });

  final String imageUrl;
  final String imageLabel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 412,
      child: Stack(
        children: [
          Positioned.fill(
            child: MovieGoRemoteImage(
              imageUrl: imageUrl,
              borderRadius: BorderRadius.circular(24),
              placeholderLabel: imageLabel,
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, AppColors.black88],
                ),
              ),
            ),
          ),
          Positioned(
            left: 24,
            right: 24,
            bottom: 24,
            child: MovieGoButton(
              label: 'Watch trailer',
              leadingIcon: MovieGoButtonLeadingIcon.play,
            ),
          ),
        ],
      ),
    );
  }
}
