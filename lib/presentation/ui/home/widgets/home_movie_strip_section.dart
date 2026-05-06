import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/domain/entities/home/home_movie.dart';
import 'package:imovie_app/presentation/ui/home/home_state.dart';
import 'package:imovie_app/presentation/widgets/moviego_content_widgets.dart';

class HomeMovieStripSection extends StatelessWidget {
  const HomeMovieStripSection({
    super.key,
    required this.title,
    required this.movies,
    required this.actionLabel,
    required this.relatedMovies,
  });

  final String title;
  final List<HomeMovieViewData> movies;
  final String actionLabel;
  final List<HomeMovie> relatedMovies;

  @override
  Widget build(BuildContext context) {
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
          height: 258,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final movie = movies[index];

              return GestureDetector(
                onTap: () => context.router.push(
                  MovieDetailRoute(
                    slug: movie.slug,
                    relatedMovies: relatedMovies,
                  ),
                ),
                child: MovieGoPosterCard(
                  imageUrl: movie.posterUrl,
                  title: movie.title,
                  subtitle: movie.subtitleLabel,
                  badgeText: movie.ratingLabel,
                  width: 140,
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
