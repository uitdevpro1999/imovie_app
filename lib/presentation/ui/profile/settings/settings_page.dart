import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/domain/entities/profile/app_profile.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/app/app_cubit.dart';
import 'package:imovie_app/presentation/ui/main/main_cubit.dart';
import 'package:imovie_app/presentation/ui/profile/settings/settings_cubit.dart';
import 'package:imovie_app/presentation/ui/profile/settings/settings_state.dart';
import 'package:imovie_app/presentation/widgets/imovie_app_bar.dart';
import 'package:imovie_app/presentation/widgets/imovie_buttons.dart';
import 'package:imovie_app/presentation/widgets/imovie_preference_widgets.dart';
import 'package:imovie_app/presentation/widgets/imovie_remote_image.dart';

@RoutePage()
class SettingsPage extends StatelessWidget implements AutoRouteWrapper {
  const SettingsPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<MainCubit>()),
        BlocProvider(create: (_) => sl<SettingsCubit>()..initData()),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.grayscale950,
      appBar: IMovieAppBar(
        title: l10n.profileTitle,
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          Center(
            child: Container(
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: AppColors.yellow500,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.block_rounded,
                    size: 16,
                    color: AppColors.textPrimary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    l10n.homeBadgeAdFree,
                    style: AppTypography.captionMedium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_rounded),
            color: AppColors.white,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        top: false,
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            final child = _buildBody(context, l10n, state);
            return Stack(
              children: [
                Positioned.fill(child: child),
                if (state.processing)
                  const Positioned.fill(child: _SettingsProcessingOverlay()),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    AppLocalizations l10n,
    SettingsState state,
  ) {
    switch (state.pageStatus) {
      case PageStatus.initial:
      case PageStatus.loading:
        return const Center(
          child: CircularProgressIndicator(color: AppColors.yellow500),
        );
      case PageStatus.error:
        return _SettingsErrorView(
          message: state.failure?.message ?? l10n.retry,
          onRetry: context.read<SettingsCubit>().retry,
          l10n: l10n,
        );
      case PageStatus.loaded:
        if (state.isAuthenticated && state.profile != null) {
          return _SettingsContent(
            l10n: l10n,
            profile: state.profile!,
            onEditProfile: () => context.router.root.push(ProfileRoute()),
            onSignOut: () async {
              await context.read<SettingsCubit>().signOut(
                failureMessage: l10n.profileSignOutError,
              );
            },
          );
        }

        return _SignedOutSettingsView(
          l10n: l10n,
          onSignInTap: () => context.router.root.push(SignInRoute()),
        );
    }
  }
}

class _SettingsContent extends StatelessWidget {
  const _SettingsContent({
    required this.l10n,
    required this.profile,
    required this.onEditProfile,
    required this.onSignOut,
  });

  final AppLocalizations l10n;
  final AppProfile profile;
  final VoidCallback onEditProfile;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    final selectedLanguageCode = context.select(
      (AppCubit cubit) => cubit.state.localeCode,
    );
    final languageValue = selectedLanguageCode == 'en'
        ? l10n.profileSettingsEnglish
        : l10n.profileSettingsVietnamese;

    return ListView(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 104),
      children: [
        _SettingsProfileHeader(profile: profile),
        const SizedBox(height: 26),
        _SettingsSectionTitle(l10n.profileMainSettings),
        const SizedBox(height: 12),
        _SettingsGroup(
          children: [
            _SettingsTile(
              icon: Icons.person_outline_rounded,
              title: l10n.profileSettingsProfile,
              onTap: onEditProfile,
            ),
            _SettingsTile(
              icon: Icons.article_outlined,
              title: l10n.profileSettingsMyPosts,
              onTap: () => context.router.root.push(CommunityMineRoute()),
            ),
            _SettingsTile(
              icon: Icons.language_rounded,
              title: l10n.profileSettingsLanguage,
              value: languageValue,
              onTap: () => context.router.root.push(LanguageRoute()),
              isLast: true,
            ),
          ],
        ),
        const SizedBox(height: 24),
        _SettingsSectionTitle(l10n.profileOtherSettings),
        const SizedBox(height: 12),
        _SettingsGroup(
          children: [
            _SettingsTile(
              icon: Icons.help_outline_rounded,
              title: l10n.profileSettingsHelpCenter,
            ),
            _SettingsTile(
              icon: Icons.security_rounded,
              title: l10n.profileSettingsSecurity,
              onTap: () => context.router.root.push(ChangePasswordRoute()),
            ),
            _SettingsTile(
              icon: Icons.info_outline_rounded,
              title: l10n.profileSettingsAbout,
            ),
            _SettingsTile(
              icon: Icons.person_add_alt_1_rounded,
              title: l10n.profileSettingsInviteFriends,
            ),
            _SettingsTile(
              icon: Icons.star_border_rounded,
              title: l10n.profileSettingsRateApp,
            ),
            _SettingsTile(
              icon: Icons.logout_rounded,
              title: l10n.profileSignOutAction,
              titleColor: AppColors.red400,
              iconColor: AppColors.red400,
              onTap: onSignOut,
              isLast: true,
            ),
          ],
        ),
      ],
    );
  }
}

