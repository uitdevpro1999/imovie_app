import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  const CommunityComposeForm({super.key});

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
      listener: (context, state) {
        _locationController.text = state.locationName;
      },
      builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          children: [
            TextField(
              controller: _contentController,
              minLines: 5,
              maxLines: 10,
              style: AppTypography.body1Regular.copyWith(
                color: AppColors.white,
              ),
              decoration: _fieldDecoration(l10n.communityContentHint),
            ),
            const SizedBox(height: 14),
            const CommunityMoviePickerField(),
            const SizedBox(height: 12),
            _ComposeTextField(
              controller: _locationController,
              icon: Icons.place_outlined,
              hintText: l10n.communityLocationHint,
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
                      icon: const Icon(Icons.my_location_rounded),
                      color: AppColors.yellow500,
                    ),
            ),
            const SizedBox(height: 12),
            CommunityImagePreview(
              selectedImage: state.selectedImage,
              existingImageUrl: state.initialPost?.imageUrl ?? '',
              onPickTap: context.read<CommunityComposeCubit>().pickImage,
              onRemoveTap: context.read<CommunityComposeCubit>().removeImage,
              pickLabel: l10n.communityPickImageAction,
              removeLabel: l10n.communityRemoveImageAction,
            ),
            const SizedBox(height: 24),
            IMovieButton(
              label: state.isEditing
                  ? l10n.communityUpdateAction
                  : l10n.communityPublishAction,
              showLeadingIcon: false,
              foregroundColor: AppColors.textPrimary,
              enabled: !state.processing,
              onPressed: () async {
                final success = await context
                    .read<CommunityComposeCubit>()
                    .submit(
                      content: _contentController.text,
                      locationName: _locationController.text,
                      messages: CommunityComposeMessages(
                        emptyContent: l10n.communityEmptyContentError,
                        createSuccess: l10n.communityCreateSuccess,
                        updateSuccess: l10n.communityUpdateSuccess,
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

  InputDecoration _fieldDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: AppTypography.body1Regular.copyWith(
        color: AppColors.grayscale400,
      ),
      filled: true,
      fillColor: AppColors.grayscale900,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.all(14),
    );
  }
}

class _ComposeTextField extends StatelessWidget {
  const _ComposeTextField({
    required this.controller,
    required this.icon,
    required this.hintText,
    this.trailing,
  });

  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
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
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
