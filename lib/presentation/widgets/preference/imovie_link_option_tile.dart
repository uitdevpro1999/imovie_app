import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';

class IMovieLinkOptionTile extends StatelessWidget {
  const IMovieLinkOptionTile({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Expanded(child: Text(label, style: AppTypography.body2Medium)),
          const Icon(
            FluentIcons.chevron_right_24_regular,
            size: 20,
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }
}
