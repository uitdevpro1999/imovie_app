import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/common/pages/base_page.dart';
import 'package:imovie_app/presentation/ui/community/feed/widgets/community_story_viewer_dialog.dart';
import 'package:imovie_app/presentation/ui/community/story_viewer/community_story_viewer_cubit.dart';
import 'package:imovie_app/presentation/ui/community/story_viewer/community_story_viewer_state.dart';

@RoutePage()
class CommunityStoryViewerPage
    extends BasePage<CommunityStoryViewerCubit, CommunityStoryViewerState>
    implements AutoRouteWrapper {
  const CommunityStoryViewerPage({super.key, required this.storyId});

  final String storyId;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CommunityStoryViewerCubit>(param1: storyId),
      child: this,
    );
  }

  @override
  Widget wrapPage(
    BuildContext context,
    CommunityStoryViewerState state,
    Widget child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(top: false, bottom: false, child: child),
    );
  }

  @override
  Widget buildPage(
    BuildContext context,
    CommunityStoryViewerCubit cubit,
    CommunityStoryViewerState state,
  ) {
    if (state.stories.isEmpty) {
      return const SizedBox.expand();
    }

    return CommunityStoryViewerDialog(
      stories: state.stories,
      initialIndex: state.initialIndex,
      deleteLabel: AppLocalizations.of(context)!.communityDeleteAction,
      onDeleteTap: (story) async {
        final deleted = await cubit.deleteStory(
          story: story,
          successMessage: AppLocalizations.of(
            context,
          )!.communityDeleteStorySuccess,
        );
        if (deleted && context.mounted && cubit.state.stories.isEmpty) {
          await context.router.maybePop();
        }
      },
      onAuthorTap: (userId) {
        final normalizedUserId = userId.trim();
        if (normalizedUserId.isEmpty) {
          return;
        }
        context.router.replace(CommunityProfileRoute(userId: normalizedUserId));
      },
      fullscreenModal: false,
    );
  }
}
