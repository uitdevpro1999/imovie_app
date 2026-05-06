import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/common/pages/base_page.dart';
import 'package:imovie_app/presentation/ui/movie_trailer/movie_trailer_cubit.dart';
import 'package:imovie_app/presentation/ui/movie_trailer/movie_trailer_state.dart';
import 'package:imovie_app/presentation/ui/movie_trailer/widgets/movie_trailer_player_view.dart';
import 'package:imovie_app/presentation/widgets/imovie_app_bar.dart';
import 'package:imovie_app/presentation/widgets/imovie_buttons.dart';

class MovieTrailerPage extends BasePage<MovieTrailerCubit, MovieTrailerState>
    implements AutoRouteWrapper {
  const MovieTrailerPage({
    super.key,
    required this.title,
    required this.trailerUrl,
  });

  final String title;
  final String trailerUrl;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MovieTrailerCubit>(param1: title, param2: trailerUrl),
      child: this,
    );
  }

  @override
  Widget wrapPage(BuildContext context, MovieTrailerState state, Widget child) {
    final l10n = AppLocalizations.of(context)!;
    final title = state.title.trim().isEmpty
        ? l10n.movieDetailActionTrailer
        : state.title;

    return Scaffold(
      backgroundColor: AppColors.grayscale950,
      appBar: IMovieAppBar(title: title),
      body: SafeArea(top: false, child: child),
    );
  }

  @override
  Widget buildPage(
    BuildContext context,
    MovieTrailerCubit cubit,
    MovieTrailerState state,
  ) {
    return MovieTrailerPlayerView(title: state.title, videoId: state.videoId);
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.movieTrailerUnavailable,
              textAlign: TextAlign.center,
              style: AppTypography.body1Regular.copyWith(
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 16),
            IMovieButton(
              label: l10n.retry,
              showLeadingIcon: false,
              foregroundColor: AppColors.textPrimary,
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
