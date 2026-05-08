import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/domain/entities/profile/app_profile.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/common/pages/base_page.dart';
import 'package:imovie_app/presentation/ui/main/main_cubit.dart';
import 'package:imovie_app/presentation/ui/profile/edit_profile/edit_profile_cubit.dart';
import 'package:imovie_app/presentation/ui/profile/edit_profile/edit_profile_state.dart';
import 'package:imovie_app/presentation/ui/profile/edit_profile/widgets/profile_cover_picker.dart';
import 'package:imovie_app/presentation/widgets/imovie_app_bar.dart';
import 'package:imovie_app/presentation/widgets/imovie_buttons.dart';
import 'package:imovie_app/presentation/widgets/imovie_remote_image.dart';

@RoutePage()
class ProfilePage extends BasePage<EditProfileCubit, EditProfileState>
    implements AutoRouteWrapper {
  ProfilePage({super.key});

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<MainCubit>()),
        BlocProvider(create: (_) => sl<EditProfileCubit>()),
      ],
      child: this,
    );
  }

  @override
  Widget wrapPage(BuildContext context, EditProfileState state, Widget child) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.grayscale950,
      appBar: IMovieAppBar(title: l10n.profileSettingsProfile),
      body: SafeArea(top: false, child: child),
    );
  }

  @override
  void onViewLoaded(
    BuildContext context,
    EditProfileCubit cubit,
    EditProfileState state,
  ) {
    _syncControllers(state.profile);
  }

  @override
  bool buildWhen(EditProfileState previous, EditProfileState current) {
    return previous.pageStatus != current.pageStatus ||
        previous.failure != current.failure ||
        previous.isAuthenticated != current.isAuthenticated ||
        previous.profile != current.profile ||
        previous.pendingAvatarBytes != current.pendingAvatarBytes ||
        previous.pendingCoverBytes != current.pendingCoverBytes ||
        previous.processing != current.processing;
  }

  @override
  Widget buildPage(
    BuildContext context,
    EditProfileCubit cubit,
    EditProfileState state,
  ) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listenWhen: (previous, current) => previous.profile != current.profile,
      buildWhen: (previous, current) =>
          previous.isAuthenticated != current.isAuthenticated ||
          previous.profile != current.profile ||
          previous.pendingAvatarBytes != current.pendingAvatarBytes ||
          previous.pendingCoverBytes != current.pendingCoverBytes,
      listener: (context, state) {
        _syncControllers(state.profile);
      },
      builder: (context, state) {
        if (!state.isAuthenticated) {
          return _SignedOutProfileView(
            l10n: l10n,
            onSignInTap: () => context.router.root.push(SignInRoute()),
          );
        }

        final profile = state.profile;
        if (profile == null) {
          return _ProfileEmptyView(l10n: l10n, onRetry: cubit.retry);
        }

        return _ProfileContent(
          l10n: l10n,
          profile: profile,
          pendingAvatarBytes: state.pendingAvatarBytes,
          pendingCoverBytes: state.pendingCoverBytes,
          fullNameController: _fullNameController,
          phoneController: _phoneController,
          onPickCover: () async {
            final file = await _imagePicker.pickImage(
              source: ImageSource.gallery,
              maxWidth: 1280,
              imageQuality: 85,
            );
            if (file == null) {
              return;
            }

            await cubit.selectCover(
              file: file,
              invalidFileMessage: l10n.profileInvalidAvatar,
            );
          },
          onPickAvatar: () async {
            final file = await _imagePicker.pickImage(
              source: ImageSource.gallery,
              maxWidth: 512,
              imageQuality: 85,
            );
            if (file == null) {
              return;
            }

            await cubit.selectAvatar(
              file: file,
              invalidFileMessage: l10n.profileInvalidAvatar,
            );
          },
          onSave: () async {
            final saved = await cubit.saveProfile(
              fullName: _fullNameController.text,
              phone: _phoneController.text,
              successMessage: l10n.profileSaved,
              emptyNameMessage: l10n.profileFullNameRequired,
            );
            if (!saved || !context.mounted) {
              return;
            }

            await context.router.maybePop();
          },
        );
      },
    );
  }

  @override
  Widget buildError(
    BuildContext context,
    AppLocalizations l10n,
    String message,
    VoidCallback onRetry,
  ) {
    return Scaffold(
      backgroundColor: AppColors.grayscale950,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: AppTypography.body1Regular.copyWith(
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 16),
                IMovieButton(
                  label: l10n.retry,
                  showLeadingIcon: false,
                  foregroundColor: AppColors.textPrimary,
                  onPressed: onRetry,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onDispose(BuildContext context) {
    _fullNameController.dispose();
    _phoneController.dispose();
  }

  void _syncControllers(AppProfile? profile) {
    if (profile == null) {
      return;
    }

    if (_fullNameController.text != profile.fullName) {
      _fullNameController.text = profile.fullName;
    }
    if (_phoneController.text != profile.phone) {
      _phoneController.text = profile.phone;
    }
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent({
    required this.l10n,
    required this.profile,
    required this.pendingAvatarBytes,
    required this.pendingCoverBytes,
    required this.fullNameController,
    required this.phoneController,
    required this.onPickCover,
    required this.onPickAvatar,
    required this.onSave,
  });

  final AppLocalizations l10n;
  final AppProfile profile;
  final Uint8List? pendingAvatarBytes;
  final Uint8List? pendingCoverBytes;
  final TextEditingController fullNameController;
  final TextEditingController phoneController;
  final VoidCallback onPickCover;
  final VoidCallback onPickAvatar;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            children: [
              ProfileCoverPicker(
                profile: profile,
                pendingCoverBytes: pendingCoverBytes,
                label: l10n.profileChangeCover,
                onPickCover: onPickCover,
              ),
              const SizedBox(height: 18),
              Center(
                child: _ProfileAvatar(
                  profile: profile,
                  pendingAvatarBytes: pendingAvatarBytes,
                  onPickAvatar: onPickAvatar,
                ),
              ),
              const SizedBox(height: 24),
              _EditProfileField(
                label: l10n.profileFullNameLabel,
                placeholder: l10n.profileFullNameHint,
                controller: fullNameController,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              _EditProfileReadonlyField(
                label: l10n.authEmailLabel,
                value: profile.email,
              ),
              const SizedBox(height: 16),
              _EditProfileField(
                label: l10n.profilePhoneLabel,
                placeholder: l10n.profilePhoneHint,
                controller: phoneController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: SizedBox(
              width: double.infinity,
              child: IMovieButton(
                label: l10n.profileSaveAction,
                type: IMovieButtonType.filled,
                showLeadingIcon: false,
                onPressed: onSave,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({
    required this.profile,
    required this.pendingAvatarBytes,
    required this.onPickAvatar,
  });

  final AppProfile profile;
  final Uint8List? pendingAvatarBytes;
  final VoidCallback onPickAvatar;

  @override
  Widget build(BuildContext context) {
    final initials = profile.fullName.trim().isEmpty
        ? 'U'
        : profile.fullName.trim().characters.first.toUpperCase();

    return SizedBox(
      width: 104,
      height: 104,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.grayscale800,
              ),
              clipBehavior: Clip.antiAlias,
              child: pendingAvatarBytes != null
                  ? Image.memory(
                      pendingAvatarBytes!,
                      fit: BoxFit.cover,
                      gaplessPlayback: true,
                    )
                  : profile.avatarUrl.trim().isEmpty
                  ? _InitialsAvatar(initials: initials)
                  : IMovieRemoteImage(
                      imageUrl: profile.avatarUrl,
                      fit: BoxFit.cover,
                      placeholderLabel: initials,
                    ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Material(
              color: AppColors.grayscale900,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onPickAvatar,
                child: const SizedBox.square(
                  dimension: 36,
                  child: Icon(
                    FluentIcons.camera_24_regular,
                    color: AppColors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EditProfileField extends StatelessWidget {
  const _EditProfileField({
    required this.label,
    required this.placeholder,
    required this.controller,
    this.keyboardType,
    this.textInputAction,
  });

  final String label;
  final String placeholder;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return _EditProfileFieldShell(
      label: label,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        style: AppTypography.body2Regular.copyWith(
          color: AppColors.white,
          height: 1.4,
        ),
        cursorColor: AppColors.yellow500,
        decoration: InputDecoration.collapsed(
          hintText: placeholder,
          hintStyle: AppTypography.body2Regular.copyWith(
            color: AppColors.grayscale400,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}

class _EditProfileReadonlyField extends StatelessWidget {
  const _EditProfileReadonlyField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return _EditProfileFieldShell(
      label: label,
      child: Text(
        value,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTypography.body2Regular.copyWith(
          color: AppColors.grayscale300,
          height: 1.4,
        ),
      ),
    );
  }
}

class _EditProfileFieldShell extends StatelessWidget {
  const _EditProfileFieldShell({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.body2Medium.copyWith(
            color: AppColors.white,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 52,
          width: double.infinity,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.grayscale900,
            borderRadius: BorderRadius.circular(12),
          ),
          child: child,
        ),
      ],
    );
  }
}

class _InitialsAvatar extends StatelessWidget {
  const _InitialsAvatar({required this.initials});

  final String initials;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        initials,
        style: AppTypography.display.copyWith(color: AppColors.yellow500),
      ),
    );
  }
}

class _SignedOutProfileView extends StatelessWidget {
  const _SignedOutProfileView({required this.l10n, required this.onSignInTap});

  final AppLocalizations l10n;
  final VoidCallback onSignInTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              FluentIcons.person_24_regular,
              color: AppColors.yellow500,
              size: 56,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.profileSignedOutTitle,
              textAlign: TextAlign.center,
              style: AppTypography.h2.copyWith(color: AppColors.white),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.profileSignedOutSubtitle,
              textAlign: TextAlign.center,
              style: AppTypography.body2Regular.copyWith(
                color: AppColors.grayscale300,
              ),
            ),
            const SizedBox(height: 24),
            IMovieButton(
              label: l10n.authSignInAction,
              showLeadingIcon: false,
              foregroundColor: AppColors.textPrimary,
              onPressed: onSignInTap,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileEmptyView extends StatelessWidget {
  const _ProfileEmptyView({required this.l10n, required this.onRetry});

  final AppLocalizations l10n;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.profileEmpty,
              textAlign: TextAlign.center,
              style: AppTypography.body1Regular.copyWith(
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 16),
            IMovieButton(
              label: l10n.retry,
              showLeadingIcon: false,
              foregroundColor: AppColors.textPrimary,
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
