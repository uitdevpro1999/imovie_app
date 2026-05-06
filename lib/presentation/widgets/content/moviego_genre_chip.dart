import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';

class MovieGoGenreChip extends StatelessWidget {
  const MovieGoGenreChip({
    super.key,
    required this.label,
    this.backgroundColor = AppColors.surfaceAlt,
    this.textColor = AppColors.textPrimary,
  });

  final String label;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Text(
          label,
          style: AppTypography.body2Medium.copyWith(color: textColor),
        ),
      ),
    );
  }
}
