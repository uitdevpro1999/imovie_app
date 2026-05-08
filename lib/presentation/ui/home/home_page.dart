import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/core/events/app_event_bus.dart';
import 'package:imovie_app/core/events/app_toast_event.dart';
import 'package:imovie_app/domain/entities/home/home_movie.dart';
import 'package:imovie_app/gen/assets.gen.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/common/pages/base_page.dart';
import 'package:imovie_app/presentation/ui/home/home_cubit.dart';
import 'package:imovie_app/presentation/ui/home/home_state.dart';
import 'package:imovie_app/presentation/ui/home/widgets/home_featured_updates_section.dart';
import 'package:imovie_app/presentation/ui/home/widgets/home_hero_banner.dart';
import 'package:imovie_app/presentation/ui/home/widgets/home_hero_slider.dart';
import 'package:imovie_app/presentation/ui/home/widgets/home_movie_strip_section.dart';
import 'package:imovie_app/presentation/ui/home/widgets/home_notification_button.dart';
import 'package:imovie_app/presentation/widgets/imovie_app_bar.dart';
import 'package:imovie_app/presentation/widgets/imovie_buttons.dart';
import 'package:imovie_app/presentation/widgets/imovie_smart_refresher.dart';
import 'package:imovie_app/presentation/widgets/imovie_trailer_popup.dart';

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
      appBar: IMovieAppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        titleWidget: Container(
          height: 38,
          padding: const EdgeInsets.only(left: 6, right: 12),
          decoration: BoxDecoration(
            color: AppColors.grayscale900,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AppColors.grayscale800),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: Assets.images.logo.image(
                  width: 28,
                  height: 28,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'iMovie',
                style: AppTypography.h4.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.yellow500,
                borderRadius: BorderRadius.circular(999),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.yellow500.withValues(alpha: 0.18),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    FluentIcons.prohibited_24_regular,
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
          const SizedBox(width: 10),
          const HomeNotificationButton(),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(bottom: false, child: child),
    );
  }

  @override
  Widget buildPage(BuildContext context, HomeCubit cubit, HomeState state) {
    return _HomeSuccessView(
      state: state,
      onRefresh: cubit.refresh,
      onPlayMovie: (movie) => _openWatch(context, movie),
      onOpenTrailer: (movie) => unawaited(_openTrailer(context, cubit, movie)),
    );
  }

  void _openWatch(BuildContext context, HomeMovie movie) {
    context.router.push(MovieWatchRoute(slug: movie.slug));
  }

  Future<void> _openTrailer(
    BuildContext context,
    HomeCubit cubit,
    HomeMovie movie,
  ) async {
    final unavailableMessage = AppLocalizations.of(
      context,
    )!.movieTrailerUnavailable;
    final detail = await cubit.loadMovieDetailForAction(movie.slug);
    if (!context.mounted || detail == null) {
      return;
    }

    final videoId = IMovieTrailerPopup.videoIdFromUrl(detail.trailerUrl);
    if (videoId == null || videoId.trim().isEmpty) {
      appEventBus.emitToast(AppToastEvent.warning(unavailableMessage));
      return;
    }

    showDialog<void>(
      context: context,
      barrierColor: AppColors.black.withValues(alpha: 0.82),
      builder: (_) => IMovieTrailerPopup(
        title: detail.title.trim().isEmpty ? movie.title : detail.title,
        videoId: videoId,
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
