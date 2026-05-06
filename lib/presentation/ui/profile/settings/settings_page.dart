import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/domain/entities/profile/app_profile.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/app/app_cubit.dart';
import 'package:imovie_app/presentation/common/pages/base_page.dart';
import 'package:imovie_app/presentation/ui/profile/profile_cubit.dart';
import 'package:imovie_app/presentation/ui/profile/profile_state.dart';
import 'package:imovie_app/presentation/widgets/moviego_app_bar.dart';
import 'package:imovie_app/presentation/widgets/moviego_buttons.dart';
import 'package:imovie_app/presentation/widgets/moviego_preference_widgets.dart';
import 'package:imovie_app/presentation/widgets/moviego_remote_image.dart';

@RoutePage()
class SettingsPage extends BasePage<ProfileCubit, ProfileState>
    implements AutoRouteWrapper {
  const SettingsPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (_) => sl<ProfileCubit>(), child: this);
  }

  @override
  Widget wrapPage(BuildContext context, ProfileState state, Widget child) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.grayscale950,
      appBar: MovieGoAppBar(
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
      body: SafeArea(top: false, child: child),
    );
  }

  @override
  Widget buildPage(
    BuildContext context,
    ProfileCubit cubit,
    ProfileState state,
  ) {
    final l10n = AppLocalizations.of(context)!;

    return state.isAuthenticated && state.profile != null
        ? _SettingsContent(
            l10n: l10n,
            profile: state.profile!,
            onEditProfile: () => context.router.root.push(ProfileRoute()),
            onSignOut: () async {
              final signedOut = await cubit.signOut(
                failureMessage: l10n.profileSignOutError,
              );
              if (signedOut && context.mounted) {
                context.read<AppCubit>().markUnauthenticated();
              }
            },
          )
        : _SignedOutSettingsView(
            l10n: l10n,
            onSignInTap: () => context.router.root.push(const SignInRoute()),
          );
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
    return ListView(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 104),
      children: [
        _SettingsProfileHeader(profile: profile),
        const SizedBox(height: 26),
        _SettingsSectionTitle(l10n.profileWatchHistory),
        const SizedBox(height: 8),
        _WatchHistoryStats(l10n: l10n),
        const SizedBox(height: 24),
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
              icon: Icons.notifications_none_rounded,
              title: l10n.profileSettingsNotifications,
            ),
            _SettingsTile(
              icon: Icons.volume_up_outlined,
              title: l10n.profileSettingsAudioSubtitles,
            ),
            _SettingsTile(
              icon: Icons.palette_outlined,
              title: l10n.profileSettingsAppearance,
              value: l10n.profileSettingsDefault,
            ),
            _SettingsTile(
              icon: Icons.language_rounded,
              title: l10n.profileSettingsLanguage,
              value: l10n.profileSettingsEnglish,
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
              : MovieGoRemoteImage(
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

class _WatchHistoryStats extends StatelessWidget {
  const _WatchHistoryStats({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.grayscale900,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: _WatchHistoryStat(value: '0', label: l10n.profileMovies),
          ),
          Expanded(
            child: _WatchHistoryStat(value: '0', label: l10n.profileShows),
          ),
          Expanded(
            child: _WatchHistoryStat(value: '0', label: l10n.profileEpisodes),
          ),
        ],
      ),
    );
  }
}

class _WatchHistoryStat extends StatelessWidget {
  const _WatchHistoryStat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: AppTypography.h2.copyWith(color: AppColors.white)),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTypography.body2Regular.copyWith(
            color: AppColors.grayscale300,
          ),
        ),
      ],
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
    return MovieGoSettingsTile(
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
            MovieGoButton(
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
