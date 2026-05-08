import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';

class IMovieSettingsTile extends StatelessWidget {
  const IMovieSettingsTile({
    super.key,
    required this.label,
    required this.icon,
    this.value,
    this.showDivider = true,
    this.isDestructive = false,
    this.onTap,
    this.backgroundColor = AppColors.surface,
    this.dividerColor = AppColors.surfaceStroke,
    this.textColor,
    this.iconColor,
    this.valueColor = AppColors.textSecondary,
    this.chevronColor,
    this.horizontalPadding = 16,
    this.verticalPadding = 18,
  });

  final String label;
  final IconData icon;
  final String? value;
  final bool showDivider;
  final bool isDestructive;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color dividerColor;
  final Color? textColor;
  final Color? iconColor;
  final Color valueColor;
  final Color? chevronColor;
  final double horizontalPadding;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    final color =
        textColor ?? (isDestructive ? AppColors.danger : AppColors.textPrimary);
    final resolvedIconColor = iconColor ?? color;
    final resolvedChevronColor =
        chevronColor ??
        (isDestructive ? AppColors.danger : AppColors.textSecondary);

    return Material(
      color: backgroundColor,
      child: InkWell(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: showDivider
                ? Border(bottom: BorderSide(color: dividerColor))
                : null,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: Row(
              children: [
                Icon(icon, size: 20, color: resolvedIconColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: AppTypography.body2Medium.copyWith(color: color),
                  ),
                ),
                if (value != null) ...[
                  Text(
                    value!,
                    style: AppTypography.captionRegular1.copyWith(
                      color: valueColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                Icon(
                  FluentIcons.chevron_right_24_regular,
                  size: 20,
                  color: resolvedChevronColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
