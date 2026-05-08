import 'dart:async';
import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_screen_util.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/core/events/app_event_bus.dart';
import 'package:imovie_app/core/events/app_toast_event.dart';
import 'package:imovie_app/domain/entities/home/home_movie.dart';
import 'package:imovie_app/domain/entities/movie_detail/movie_detail.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/common/pages/base_page.dart';
import 'package:imovie_app/presentation/ui/movie_detail/movie_detail_cubit.dart';
import 'package:imovie_app/presentation/ui/movie_detail/movie_detail_state.dart';
import 'package:imovie_app/presentation/widgets/imovie_app_bar.dart';
import 'package:imovie_app/presentation/widgets/imovie_buttons.dart';
import 'package:imovie_app/presentation/widgets/imovie_content_widgets.dart';
import 'package:imovie_app/presentation/widgets/imovie_remote_image.dart';
import 'package:imovie_app/presentation/widgets/imovie_trailer_popup.dart';
import 'package:url_launcher/url_launcher.dart';

part 'widgets/detail_hero.dart';
part 'widgets/info_row.dart';
part 'widgets/movie_detail_scaffold.dart';
part 'widgets/movie_detail_success_view.dart';
part 'widgets/pill_label.dart';
part 'widgets/quick_action.dart';
part 'widgets/rating_source_sheet.dart';
part 'widgets/trailer_popup.dart';

const double _movieDetailHeroBaseHeight = 300;
const double _movieDetailContentOverlap = 24;

@RoutePage()
class MovieDetailPage extends BasePage<MovieDetailCubit, MovieDetailState>
    implements AutoRouteWrapper {
  const MovieDetailPage({
    super.key,
    @PathParam('slug') required this.slug,
    this.relatedMovies = const [],
  });

  final String slug;
  final List<HomeMovie> relatedMovies;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MovieDetailCubit>(param1: slug, param2: relatedMovies),
      child: this,
    );
  }

  @override
  Widget wrapPage(BuildContext context, MovieDetailState state, Widget child) {
    return _MovieDetailScaffold(child: child);
  }

  @override
  Widget buildPage(
    BuildContext context,
    MovieDetailCubit cubit,
    MovieDetailState state,
  ) {
    return _MovieDetailSuccessView(cubit: cubit, state: state);
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
              message.isEmpty ? l10n.movieDetailErrorLoad : message,
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
