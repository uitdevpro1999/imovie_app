import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/domain/entities/home/home_genre.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/common/pages/base_page.dart';
import 'package:imovie_app/presentation/ui/genres/genres_cubit.dart';
import 'package:imovie_app/presentation/ui/genres/genres_state.dart';
import 'package:imovie_app/presentation/widgets/imovie_app_bar.dart';

part 'widgets/empty_genres.dart';
part 'widgets/genre_gradient_card.dart';
part 'widgets/genre_gradients.dart';

@RoutePage()
class GenresPage extends BasePage<GenresCubit, GenresState>
    implements AutoRouteWrapper {
  const GenresPage({super.key, this.genres = const []});

  final List<HomeGenre> genres;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<GenresCubit>(param1: genres),
      child: this,
    );
  }

  @override
  Widget wrapPage(BuildContext context, GenresState state, Widget child) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.grayscale950,
      appBar: IMovieAppBar(title: l10n.movieDetailGenres),
      body: SafeArea(top: false, child: child),
    );
  }

  @override
  Widget buildPage(BuildContext context, GenresCubit cubit, GenresState state) {
    final genres = state.genres;
    return genres.isEmpty
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
          );
  }

  @override
  Widget buildError(
    BuildContext context,
    AppLocalizations l10n,
    String message,
    VoidCallback onRetry,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: AppTypography.body1Regular.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
