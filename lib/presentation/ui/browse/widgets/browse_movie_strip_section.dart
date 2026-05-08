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
        IMovieSectionHeader(
          title: title,
          actionLabel: actionLabel,
          titleColor: AppColors.white,
          actionColor: AppColors.yellow500,
        ),
        const SizedBox(height: 16),
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.grayscale900,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.white.withValues(alpha: 0.06)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
            child: SizedBox(
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
                    child: IMoviePosterCard(
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
          ),
        ),
      ],
    );
  }
}
