import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/ui/community/story_editor/community_story_editor_cubit.dart';
import 'package:imovie_app/presentation/ui/community/story_editor/community_story_editor_state.dart';

class CommunityStoryLocationField extends StatefulWidget {
  const CommunityStoryLocationField({super.key});

  @override
  State<CommunityStoryLocationField> createState() =>
      _CommunityStoryLocationFieldState();
}

class _CommunityStoryLocationFieldState
    extends State<CommunityStoryLocationField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: context.read<CommunityStoryEditorCubit>().state.locationName,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocConsumer<CommunityStoryEditorCubit, CommunityStoryEditorState>(
      listenWhen: (previous, current) =>
          previous.locationName != current.locationName,
      listener: (context, state) {
        if (_controller.text != state.locationName) {
          _controller.text = state.locationName;
        }
      },
      builder: (context, state) {
        return TextField(
          controller: _controller,
          onChanged: context
              .read<CommunityStoryEditorCubit>()
              .updateLocationName,
          style: AppTypography.body2Regular.copyWith(color: AppColors.white),
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.place_outlined,
              color: AppColors.yellow500,
            ),
            suffixIcon: state.resolvingLocation
                ? const SizedBox.square(
                    dimension: 44,
                    child: Center(
                      child: CupertinoActivityIndicator(
                        radius: 8,
                        color: AppColors.yellow500,
                      ),
                    ),
                  )
                : IconButton(
                    tooltip: l10n.communityUseCurrentLocation,
                    onPressed: () => context
                        .read<CommunityStoryEditorCubit>()
                        .resolveCurrentLocation(
                          failureMessage: l10n.communityLocationError,
                        ),
                    icon: const Icon(Icons.my_location_rounded),
                    color: AppColors.yellow500,
                  ),
            hintText: l10n.communityLocationHint,
            hintStyle: AppTypography.body2Regular.copyWith(
              color: AppColors.grayscale400,
            ),
            filled: true,
            fillColor: AppColors.grayscale900,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        );
      },
    );
  }
}
