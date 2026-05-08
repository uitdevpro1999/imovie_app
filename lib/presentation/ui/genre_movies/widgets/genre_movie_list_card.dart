part of '../genre_movies_page.dart';

class GenreMovieListCard extends StatelessWidget {
  const GenreMovieListCard({
    required this.item,
    required this.onTap,
    super.key,
  });

  final GenreMovieViewData item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final movie = item.movie;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: AppColors.grayscale900,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.grayscale800),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Poster(movie: movie, ratingLabel: item.ratingLabel),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.body1Regular.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    if (movie.originalTitle.trim().isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        movie.originalTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.body2Regular.copyWith(
                          color: AppColors.grayscale400,
                        ),
                      ),
                    ],
                    const SizedBox(height: 8),
                    Text(
                      '${movie.yearLabel} • ${item.subtitle}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.body2Regular.copyWith(
                        color: AppColors.grayscale300,
                      ),
                    ),
                    if (item.tags.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          for (final tag in item.tags) _GenreTag(label: tag),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Poster extends StatelessWidget {
  const _Poster({required this.movie, required this.ratingLabel});

  final HomeMovie movie;
  final String ratingLabel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 82,
      height: 116,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: IMovieRemoteImage(
                imageUrl: movie.posterUrl,
                fit: BoxFit.cover,
                placeholderLabel: movie.title,
              ),
            ),
          ),
          Positioned(
            left: 6,
            top: 6,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.black88,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      FluentIcons.star_24_filled,
                      size: 12,
                      color: AppColors.yellow500,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      ratingLabel,
                      style: AppTypography.captionMedium.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GenreTag extends StatelessWidget {
  const _GenreTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.grayscale800,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          label,
          style: AppTypography.captionRegular1.copyWith(
            color: AppColors.grayscale200,
          ),
        ),
      ),
    );
  }
}
