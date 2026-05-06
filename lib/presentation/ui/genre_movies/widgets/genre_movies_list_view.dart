part of '../genre_movies_page.dart';

class _GenreMoviesListView extends StatelessWidget {
  const _GenreMoviesListView({
    required this.movies,
    required this.movieViewData,
    required this.hasMore,
    required this.loadingMore,
    required this.onLoadMore,
  });

  final List<HomeMovie> movies;
  final List<GenreMovieViewData> movieViewData;
  final bool hasMore;
  final bool loadingMore;
  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context) {
    if (movieViewData.isEmpty) {
      return Center(
        child: Text(
          'Không có phim phù hợp',
          style: AppTypography.body1Regular.copyWith(
            color: AppColors.grayscale300,
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      itemBuilder: (context, index) {
        if (index == movieViewData.length) {
          return _LoadMoreButton(
            loadingMore: loadingMore,
            onLoadMore: onLoadMore,
          );
        }

        final item = movieViewData[index];
        return GenreMovieListCard(
          item: item,
          onTap: () => context.router.push(
            MovieDetailRoute(slug: item.movie.slug, relatedMovies: movies),
          ),
        );
      },
      separatorBuilder: (_, _) => const SizedBox(height: 16),
      itemCount: movieViewData.length + (hasMore ? 1 : 0),
    );
  }
}
