import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/common/pages/base_page.dart';
import 'package:imovie_app/presentation/ui/home/home_cubit.dart';
import 'package:imovie_app/presentation/ui/home/home_state.dart';
import 'package:imovie_app/presentation/ui/home/widgets/home_hero_banner.dart';
import 'package:imovie_app/presentation/ui/home/widgets/home_hero_slider.dart';
import 'package:imovie_app/presentation/ui/home/widgets/home_movie_strip_section.dart';
import 'package:imovie_app/presentation/widgets/moviego_app_bar.dart';
import 'package:imovie_app/presentation/widgets/moviego_buttons.dart';
import 'package:imovie_app/presentation/widgets/moviego_content_widgets.dart';

part 'widgets/home_genres_section.dart';
part 'widgets/home_success_view.dart';

@RoutePage()
class HomePage extends BasePage<HomeCubit, HomeState>
    implements AutoRouteWrapper {
  const HomePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (_) => sl<HomeCubit>(), child: this);
  }

  @override
  Widget wrapPage(BuildContext context, HomeState state, Widget child) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.grayscale950,
      appBar: MovieGoAppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        titleWidget: RichText(
          text: TextSpan(
            style: AppTypography.h4.copyWith(color: AppColors.white),
            children: const [
              TextSpan(text: 'Movie'),
              TextSpan(
                text: 'Go',
                style: TextStyle(color: AppColors.yellow500),
              ),
            ],
          ),
        ),
        actions: [
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.white, AppColors.yellow500],
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.block_flipped,
                    size: 14,
                    color: AppColors.textPrimary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    l10n.homeBadgeAdFree,
                    style: AppTypography.captionMedium,
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
            color: AppColors.white,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(bottom: false, child: child),
    );
  }

  @override
  Widget buildPage(BuildContext context, HomeCubit cubit, HomeState state) {
    return _HomeSuccessView(state: state);
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
}
