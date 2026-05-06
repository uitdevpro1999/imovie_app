import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/domain/entities/home/home_movie.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/common/pages/base_page.dart';
import 'package:imovie_app/presentation/ui/browse/browse_cubit.dart';
import 'package:imovie_app/presentation/ui/browse/browse_state.dart';
import 'package:imovie_app/presentation/widgets/moviego_buttons.dart';
import 'package:imovie_app/presentation/widgets/moviego_content_widgets.dart';
import 'package:imovie_app/presentation/widgets/moviego_remote_image.dart';

part 'widgets/browse_genres_section.dart';
part 'widgets/browse_movie_strip_section.dart';
part 'widgets/browse_promo_card.dart';
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
  Widget buildPage(BuildContext context, BrowseCubit cubit, BrowseState state) {
    return BlocSelector<BrowseCubit, BrowseState, BrowseState>(
      selector: (state) => state,
      builder: (context, state) {
        return _BrowseSuccessView(
          state: state,
          controller: _searchController,
          onKeywordChanged: cubit.onKeywordChanged,
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
            MovieGoButton(
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
