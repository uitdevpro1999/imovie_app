part of '../movie_detail_page.dart';

class _DetailHero extends StatelessWidget {
  const _DetailHero({required this.detail});

  final MovieDetail detail;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: math.max(300.0, 300.h),
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          IMovieRemoteImage(
            imageUrl: detail.backdropUrl,
            fit: BoxFit.cover,
            placeholderLabel: detail.title,
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, AppColors.grayscale950],
                stops: [0.3, 1],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
