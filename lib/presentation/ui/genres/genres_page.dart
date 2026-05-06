import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/domain/entities/home/home_genre.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/widgets/moviego_app_bar.dart';

part 'widgets/empty_genres.dart';
part 'widgets/genre_gradient_card.dart';
part 'widgets/genre_gradients.dart';

@RoutePage()
class GenresPage extends StatelessWidget {
  const GenresPage({super.key, this.genres = const []});

  final List<HomeGenre> genres;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.grayscale950,
      appBar: MovieGoAppBar(title: l10n.movieDetailGenres),
      body: SafeArea(
        top: false,
        child: genres.isEmpty
            ? const _EmptyGenres()
            : GridView.builder(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.45,
                ),
                itemCount: genres.length,
                itemBuilder: (context, index) {
                  return _GenreGradientCard(
                    genre: genres[index],
                    gradient: _GenreGradients.byIndex(index),
                    onTap: () => context.router.push(
                      GenreMoviesRoute(
                        slug: genres[index].slug,
                        title: genres[index].name,
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
