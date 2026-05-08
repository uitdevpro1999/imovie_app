import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/widgets/imovie_buttons.dart';

class SettingsErrorView extends StatelessWidget {
  const SettingsErrorView({
    super.key,
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

class SettingsProcessingOverlay extends StatelessWidget {
  const SettingsProcessingOverlay({super.key});

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

class SignedOutSettingsView extends StatelessWidget {
  const SignedOutSettingsView({
    super.key,
    required this.l10n,
    required this.onSignInTap,
  });

  final AppLocalizations l10n;
  final VoidCallback onSignInTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.grayscale900,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.white.withValues(alpha: 0.07)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: AppColors.yellow500.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    FluentIcons.person_24_filled,
                    color: AppColors.yellow500,
                    size: 38,
                  ),
                ),
                const SizedBox(height: 18),
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
        ),
      ),
    );
  }
}
