import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/domain/entities/community/community_profile.dart';
import 'package:imovie_app/domain/entities/profile/app_profile.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/app/app_cubit.dart';
import 'package:imovie_app/presentation/ui/profile/settings/widgets/settings_community_stats_card.dart';
import 'package:imovie_app/presentation/ui/profile/settings/widgets/settings_profile_header.dart';
import 'package:imovie_app/presentation/ui/profile/settings/widgets/settings_sections.dart';

class SettingsContent extends StatelessWidget {
  const SettingsContent({
    super.key,
    required this.l10n,
    required this.profile,
    required this.communityProfile,
    required this.communityStatsLoading,
    required this.onPostsTap,
    required this.onFollowersTap,
    required this.onFollowingTap,
    required this.onCommunityProfileTap,
    required this.onSignOut,
  });

  final AppLocalizations l10n;
  final AppProfile profile;
  final CommunityProfile? communityProfile;
  final bool communityStatsLoading;
  final VoidCallback onPostsTap;
  final VoidCallback onFollowersTap;
  final VoidCallback onFollowingTap;
  final VoidCallback onCommunityProfileTap;
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
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 110),
      children: [
        SettingsProfileHeader(profile: profile),
        const SizedBox(height: 14),
        SettingsCommunityStatsCard(
          l10n: l10n,
          communityProfile: communityProfile,
          isLoading: communityStatsLoading,
          onPostsTap: onPostsTap,
          onFollowersTap: onFollowersTap,
          onFollowingTap: onFollowingTap,
        ),
        const SizedBox(height: 26),
        SettingsSectionTitle(l10n.profileMainSettings),
        const SizedBox(height: 10),
        SettingsGroup(
          children: [
            SettingsTile(
              icon: FluentIcons.people_community_24_regular,
              title: l10n.profileSettingsMyPosts,
              onTap: onCommunityProfileTap,
            ),
            SettingsTile(
              icon: FluentIcons.local_language_24_regular,
              title: l10n.profileSettingsLanguage,
              value: languageValue,
              onTap: () => context.router.root.push(LanguageRoute()),
              isLast: true,
            ),
          ],
        ),
        const SizedBox(height: 24),
        SettingsSectionTitle(l10n.profileOtherSettings),
        const SizedBox(height: 10),
        SettingsGroup(
          children: [
            SettingsTile(
              icon: FluentIcons.question_circle_24_regular,
              title: l10n.profileSettingsHelpCenter,
              onTap: () => context.router.root.push(const ContactRoute()),
            ),
            SettingsTile(
              icon: FluentIcons.shield_24_regular,
              title: l10n.profileSettingsSecurity,
              onTap: () => context.router.root.push(ChangePasswordRoute()),
            ),
            SettingsTile(
              icon: FluentIcons.info_24_regular,
              title: l10n.profileSettingsAbout,
              onTap: () => context.router.root.push(const AboutRoute()),
            ),
            SettingsTile(
              icon: FluentIcons.person_add_24_regular,
              title: l10n.profileSettingsInviteFriends,
            ),
            SettingsTile(
              icon: FluentIcons.star_24_regular,
              title: l10n.profileSettingsRateApp,
            ),
            SettingsTile(
              icon: FluentIcons.sign_out_24_regular,
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