class _SettingsProfileHeader extends StatelessWidget {
  const _SettingsProfileHeader({required this.profile});

  final AppProfile profile;

  @override
  Widget build(BuildContext context) {
    final initials = profile.fullName.trim().isEmpty
        ? 'U'
        : profile.fullName.trim().characters.first.toUpperCase();

    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.grayscale800,
          ),
          clipBehavior: Clip.antiAlias,
          child: profile.avatarUrl.trim().isEmpty
              ? _InitialsAvatar(initials: initials)
              : IMovieRemoteImage(
                  imageUrl: profile.avatarUrl,
                  fit: BoxFit.cover,
                  placeholderLabel: initials,
                ),
        ),
        const SizedBox(height: 12),
        Text(
          profile.fullName,
          textAlign: TextAlign.center,
          style: AppTypography.h2.copyWith(color: AppColors.white),
        ),
        const SizedBox(height: 4),
        Text(
          _handleFromEmail(profile.email),
          textAlign: TextAlign.center,
          style: AppTypography.body2Regular.copyWith(
            color: AppColors.grayscale300,
          ),
        ),
      ],
    );
  }

  String _handleFromEmail(String email) {
    final prefix = email.split('@').first.trim();
    return prefix.isEmpty ? '@user' : '@$prefix';
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
        style: AppTypography.h1.copyWith(color: AppColors.yellow500),
      ),
    );
  }
}

class _SettingsSectionTitle extends StatelessWidget {
  const _SettingsSectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTypography.captionMedium.copyWith(color: AppColors.white),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Column(children: children),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    this.value,
    this.onTap,
    this.titleColor = AppColors.white,
    this.iconColor = AppColors.white,
    this.isLast = false,
  });

  final IconData icon;
  final String title;
  final String? value;
  final VoidCallback? onTap;
  final Color titleColor;
  final Color iconColor;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IMovieSettingsTile(
      label: title,
      icon: icon,
      value: value,
      showDivider: !isLast,
      isDestructive: titleColor == AppColors.red400,
      onTap: onTap,
      backgroundColor: AppColors.grayscale900,
      dividerColor: AppColors.grayscale800,
      textColor: titleColor,
      iconColor: iconColor,
      valueColor: AppColors.grayscale300,
      chevronColor: AppColors.white,
      horizontalPadding: 12,
      verticalPadding: 12,
    );
  }
}

class _SettingsErrorView extends StatelessWidget {
  const _SettingsErrorView({
    required this.l10n,
    required this.message,
    required this.onRetry,
  });

  final AppLocalizations l10n;
  final String message;
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
    );
  }
}

class _SettingsProcessingOverlay extends StatelessWidget {
  const _SettingsProcessingOverlay();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black38,
      child: const Center(
        child: CircularProgressIndicator(color: AppColors.yellow500),
      ),
    );
  }
}

class _SignedOutSettingsView extends StatelessWidget {
  const _SignedOutSettingsView({required this.l10n, required this.onSignInTap});

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
              Icons.person_outline_rounded,
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
