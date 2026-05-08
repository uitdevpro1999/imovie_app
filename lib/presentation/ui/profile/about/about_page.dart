import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/ui/profile/about/widgets/about_focus_card.dart';
import 'package:imovie_app/presentation/ui/profile/about/widgets/about_profile_hero.dart';
import 'package:imovie_app/presentation/widgets/imovie_app_bar.dart';

@RoutePage()
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.grayscale950,
      appBar: IMovieAppBar(title: l10n.profileSettingsAbout),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
          children: [
            AboutProfileHero(
              sectionTitle: l10n.profileAboutTitle,
              subtitle: l10n.profileAboutSubtitle,
              name: 'Nguyễn Quốc Trung',
              handleLabel: l10n.profileAboutHandle,
              handleValue: '@shinjitsu_kudo',
              role: l10n.profileAboutRole,
              companyLabel: l10n.profileAboutCompany,
              companyValue: 'Aggregatori Capaci - Systematic Functions',
              avatarAssetPath: 'assets/images/author_avatar.jpeg',
            ),
            const SizedBox(height: 20),
            AboutFocusCard(
              title: l10n.profileAboutFocusTitle,
              subtitle: l10n.profileAboutFocusSubtitle,
              tags: [
                l10n.profileAboutFocusFlutter,
                l10n.profileAboutFocusArchitecture,
                l10n.profileAboutFocusBackend,
                l10n.profileAboutFocusGraphql,
                l10n.profileAboutFocusMaps,
                l10n.profileAboutFocusFirebase,
                l10n.profileAboutFocusRestfulApi,
                l10n.profileAboutFocusCleanArchitecture,
                l10n.profileAboutFocusProduct,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
