import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/ui/community/story_editor/community_story_editor_cubit.dart';
import 'package:imovie_app/presentation/ui/community/story_editor/community_story_editor_state.dart';
import 'package:imovie_app/presentation/ui/community/story_editor/widgets/community_story_image_canvas.dart';
import 'package:imovie_app/presentation/ui/community/story_editor/widgets/community_story_location_field.dart';
import 'package:imovie_app/presentation/ui/community/story_editor/widgets/community_story_movie_picker_field.dart';
import 'package:imovie_app/presentation/widgets/imovie_buttons.dart';

class CommunityStoryEditorForm extends StatefulWidget {
  const CommunityStoryEditorForm({super.key});

  @override
  State<CommunityStoryEditorForm> createState() =>
      _CommunityStoryEditorFormState();
}

class _CommunityStoryEditorFormState extends State<CommunityStoryEditorForm> {
  late final TextEditingController _storyTextController;

  @override
  void initState() {
    super.initState();
    _storyTextController = TextEditingController(
      text: context.read<CommunityStoryEditorCubit>().state.storyText,
    );
  }

  @override
  void dispose() {
    _storyTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<CommunityStoryEditorCubit, CommunityStoryEditorState>(
      builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 360),
                child: CommunityStoryImageCanvas(
                  selectedImage: state.selectedImage,
                  storyText: state.storyText,
                  textPosition: Offset(
                    state.textPositionX,
                    state.textPositionY,
                  ),
                  movieTitle: state.selectedMovieTitle,
                  moviePosterUrl: state.selectedMoviePosterUrl,
                  moviePosition: Offset(
                    state.moviePositionX,
                    state.moviePositionY,
                  ),
                  locationName: state.locationName,
                  locationPosition: Offset(
                    state.locationPositionX,
                    state.locationPositionY,
                  ),
                  pickLabel: l10n.communityStoryPickImageAction,
                  changeLabel: l10n.communityStoryChangeImageAction,
                  onPickTap: context
                      .read<CommunityStoryEditorCubit>()
                      .pickImage,
                  onRemoveTap: context
                      .read<CommunityStoryEditorCubit>()
                      .removeImage,
                  onTextPositionChanged: context
                      .read<CommunityStoryEditorCubit>()
                      .updateTextPosition,
                  onMoviePositionChanged: context
                      .read<CommunityStoryEditorCubit>()
                      .updateMoviePosition,
                  onLocationPositionChanged: context
                      .read<CommunityStoryEditorCubit>()
                      .updateLocationPosition,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _storyTextController,
              maxLines: 3,
              minLines: 1,
              onChanged: context
                  .read<CommunityStoryEditorCubit>()
                  .updateStoryText,
              style: AppTypography.body1Regular.copyWith(
                color: AppColors.white,
              ),
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.text_fields_rounded,
                  color: AppColors.yellow500,
                ),
                hintText: l10n.communityStoryTextHint,
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
            ),
            const SizedBox(height: 12),
            const CommunityStoryMoviePickerField(),
            const SizedBox(height: 12),
            const CommunityStoryLocationField(),
            const SizedBox(height: 24),
            IMovieButton(
              label: l10n.communityStoryPublishAction,
              showLeadingIcon: false,
              foregroundColor: AppColors.textPrimary,
              enabled: !state.processing,
              onPressed: () async {
                final success = await context
                    .read<CommunityStoryEditorCubit>()
                    .submit(
                      messages: CommunityStoryEditorMessages(
                        emptyImage: l10n.communityStoryImageRequired,
                        createSuccess: l10n.communityCreateStorySuccess,
                      ),
                    );
                if (success && context.mounted) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
