import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/presentation/widgets/imovie_preference_widgets.dart';

class SettingsSectionTitle extends StatelessWidget {
  const SettingsSectionTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2),
      child: Text(
        title,
        style: AppTypography.captionMedium.copyWith(
          color: AppColors.grayscale300,
          letterSpacing: 0,
        ),
      ),
    );
  }
}

class SettingsGroup extends StatelessWidget {
  const SettingsGroup({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.grayscale900,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.white.withValues(alpha: 0.06)),
        ),
        child: Column(children: children),
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
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
      backgroundColor: Colors.transparent,
      dividerColor: AppColors.white.withValues(alpha: 0.06),
      textColor: titleColor,
      iconColor: iconColor,
      valueColor: AppColors.grayscale300,
      chevronColor: AppColors.grayscale400,
      horizontalPadding: 14,
      verticalPadding: 14,
    );
  }
}

class SettingsAdFreeBadge extends StatelessWidget {
  const SettingsAdFreeBadge({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.yellow500,
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: AppColors.yellow500.withValues(alpha: 0.22),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            FluentIcons.prohibited_24_regular,
            size: 16,
            color: AppColors.textPrimary,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTypography.captionMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
