import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/domain/entities/home/home_country.dart';
import 'package:imovie_app/domain/entities/home/home_movie.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/common/pages/base_page.dart';
import 'package:imovie_app/presentation/ui/genre_movies/genre_movies_cubit.dart';
import 'package:imovie_app/presentation/ui/genre_movies/genre_movies_state.dart';
import 'package:imovie_app/presentation/widgets/imovie_app_bar.dart';
import 'package:imovie_app/presentation/widgets/imovie_buttons.dart';
import 'package:imovie_app/presentation/widgets/imovie_remote_image.dart';
import 'package:imovie_app/presentation/widgets/imovie_smart_refresher.dart';

part 'widgets/filter_selector.dart';
part 'widgets/genre_filter_bar.dart';
part 'widgets/genre_filter_sheet.dart';
part 'widgets/genre_movie_list_card.dart';
part 'widgets/genre_movies_list_view.dart';

@RoutePage()
class GenreMoviesPage extends BasePage<GenreMoviesCubit, GenreMoviesState>
    implements AutoRouteWrapper {
  const GenreMoviesPage({
    super.key,
    @PathParam('slug') required this.slug,
    this.title = '',
  });

  final String slug;
  final String title;

  @override
  Widget wrappedRoute(BuildContext context) {
    final resolvedTitle = title.trim().isEmpty ? slug : title;
    return BlocProvider(
      create: (_) => sl<GenreMoviesCubit>(param1: slug, param2: resolvedTitle),
      child: this,
    );
  }

  @override
  Widget wrapPage(BuildContext context, GenreMoviesState state, Widget child) {
    return Scaffold(
      backgroundColor: AppColors.grayscale950,
      appBar: IMovieAppBar(title: state.title),
      body: SafeArea(top: false, child: child),
    );
  }

  @override
  bool buildWhen(GenreMoviesState previous, GenreMoviesState current) {
    return previous.pageStatus != current.pageStatus ||
        previous.processing != current.processing ||
        previous.failure != current.failure ||
        previous.title != current.title;
  }

  @override
  Widget buildPage(
    BuildContext context,
    GenreMoviesCubit cubit,
    GenreMoviesState state,
  ) {
    return Column(
      children: [
        BlocBuilder<GenreMoviesCubit, GenreMoviesState>(
          buildWhen: (previous, current) =>
              previous.movies.length != current.movies.length ||
              previous.totalItems != current.totalItems ||
              previous.sortType != current.sortType ||
              previous.country != current.country ||
              previous.year != current.year ||
              previous.countries != current.countries,
          builder: (context, state) {
            return _GenreFilterBar(
              resultSummary: state.resultSummary,
              activeFilterChips: state.activeFilterChips,
              filterState: state,
              onApplyFilters: cubit.applyFilters,
            );
          },
        ),
        Expanded(
          child: BlocBuilder<GenreMoviesCubit, GenreMoviesState>(
            buildWhen: (previous, current) =>
                previous.movies != current.movies ||
                previous.totalItems != current.totalItems ||
                previous.loadingMore != current.loadingMore,
            builder: (context, state) {
              return _GenreMoviesListView(
                movies: state.movies,
                movieViewData: state.movieViewData,
                hasMore: state.hasMore,
                onRefresh: cubit.refresh,
                onLoadMore: () async {
                  final success = await cubit.loadMore();
                  return success
                      ? IMovieLoadMoreResult.success(
                          hasMore: cubit.state.hasMore,
                        )
                      : const IMovieLoadMoreResult.failure();
                },
              );
            },
          ),
        ),
      ],
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
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
