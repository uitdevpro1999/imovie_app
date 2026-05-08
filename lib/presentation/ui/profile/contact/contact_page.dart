import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/gen/assets.gen.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/ui/profile/contact/widgets/contact_channel_card.dart';
import 'package:imovie_app/presentation/ui/profile/contact/widgets/contact_header_card.dart';
import 'package:imovie_app/presentation/widgets/imovie_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.grayscale950,
      appBar: IMovieAppBar(title: l10n.profileContactTitle),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
          children: [
            ContactHeaderCard(
              title: l10n.profileContactTitle,
              subtitle: l10n.profileContactSubtitle,
            ),
            const SizedBox(height: 20),
            ContactChannelCard(
              logo: Assets.images.contactZalo.image(width: 28, height: 28),
              title: l10n.profileContactZaloTitle,
              value: l10n.profileContactZaloSubtitle,
              accentColor: const Color(0xFF06B6D4),
              onOpen: () =>
                  _openUri(context, Uri.parse('https://zalo.me/84975182035')),
              onCopy: () =>
                  _copyValue(context, l10n.profileContactZaloSubtitle),
            ),
            const SizedBox(height: 12),
            ContactChannelCard(
              logo: Assets.images.contactFacebook.image(width: 28, height: 28),
              title: l10n.profileContactFacebookTitle,
              value: l10n.profileContactFacebookSubtitle,
              accentColor: const Color(0xFF4267B2),
              onOpen: () => _openUri(
                context,
                Uri.parse('https://www.facebook.com/nguyen.quoc.trung.373167'),
              ),
              onCopy: () =>
                  _copyValue(context, l10n.profileContactFacebookSubtitle),
            ),
            const SizedBox(height: 12),
            ContactChannelCard(
              logo: Assets.images.contactGmail.image(width: 28, height: 28),
              title: l10n.profileContactGmailTitle,
              value: l10n.profileContactGmailSubtitle,
              accentColor: const Color(0xFFEA4335),
              onOpen: () => _openUri(
                context,
                Uri(scheme: 'mailto', path: l10n.profileContactGmailSubtitle),
              ),
              onCopy: () =>
                  _copyValue(context, l10n.profileContactGmailSubtitle),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _copyValue(BuildContext context, String value) async {
    final l10n = AppLocalizations.of(context)!;
    await Clipboard.setData(ClipboardData(text: value));
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(l10n.profileContactCopied)));
  }

  Future<void> _openUri(BuildContext context, Uri uri) async {
    final l10n = AppLocalizations.of(context)!;
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (opened || !context.mounted) {
      return;
    }
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(l10n.profileContactOpenError)));
  }
}
