import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/common/pages/base_page.dart';
import 'package:imovie_app/presentation/ui/library/library_cubit.dart';
import 'package:imovie_app/presentation/ui/library/library_state.dart';
import 'package:imovie_app/presentation/ui/library/widgets/library_content_view.dart';
import 'package:imovie_app/presentation/widgets/imovie_app_bar.dart';

@RoutePage()
class LibraryPage extends BasePage<LibraryCubit, LibraryState>
    implements AutoRouteWrapper {
  const LibraryPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (_) => sl<LibraryCubit>(), child: this);
  }

  @override
  Widget wrapPage(BuildContext context, LibraryState state, Widget child) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.grayscale950,
      appBar: IMovieAppBar(title: l10n.homeBottomNavLibrary),
      body: SafeArea(child: child),
    );
  }

  @override
  Widget buildPage(
    BuildContext context,
    LibraryCubit cubit,
    LibraryState state,
  ) {
    final l10n = AppLocalizations.of(context)!;
    return LibraryContentView(
      movies: state.movies,
      emptyTitle: l10n.libraryEmptyTitle,
      emptySubtitle: l10n.libraryEmptySubtitle,
      collectionTitle: l10n.libraryCollectionTitle,
      collectionSubtitle: l10n.libraryCollectionSubtitle,
      savedMoviesLabel: l10n.libraryStatsMovies,
      playableMoviesLabel: l10n.libraryStatsPlayable,
      swipeHint: l10n.librarySwipeHint,
      removeActionLabel: l10n.libraryRemoveAction,
      removeConfirmTitle: l10n.libraryRemoveConfirmTitle,
      removeConfirmMessage: l10n.libraryRemoveConfirmMessage,
      removeConfirmCancel: l10n.libraryRemoveConfirmCancel,
      removeConfirmAction: l10n.libraryRemoveConfirmAction,
      onMovieTap: (item) => context.router.push(
        MovieDetailRoute(slug: item.movie.slug, relatedMovies: const []),
      ),
      onMovieRemove: (item) => cubit.removeMovie(
        item: item,
        successMessage: l10n.libraryRemoveSuccess,
      ),
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
          message.isEmpty ? l10n.libraryErrorLoad : message,
          textAlign: TextAlign.center,
          style: AppTypography.body1Regular.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
