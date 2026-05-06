import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';

class AuthCheckboxRow extends StatelessWidget {
  const AuthCheckboxRow({
    super.key,
    required this.label,
    required this.isChecked,
    required this.onTap,
  });

  final String label;
  final bool isChecked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: isChecked ? AppColors.yellow500 : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: isChecked ? AppColors.yellow500 : AppColors.grayscale500,
              ),
            ),
            child: isChecked
                ? const Icon(
                    Icons.check_rounded,
                    size: 18,
                    color: AppColors.grayscale950,
                  )
                : null,
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              label,
              style: AppTypography.body2Regular.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
