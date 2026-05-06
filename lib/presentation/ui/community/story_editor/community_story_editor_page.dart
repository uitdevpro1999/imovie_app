import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/ui/community/story_editor/community_story_editor_cubit.dart';
import 'package:imovie_app/presentation/ui/community/story_editor/community_story_editor_state.dart';
import 'package:imovie_app/presentation/ui/community/story_editor/widgets/community_story_editor_form.dart';
import 'package:imovie_app/presentation/ui/community/story_editor/widgets/community_story_editor_loading_overlay.dart';
import 'package:imovie_app/presentation/widgets/imovie_app_bar.dart';

@RoutePage()
class CommunityStoryEditorPage extends StatelessWidget
    implements AutoRouteWrapper {
  const CommunityStoryEditorPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CommunityStoryEditorCubit>(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<CommunityStoryEditorCubit, CommunityStoryEditorState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.grayscale950,
          appBar: IMovieAppBar(title: l10n.communityStoryEditorTitle),
          body: SafeArea(
            child: Stack(
              children: [
                const Positioned.fill(child: CommunityStoryEditorForm()),
                if (state.processing)
                  const Positioned.fill(
                    child: CommunityStoryEditorLoadingOverlay(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
