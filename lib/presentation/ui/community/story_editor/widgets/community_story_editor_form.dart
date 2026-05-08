import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/ui/community/story_editor/community_story_editor_cubit.dart';
import 'package:imovie_app/presentation/ui/community/story_editor/community_story_editor_state.dart';
import 'package:imovie_app/presentation/ui/community/story_editor/widgets/community_story_editor_bottom_panel.dart';
import 'package:imovie_app/presentation/ui/community/story_editor/widgets/community_story_editor_header_bar.dart';
import 'package:imovie_app/presentation/ui/community/story_editor/widgets/community_story_image_canvas.dart';

class CommunityStoryEditorForm extends StatefulWidget {
  const CommunityStoryEditorForm({super.key});

  @override
  State<CommunityStoryEditorForm> createState() =>
      _CommunityStoryEditorFormState();
}

class _CommunityStoryEditorFormState extends State<CommunityStoryEditorForm> {
  late final TextEditingController _storyTextController;
  late final FocusNode _storyTextFocusNode;

  @override
  void initState() {
    super.initState();
    _storyTextController = TextEditingController(
      text: context.read<CommunityStoryEditorCubit>().state.storyText,
    );
    _storyTextFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _storyTextFocusNode.dispose();
    _storyTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<CommunityStoryEditorCubit, CommunityStoryEditorState>(
      buildWhen: (previous, current) =>
          previous.processing != current.processing ||
          previous.selectedImage != current.selectedImage ||
          previous.storyText != current.storyText ||
          previous.locationName != current.locationName ||
          previous.locationFullName != current.locationFullName ||
          previous.selectedMovieTitle != current.selectedMovieTitle ||
          previous.selectedMoviePosterUrl != current.selectedMoviePosterUrl ||
          previous.resolvingLocation != current.resolvingLocation ||
          previous.textPositionX != current.textPositionX ||
          previous.textPositionY != current.textPositionY ||
          previous.moviePositionX != current.moviePositionX ||
          previous.moviePositionY != current.moviePositionY ||
          previous.locationPositionX != current.locationPositionX ||
          previous.locationPositionY != current.locationPositionY,
      builder: (context, state) {
        final cubit = context.read<CommunityStoryEditorCubit>();
        if (_storyTextController.text != state.storyText) {
          _storyTextController.value = _storyTextController.value.copyWith(
            text: state.storyText,
            selection: TextSelection.collapsed(offset: state.storyText.length),
            composing: TextRange.empty,
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final mediaQuery = MediaQuery.of(context);
            final topInset = mediaQuery.padding.top;
            final bottomInset = mediaQuery.viewInsets.bottom;
            final safeBottom = mediaQuery.padding.bottom;
            final horizontalPadding = constraints.maxWidth > 480 ? 20.0 : 14.0;
            final panelBottomPadding = math.max(safeBottom, 16.0);
            final panelReservedHeight = bottomInset > 0
                ? math.min(300.0, constraints.maxHeight * 0.42)
                : math.min(272.0, constraints.maxHeight * 0.34);

            return Stack(
              children: [
                const Positioned.fill(child: _StoryEditorBackdrop()),
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      topInset + 12,
                      horizontalPadding,
                      0,
                    ),
                    child: Column(
                      children: [
                        CommunityStoryEditorHeaderBar(
                          title: l10n.communityStoryEditorTitle,
                          onCloseTap: () => Navigator.of(context).pop(),
                          trailing: _PublishStoryButton(
                            label: l10n.communityStoryPublishAction,
                            enabled: !state.processing,
                            onTap: () async {
                              final success = await cubit.submit(
                                messages: CommunityStoryEditorMessages(
                                  emptyImage: l10n.communityStoryImageRequired,
                                  createSuccess:
                                      l10n.communityCreateStorySuccess,
                                ),
                              );
                              if (success && context.mounted) {
                                Navigator.of(context).pop();
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, contentConstraints) {
                              final reservedBottomSpace =
                                  panelReservedHeight + panelBottomPadding;
                              final availableHeight =
                                  contentConstraints.maxHeight -
                                  reservedBottomSpace;
                              final canvasMaxHeight = math.max(
                                240.0,
                                availableHeight - 44,
                              );
                              final canvasMaxWidth = math.min(
                                math.min(constraints.maxWidth - 28, 430.0),
                                canvasMaxHeight * 9 / 16,
                              );
                              final canvasWidth = math.max(
                                180.0,
                                canvasMaxWidth,
                              );
                              final canvasHeight = canvasWidth * 16 / 9;

                              return SingleChildScrollView(
                                padding: EdgeInsets.only(
                                  bottom: reservedBottomSpace,
                                ),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: math.max(
                                      availableHeight,
                                      canvasMaxHeight + 44,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        l10n.communityStoryTextHint,
                                        style: AppTypography.body2Medium
                                            .copyWith(
                                              color: AppColors.grayscale200,
                                            ),
                                      ),
                                      const SizedBox(height: 12),
                                      SizedBox(
                                        width: canvasWidth,
                                        height: canvasHeight,
                                        child: CommunityStoryImageCanvas(
                                          selectedImage: state.selectedImage,
                                          storyText: state.storyText,
                                          textPosition: Offset(
                                            state.textPositionX,
                                            state.textPositionY,
                                          ),
                                          movieTitle: state.selectedMovieTitle,
                                          moviePosterUrl:
                                              state.selectedMoviePosterUrl,
                                          moviePosition: Offset(
                                            state.moviePositionX,
                                            state.moviePositionY,
                                          ),
                                          locationName: state.locationName,
                                          locationFullName:
                                              state.locationFullName,
                                          locationPosition: Offset(
                                            state.locationPositionX,
                                            state.locationPositionY,
                                          ),
                                          pickLabel: l10n
                                              .communityStoryPickImageAction,
                                          changeLabel: l10n
                                              .communityStoryChangeImageAction,
                                          removeLabel:
                                              l10n.communityRemoveImageAction,
                                          onPickTap: cubit.pickImage,
                                          onRemoveTap: cubit.removeImage,
                                          onTextPositionChanged:
                                              cubit.updateTextPosition,
                                          onMoviePositionChanged:
                                              cubit.updateMoviePosition,
                                          onLocationPositionChanged:
                                              cubit.updateLocationPosition,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: horizontalPadding,
                  right: horizontalPadding,
                  bottom: panelBottomPadding + bottomInset,
                  child: CommunityStoryEditorBottomPanel(
                    controller: _storyTextController,
                    focusNode: _storyTextFocusNode,
                    storyTextHint: l10n.communityStoryTextHint,
                    doneEditingLabel: l10n.communityStoryDoneEditingAction,
                    onStoryTextChanged: cubit.updateStoryText,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _StoryEditorBackdrop extends StatelessWidget {
  const _StoryEditorBackdrop();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.black, AppColors.grayscale950, AppColors.black],
        ),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, -0.45),
            radius: 1.15,
            colors: [
              AppColors.yellow500.withValues(alpha: 0.18),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}

class _PublishStoryButton extends StatelessWidget {
  const _PublishStoryButton({
    required this.label,
    required this.enabled,
    required this.onTap,
  });

  final String label;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: enabled ? AppColors.white : AppColors.grayscale700,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(999),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            label,
            style: AppTypography.button2Semibold.copyWith(
              color: AppColors.black,
            ),
          ),
        ),
      ),
    );
  }
}
