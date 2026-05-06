import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/domain/entities/movie_detail/movie_detail.dart';
import 'package:imovie_app/domain/entities/movie_detail/movie_stream_server.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/common/pages/base_page.dart';
import 'package:imovie_app/presentation/ui/movie_watch/movie_watch_cubit.dart';
import 'package:imovie_app/presentation/ui/movie_watch/movie_watch_state.dart';
import 'package:imovie_app/presentation/widgets/imovie_app_bar.dart';
import 'package:imovie_app/presentation/widgets/imovie_buttons.dart';
import 'package:m3u8_player/m3u8_player.dart';

part 'widgets/episode_grid.dart';
part 'widgets/info_card.dart';
part 'widgets/info_summary.dart';
part 'widgets/meta_pill.dart';
part 'widgets/movie_player_card.dart';
part 'widgets/movie_watch_success_view.dart';
part 'widgets/section_title.dart';
part 'widgets/selectable_pill.dart';

const _isFlutterTest = bool.fromEnvironment('FLUTTER_TEST');
bool get _isWidgetTestRuntime =>
    WidgetsBinding.instance.runtimeType.toString().contains('Test');

@RoutePage()
class MovieWatchPage extends BasePage<MovieWatchCubit, MovieWatchState>
    implements AutoRouteWrapper {
  const MovieWatchPage({
    super.key,
    @PathParam('slug') required this.slug,
    this.initialDetail,
  });

  final String slug;
  final MovieDetail? initialDetail;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MovieWatchCubit>(param1: slug, param2: initialDetail),
      child: this,
    );
  }

  @override
  Widget wrapPage(BuildContext context, MovieWatchState state, Widget child) {
    return Scaffold(
      backgroundColor: AppColors.grayscale950,
      appBar: IMovieAppBar(
        title: AppLocalizations.of(context)!.watchScreenTitle,
      ),
      body: child,
    );
  }

  @override
  Widget buildPage(
    BuildContext context,
    MovieWatchCubit cubit,
    MovieWatchState state,
  ) {
    return BlocSelector<MovieWatchCubit, MovieWatchState, MovieWatchState>(
      selector: (state) => state,
      builder: (context, state) {
        return _MovieWatchSuccessView(
          state: state,
          onSelectServer: cubit.selectServer,
          onSelectEpisode: cubit.selectEpisode,
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
              message.isEmpty ? l10n.watchLoadError : message,
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
