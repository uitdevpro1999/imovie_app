part of '../genre_movies_page.dart';

class _GenreMoviesListView extends StatelessWidget {
  const _GenreMoviesListView({
    required this.movies,
    required this.movieViewData,
    required this.hasMore,
    required this.onRefresh,
    required this.onLoadMore,
  });

  final List<HomeMovie> movies;
  final List<GenreMovieViewData> movieViewData;
  final bool hasMore;
  final Future<bool> Function() onRefresh;
  final Future<IMovieLoadMoreResult> Function() onLoadMore;

  @override
  Widget build(BuildContext context) {
    if (movieViewData.isEmpty) {
      return IMovieSmartRefresher(
        onRefresh: onRefresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.55,
              child: Center(
                child: Text(
                  'Không có phim phù hợp',
                  style: AppTypography.body1Regular.copyWith(
                    color: AppColors.grayscale300,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return IMovieSmartRefresher(
      onRefresh: onRefresh,
      onLoadMore: onLoadMore,
      enablePullUp: hasMore,
      hasMore: hasMore,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        itemBuilder: (context, index) {
          final item = movieViewData[index];
          return GenreMovieListCard(
            item: item,
            onTap: () => context.router.push(
              MovieDetailRoute(slug: item.movie.slug, relatedMovies: movies),
            ),
          );
        },
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemCount: movieViewData.length,
      ),
    );
  }
}
