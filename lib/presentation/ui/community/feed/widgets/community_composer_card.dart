import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/ui/community/compose/community_compose_cubit.dart';
import 'package:imovie_app/presentation/ui/community/compose/community_compose_state.dart';
import 'package:imovie_app/presentation/ui/community/compose/widgets/community_image_preview.dart';
import 'package:imovie_app/presentation/ui/community/compose/widgets/community_movie_picker_field.dart';

class CommunityComposerCard extends StatefulWidget {
  const CommunityComposerCard({
    super.key,
    required this.prompt,
    required this.createLabel,
    required this.movieLabel,
    required this.imageLabel,
    this.onSubmitted,
  });

  final String prompt;
  final String createLabel;
  final String movieLabel;
  final String imageLabel;
  final FutureOr<void> Function()? onSubmitted;

  @override
  State<CommunityComposerCard> createState() => _CommunityComposerCardState();
}

class _CommunityComposerCardState extends State<CommunityComposerCard> {
  late final TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController();
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<CommunityComposeCubit, CommunityComposeState>(
      buildWhen: (previous, current) =>
          previous.processing != current.processing ||
          previous.resolvingLocation != current.resolvingLocation ||
          previous.locationName != current.locationName ||
          previous.locationFullName != current.locationFullName ||
          previous.selectedImages != current.selectedImages ||
          previous.existingImageUrls != current.existingImageUrls,
      builder: (context, state) {
        final imageCount =
            state.selectedImages.length + state.existingImageUrls.length;
        final hasImage = imageCount > 0;
        return Container(
          decoration: BoxDecoration(
            color: AppColors.grayscale900,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: AppColors.grayscale800),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.18),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _ComposerAvatar(),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _contentController,
                      minLines: 1,
                      maxLines: 3,
                      enabled: !state.processing,
                      cursorColor: AppColors.yellow500,
                      textCapitalization: TextCapitalization.sentences,
                      style: AppTypography.body2Regular.copyWith(
                        color: AppColors.white,
                        height: 1.35,
                      ),
                      decoration: InputDecoration(
                        hintText: widget.prompt,
                        hintStyle: AppTypography.body2Regular.copyWith(
                          color: AppColors.grayscale300,
                        ),
                        filled: true,
                        fillColor: AppColors.grayscale800,
                        border: _inputBorder(AppColors.grayscale700),
                        enabledBorder: _inputBorder(AppColors.grayscale700),
                        disabledBorder: _inputBorder(AppColors.grayscale700),
                        focusedBorder: _inputBorder(
                          AppColors.yellow500.withValues(alpha: 0.76),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: CommunityMoviePickerChip(label: widget.movieLabel),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _ComposerImageChip(
                      label: hasImage
                          ? '$imageCount/${CommunityComposeCubit.maxPostImages}'
                          : widget.imageLabel,
                      selected: hasImage,
                      onTap: context.read<CommunityComposeCubit>().pickImages,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _ComposerLocationChip(
                      label: state.locationName.trim().isNotEmpty
                          ? state.locationName
                          : l10n.communityLocationHint,
                      selected: state.locationName.trim().isNotEmpty,
                      loading: state.resolvingLocation,
                      tooltip: state.locationFullName.trim().isNotEmpty
                          ? state.locationFullName
                          : l10n.communityUseCurrentLocation,
                      onTap: () => context
                          .read<CommunityComposeCubit>()
                          .resolveCurrentLocation(
                            failureMessage: l10n.communityLocationError,
                          ),
                      onClear: () => context
                          .read<CommunityComposeCubit>()
                          .updateLocationName(''),
                    ),
                  ),
                  const SizedBox(width: 10),
                  _ComposerCreateBadge(
                    label: widget.createLabel,
                    processing: state.processing,
                    onTap: state.processing
                        ? null
                        : () => unawaited(_submit(context, l10n)),
                  ),
                ],
              ),
              if (hasImage) ...[
                const SizedBox(height: 12),
                CommunityImagePreview(
                  selectedImages: state.selectedImages,
                  existingImageUrls: state.existingImageUrls,
                  onPickTap: context.read<CommunityComposeCubit>().pickImages,
                  onRemoveSelectedImageTap: context
                      .read<CommunityComposeCubit>()
                      .removeSelectedImage,
                  onRemoveExistingImageTap: context
                      .read<CommunityComposeCubit>()
                      .removeExistingImageUrl,
                  pickLabel: widget.imageLabel,
                  removeLabel: l10n.communityRemoveImageAction,
                  maxImages: CommunityComposeCubit.maxPostImages,
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  OutlineInputBorder _inputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(999),
      borderSide: BorderSide(color: color),
    );
  }

  Future<void> _submit(BuildContext context, AppLocalizations l10n) async {
    final cubit = context.read<CommunityComposeCubit>();
    final success = await context.read<CommunityComposeCubit>().submit(
      content: _contentController.text,
      locationName: cubit.state.locationName,
      messages: CommunityComposeMessages(
        emptyContent: l10n.communityEmptyContentError,
        createSuccess: l10n.communityCreateSuccess,
        updateSuccess: l10n.communityUpdateSuccess,
      ),
    );
    if (!success || !context.mounted) {
      return;
    }

    await widget.onSubmitted?.call();
  }
}

class _ComposerLocationChip extends StatelessWidget {
  const _ComposerLocationChip({
    required this.label,
    required this.selected,
    required this.loading,
    required this.tooltip,
    required this.onTap,
    required this.onClear,
  });

  final String label;
  final bool selected;
  final bool loading;
  final String tooltip;
  final VoidCallback onTap;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(999),
        child: InkWell(
          onTap: loading ? null : onTap,
          borderRadius: BorderRadius.circular(999),
          child: Ink(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: AppColors.black.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: AppColors.grayscale800),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (loading)
                  const CupertinoActivityIndicator(
                    radius: 7,
                    color: AppColors.yellow500,
                  )
                else
                  Icon(
                    selected
                        ? FluentIcons.location_24_filled
                        : FluentIcons.location_24_regular,
                    size: 16,
                    color: selected
                        ? AppColors.yellow500
                        : AppColors.grayscale300,
                  ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.captionMedium.copyWith(
                      color: selected
                          ? AppColors.white
                          : AppColors.grayscale300,
                    ),
                  ),
                ),
                if (selected && !loading) ...[
                  const SizedBox(width: 4),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: onClear,
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        FluentIcons.dismiss_16_regular,
                        size: 14,
                        color: AppColors.grayscale300,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ComposerAvatar extends StatelessWidget {
  const _ComposerAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: AppColors.yellow950,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.yellow900),
      ),
      child: const Icon(
        FluentIcons.people_community_24_filled,
        color: AppColors.yellow500,
        size: 24,
      ),
    );
  }
}

class _ComposerCreateBadge extends StatelessWidget {
  const _ComposerCreateBadge({
    required this.label,
    required this.processing,
    this.onTap,
  });

  final String label;
  final bool processing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return Opacity(
      opacity: enabled ? 1 : 0.58,
      child: Material(
        color: AppColors.yellow500,
        borderRadius: BorderRadius.circular(999),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(999),
          child: SizedBox(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (processing)
                    const CupertinoActivityIndicator(
                      radius: 8,
                      color: AppColors.grayscale950,
                    )
                  else
                    const Icon(
                      FluentIcons.add_24_regular,
                      size: 18,
                      color: AppColors.grayscale950,
                    ),
                  const SizedBox(width: 4),
                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.captionMedium.copyWith(
                      color: AppColors.grayscale950,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ComposerImageChip extends StatelessWidget {
  const _ComposerImageChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Ink(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.black.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AppColors.grayscale800),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                selected
                    ? FluentIcons.image_24_filled
                    : FluentIcons.image_24_regular,
                size: 16,
                color: selected ? AppColors.yellow500 : AppColors.grayscale300,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.captionMedium.copyWith(
                    color: selected ? AppColors.white : AppColors.grayscale300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
