import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/common/pages/base_page.dart';
import 'package:imovie_app/presentation/ui/movie_list/movie_list_cubit.dart';
import 'package:imovie_app/presentation/ui/movie_list/movie_list_state.dart';
import 'package:imovie_app/presentation/ui/movie_list/widgets/movie_list_content_view.dart';
import 'package:imovie_app/presentation/widgets/imovie_app_bar.dart';
import 'package:imovie_app/presentation/widgets/imovie_buttons.dart';
import 'package:imovie_app/presentation/widgets/imovie_smart_refresher.dart';

@RoutePage()
class MovieListPage extends BasePage<MovieListCubit, MovieListState>
    implements AutoRouteWrapper {
  const MovieListPage({
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
      create: (_) => sl<MovieListCubit>(param1: slug, param2: resolvedTitle),
      child: this,
    );
  }

  @override
  Widget wrapPage(BuildContext context, MovieListState state, Widget child) {
    return Scaffold(
      backgroundColor: AppColors.grayscale950,
      appBar: IMovieAppBar(title: state.title),
      body: SafeArea(top: false, child: child),
    );
  }

  @override
  Widget buildPage(
    BuildContext context,
    MovieListCubit cubit,
    MovieListState state,
  ) {
    return MovieListContentView(
      movies: state.movies,
      movieViewData: state.movieViewData,
      resultSummary: state.resultSummary,
      hasMore: state.hasMore,
      onRefresh: cubit.refresh,
      onLoadMore: () async {
        final success = await cubit.loadMore();
        return success
            ? IMovieLoadMoreResult.success(hasMore: cubit.state.hasMore)
            : const IMovieLoadMoreResult.failure();
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
