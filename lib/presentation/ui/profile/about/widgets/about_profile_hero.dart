import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';

class AboutProfileHero extends StatelessWidget {
  const AboutProfileHero({
    super.key,
    required this.sectionTitle,
    required this.subtitle,
    required this.name,
    required this.handleLabel,
    required this.handleValue,
    required this.role,
    required this.companyLabel,
    required this.companyValue,
    required this.avatarAssetPath,
  });

  final String sectionTitle;
  final String subtitle;
  final String name;
  final String handleLabel;
  final String handleValue;
  final String role;
  final String companyLabel;
  final String companyValue;
  final String avatarAssetPath;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [AppColors.grayscale900, AppColors.yellow950],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.07)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sectionTitle,
              style: AppTypography.captionMedium.copyWith(
                color: AppColors.yellow300,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: AppTypography.body2Regular.copyWith(
                color: AppColors.grayscale300,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 112,
                  height: 112,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.yellow500.withValues(alpha: 0.42),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.3),
                        blurRadius: 24,
                        offset: const Offset(0, 14),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(avatarAssetPath, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: AppTypography.h1.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        role,
                        style: AppTypography.body2Medium.copyWith(
                          color: AppColors.yellow300,
                        ),
                      ),
                      const SizedBox(height: 14),
                      _AboutInfoRow(
                        icon: FluentIcons.person_accounts_24_regular,
                        label: handleLabel,
                        value: handleValue,
                      ),
                      const SizedBox(height: 10),
                      _AboutInfoRow(
                        icon: FluentIcons.building_24_regular,
                        label: companyLabel,
                        value: companyValue,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutInfoRow extends StatelessWidget {
  const _AboutInfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppColors.grayscale300),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTypography.captionRegular1.copyWith(
                  color: AppColors.grayscale400,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: AppTypography.body2Medium.copyWith(
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
