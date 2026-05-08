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
import 'package:imovie_app/presentation/ui/browse/browse_cubit.dart';
import 'package:imovie_app/presentation/ui/browse/browse_state.dart';
import 'package:imovie_app/presentation/widgets/imovie_buttons.dart';
import 'package:imovie_app/presentation/widgets/imovie_content_widgets.dart';
import 'package:imovie_app/presentation/widgets/imovie_smart_refresher.dart';

part 'widgets/browse_genres_section.dart';
part 'widgets/browse_filter_selector.dart';
part 'widgets/browse_movie_strip_section.dart';
part 'widgets/browse_search_filter_sheet.dart';
part 'widgets/browse_search_field.dart';
part 'widgets/browse_success_view.dart';

@RoutePage()
class BrowsePage extends BasePage<BrowseCubit, BrowseState>
    implements AutoRouteWrapper {
  BrowsePage({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (_) => sl<BrowseCubit>(), child: this);
  }

  @override
  Widget wrapPage(BuildContext context, BrowseState state, Widget child) {
    return Scaffold(
      backgroundColor: AppColors.grayscale950,
      body: SafeArea(bottom: false, child: child),
    );
  }

  @override
  bool buildWhen(BrowseState previous, BrowseState current) {
    return previous.pageStatus != current.pageStatus ||
        previous.processing != current.processing ||
        previous.failure != current.failure;
  }

  @override
  Widget buildPage(BuildContext context, BrowseCubit cubit, BrowseState state) {
    return BlocBuilder<BrowseCubit, BrowseState>(
      buildWhen: (previous, current) =>
          previous.feed != current.feed ||
          previous.genres != current.genres ||
          previous.countries != current.countries ||
          previous.keyword != current.keyword ||
          previous.searchLoading != current.searchLoading ||
          previous.searchLoadingMore != current.searchLoadingMore ||
          previous.searchResults != current.searchResults ||
          previous.searchTotalItems != current.searchTotalItems ||
          previous.searchSortType != current.searchSortType ||
          previous.searchCountry != current.searchCountry ||
          previous.searchYear != current.searchYear,
      builder: (context, state) {
        return _BrowseSuccessView(
          state: state,
          controller: _searchController,
          onKeywordChanged: cubit.onKeywordChanged,
          onApplySearchFilters: cubit.applySearchFilters,
          onRefresh: cubit.refresh,
          onLoadMoreSearch: () async {
            final success = await cubit.loadMoreSearch();
            return success
                ? IMovieLoadMoreResult.success(
                    hasMore: cubit.state.searchHasMore,
                  )
                : const IMovieLoadMoreResult.failure();
          },
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

  @override
  void onDispose(BuildContext context) {
    _searchController.dispose();
  }
}
