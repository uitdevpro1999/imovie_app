import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/presentation/ui/community/story_editor/widgets/community_story_location_field.dart';
import 'package:imovie_app/presentation/ui/community/story_editor/widgets/community_story_movie_picker_field.dart';

class CommunityStoryEditorBottomPanel extends StatelessWidget {
  const CommunityStoryEditorBottomPanel({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.storyTextHint,
    required this.doneEditingLabel,
    required this.onStoryTextChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String storyTextHint;
  final String doneEditingLabel;
  final ValueChanged<String> onStoryTextChanged;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.black.withValues(alpha: 0.72),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.white.withValues(alpha: 0.08)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.22),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: controller,
                  focusNode: focusNode,
                  maxLines: 3,
                  minLines: 1,
                  cursorColor: AppColors.white,
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: onStoryTextChanged,
                  onSubmitted: (_) => FocusScope.of(context).unfocus(),
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  style: AppTypography.body1Regular.copyWith(
                    color: AppColors.white,
                    height: 1.35,
                  ),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      tooltip: doneEditingLabel,
                      onPressed: () => FocusScope.of(context).unfocus(),
                      icon: const Icon(FluentIcons.keyboard_dock_24_regular),
                      color: AppColors.grayscale200,
                    ),
                    hintText: storyTextHint,
                    hintStyle: AppTypography.body2Regular.copyWith(
                      color: AppColors.grayscale300,
                    ),
                    filled: true,
                    fillColor: AppColors.white.withValues(alpha: 0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                  ),
                ),
                const SizedBox(height: 12),
                const CommunityStoryMoviePickerField(),
                const SizedBox(height: 12),
                const CommunityStoryLocationField(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
