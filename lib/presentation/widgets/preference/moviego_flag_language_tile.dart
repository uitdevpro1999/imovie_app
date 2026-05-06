import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/presentation/widgets/moviego_remote_image.dart';

class MovieGoFlagLanguageTile extends StatelessWidget {
  const MovieGoFlagLanguageTile({
    super.key,
    required this.flagUrl,
    required this.label,
    this.selected = false,
  });

  final String flagUrl;
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: selected ? AppColors.yellow50 : AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: selected ? AppColors.yellow500 : AppColors.surfaceStroke,
        ),
      ),
      child: Row(
        children: [
          MovieGoRemoteImage(
            imageUrl: flagUrl,
            width: 28,
            height: 20,
            borderRadius: BorderRadius.circular(4),
            placeholderLabel: label,
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: AppTypography.body2Regular)),
          const SizedBox(width: 12),
          Icon(
            selected
                ? Icons.radio_button_checked_rounded
                : Icons.radio_button_off_rounded,
            color: selected ? AppColors.yellow500 : AppColors.grayscale300,
            size: 20,
          ),
        ],
      ),
    );
  }
}
