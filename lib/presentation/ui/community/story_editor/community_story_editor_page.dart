import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/presentation/ui/community/story_editor/community_story_editor_cubit.dart';
import 'package:imovie_app/presentation/ui/community/story_editor/community_story_editor_state.dart';
import 'package:imovie_app/presentation/ui/community/story_editor/widgets/community_story_editor_form.dart';
import 'package:imovie_app/presentation/ui/community/story_editor/widgets/community_story_editor_loading_overlay.dart';

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
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          children: [
            const Positioned.fill(child: CommunityStoryEditorForm()),
            Positioned.fill(
              child:
                  BlocSelector<
                    CommunityStoryEditorCubit,
                    CommunityStoryEditorState,
                    bool
                  >(
                    selector: (state) => state.processing,
                    builder: (context, processing) {
                      return processing
                          ? const CommunityStoryEditorLoadingOverlay()
                          : const SizedBox.shrink();
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
