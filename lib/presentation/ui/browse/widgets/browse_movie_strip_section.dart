part of '../browse_page.dart';

class _BrowseMovieStripSection extends StatelessWidget {
  const _BrowseMovieStripSection({
    required this.title,
    required this.actionLabel,
    required this.movies,
    required this.relatedMovies,
  });

  final String title;
  final String actionLabel;
  final List<BrowseMovieViewData> movies;
  final List<HomeMovie> relatedMovies;

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieGoSectionHeader(
          title: title,
          actionLabel: actionLabel,
          titleColor: AppColors.white,
          actionColor: AppColors.yellow500,
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 236,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final item = movies[index];
              return GestureDetector(
                onTap: () => context.router.push(
                  MovieDetailRoute(
                    slug: item.movie.slug,
                    relatedMovies: relatedMovies,
                  ),
                ),
                child: MovieGoPosterCard(
                  imageUrl: item.movie.posterUrl,
                  title: item.movie.title,
                  subtitle: item.subtitleLabel,
                  badgeText: item.ratingLabel,
                  width: 124,
                  titleColor: AppColors.white,
                  subtitleColor: AppColors.grayscale300,
                ),
              );
            },
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemCount: movies.length,
          ),
        ),
      ],
    );
  }
}
