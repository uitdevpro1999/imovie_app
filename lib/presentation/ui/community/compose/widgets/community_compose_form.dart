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
import 'package:imovie_app/presentation/widgets/imovie_buttons.dart';

class CommunityComposeForm extends StatefulWidget {
  const CommunityComposeForm({
    super.key,
    this.embedded = false,
    this.onCancel,
    this.onSuccess,
  });

  final bool embedded;
  final VoidCallback? onCancel;
  final FutureOr<void> Function()? onSuccess;

  @override
  State<CommunityComposeForm> createState() => _CommunityComposeFormState();
}

class _CommunityComposeFormState extends State<CommunityComposeForm> {
  late final TextEditingController _contentController;
  late final TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    final state = context.read<CommunityComposeCubit>().state;
    _contentController = TextEditingController(
      text: state.initialPost?.content ?? '',
    );
    _locationController = TextEditingController(text: state.locationName);
  }

  @override
  void dispose() {
    _contentController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocConsumer<CommunityComposeCubit, CommunityComposeState>(
      listenWhen: (previous, current) =>
          previous.locationName != current.locationName,
      buildWhen: (previous, current) =>
          previous.processing != current.processing ||
          previous.resolvingLocation != current.resolvingLocation ||
          previous.selectedImages != current.selectedImages ||
          previous.existingImageUrls != current.existingImageUrls,
      listener: (context, state) {
        _locationController.text = state.locationName;
      },
      builder: (context, state) {
        final children = [
          TextField(
            controller: _contentController,
            minLines: widget.embedded ? 4 : 6,
            maxLines: widget.embedded ? 8 : 12,
            cursorColor: AppColors.yellow500,
            textCapitalization: TextCapitalization.sentences,
            style: AppTypography.body1Regular.copyWith(
              color: AppColors.white,
              height: 1.45,
            ),
            decoration: _fieldDecoration(l10n.communityContentHint),
          ),
          const SizedBox(height: 16),
          const CommunityMoviePickerField(),
          const SizedBox(height: 14),
          _ComposeTextField(
            controller: _locationController,
            icon: FluentIcons.location_24_regular,
            hintText: l10n.communityLocationHint,
            onChanged: context.read<CommunityComposeCubit>().updateLocationName,
            trailing: state.resolvingLocation
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
                        .read<CommunityComposeCubit>()
                        .resolveCurrentLocation(
                          failureMessage: l10n.communityLocationError,
                        ),
                    icon: const Icon(FluentIcons.my_location_24_regular),
                    color: AppColors.yellow500,
                  ),
          ),
          const SizedBox(height: 14),
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
            pickLabel: l10n.communityPickImageAction,
            removeLabel: l10n.communityRemoveImageAction,
          ),
          const SizedBox(height: 26),
          _ComposeActions(
            embedded: widget.embedded,
            processing: state.processing,
            cancelLabel: l10n.communityCancelAction,
            submitLabel: state.isEditing
                ? l10n.communityUpdateAction
                : l10n.communityPublishAction,
            onCancel: widget.onCancel,
            onSubmit: () => _submit(context, l10n),
          ),
        ];

        if (widget.embedded) {
          return Padding(
            padding: const EdgeInsets.all(14),
            child: Column(mainAxisSize: MainAxisSize.min, children: children),
          );
        }

        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 28),
          children: children,
        );
      },
    );
  }

  Future<void> _submit(BuildContext context, AppLocalizations l10n) async {
    final success = await context.read<CommunityComposeCubit>().submit(
      content: _contentController.text,
      locationName: _locationController.text,
      messages: CommunityComposeMessages(
        emptyContent: l10n.communityEmptyContentError,
        createSuccess: l10n.communityCreateSuccess,
        updateSuccess: l10n.communityUpdateSuccess,
      ),
    );
    if (!success || !context.mounted) {
      return;
    }

    final onSuccess = widget.onSuccess;
    if (onSuccess != null) {
      await onSuccess();
      return;
    }

    Navigator.of(context).pop();
  }

  InputDecoration _fieldDecoration(String hintText) {
    final borderRadius = BorderRadius.circular(20);
    return InputDecoration(
      hintText: hintText,
      hintStyle: AppTypography.body1Regular.copyWith(
        color: AppColors.grayscale400,
      ),
      filled: true,
      fillColor: AppColors.grayscale900,
      border: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: const BorderSide(color: AppColors.grayscale800),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: const BorderSide(color: AppColors.grayscale800),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: AppColors.yellow500.withValues(alpha: 0.78),
        ),
      ),
      contentPadding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
    );
  }
}

class _ComposeActions extends StatelessWidget {
  const _ComposeActions({
    required this.embedded,
    required this.processing,
    required this.cancelLabel,
    required this.submitLabel,
    required this.onSubmit,
    this.onCancel,
  });

  final bool embedded;
  final bool processing;
  final String cancelLabel;
  final String submitLabel;
  final Future<void> Function() onSubmit;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    final submitButton = IMovieButton(
      label: submitLabel,
      showLeadingIcon: false,
      foregroundColor: AppColors.textPrimary,
      enabled: !processing,
      onPressed: () => unawaited(onSubmit()),
    );

    if (!embedded) {
      return submitButton;
    }

    return Row(
      children: [
        Expanded(
          child: IMovieButton(
            label: cancelLabel,
            type: IMovieButtonType.stroke,
            showLeadingIcon: false,
            enabled: !processing,
            onPressed: onCancel,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: submitButton),
      ],
    );
  }
}

class _ComposeTextField extends StatelessWidget {
  const _ComposeTextField({
    required this.controller,
    required this.icon,
    required this.hintText,
    this.onChanged,
    this.trailing,
  });

  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(18);
    return TextField(
      controller: controller,
      onChanged: onChanged,
      cursorColor: AppColors.yellow500,
      style: AppTypography.body2Regular.copyWith(color: AppColors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.yellow500),
        suffixIcon: trailing,
        hintText: hintText,
        hintStyle: AppTypography.body2Regular.copyWith(
          color: AppColors.grayscale400,
        ),
        filled: true,
        fillColor: AppColors.grayscale900,
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: AppColors.grayscale800),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: AppColors.grayscale800),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: AppColors.yellow500.withValues(alpha: 0.78),
          ),
        ),
      ),
    );
  }
}
