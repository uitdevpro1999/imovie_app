part of '../browse_page.dart';

class _BrowsePromoCard extends StatelessWidget {
  const _BrowsePromoCard({
    required this.movie,
    required this.index,
    required this.onTap,
  });

  final BrowseMovieViewData movie;
  final int index;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final gradients = [
      [const Color(0xFFFF8A1F), const Color(0xFFFF2F3F)],
      [const Color(0xFFFF9DA9), const Color(0xFFFF3046)],
      [const Color(0xFF172B16), const Color(0xFF111111)],
    ];
    final colors = gradients[index % gradients.length];

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Ink(
        width: 132,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: colors,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Opacity(
              opacity: 0.55,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: MovieGoRemoteImage(
                  imageUrl: movie.movie.posterUrl,
                  fit: BoxFit.cover,
                  placeholderLabel: movie.movie.title,
                ),
              ),
            ),
            Positioned(
              left: 10,
              top: 10,
              child: Text(
                'TOP\n${index == 0
                    ? '250'
                    : index == 1
                    ? '100'
                    : '50'}',
                style: AppTypography.h3.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  height: 0.9,
                ),
              ),
            ),
            Positioned(
              left: 10,
              right: 10,
              bottom: 10,
              child: Text(
                movie.movie.title.toUpperCase(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.captionMedium.copyWith(
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
