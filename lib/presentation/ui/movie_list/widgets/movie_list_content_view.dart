import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/domain/entities/home/home_movie.dart';
import 'package:imovie_app/presentation/ui/movie_list/movie_list_state.dart';
import 'package:imovie_app/presentation/ui/movie_list/widgets/movie_list_card.dart';
import 'package:imovie_app/presentation/widgets/imovie_smart_refresher.dart';

class MovieListContentView extends StatelessWidget {
  const MovieListContentView({
    super.key,
    required this.movies,
    required this.movieViewData,
    required this.resultSummary,
    required this.hasMore,
    required this.onRefresh,
    required this.onLoadMore,
  });

  final List<HomeMovie> movies;
  final List<MovieListItemViewData> movieViewData;
  final String resultSummary;
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
          if (index == 0) {
            return Text(
              resultSummary,
              style: AppTypography.body2Regular.copyWith(
                color: AppColors.grayscale300,
              ),
            );
          }

          final item = movieViewData[index - 1];
          return MovieListCard(
            item: item,
            onTap: () => context.router.push(
              MovieDetailRoute(slug: item.movie.slug, relatedMovies: movies),
            ),
          );
        },
        separatorBuilder: (_, index) => SizedBox(height: index == 0 ? 12 : 16),
        itemCount: movieViewData.length + 1,
      ),
    );
  }
}
