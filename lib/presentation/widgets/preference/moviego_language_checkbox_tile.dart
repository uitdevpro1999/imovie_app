import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';

class MovieGoLanguageCheckboxTile extends StatelessWidget {
  const MovieGoLanguageCheckboxTile({
    super.key,
    required this.label,
    this.selected = false,
  });

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: selected ? AppColors.yellow500 : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: selected ? AppColors.yellow500 : AppColors.grayscale300,
              ),
            ),
            child: selected
                ? const Icon(
                    Icons.check_rounded,
                    size: 16,
                    color: AppColors.white,
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Text(label, style: AppTypography.body2Regular),
        ],
      ),
    );
  }
}
