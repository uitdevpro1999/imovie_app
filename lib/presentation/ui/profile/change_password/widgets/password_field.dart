import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';

class ChangePasswordField extends StatelessWidget {
  const ChangePasswordField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.obscureText,
    required this.onToggleVisibility,
  });

  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback onToggleVisibility;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.body2Medium.copyWith(color: AppColors.white),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          textInputAction: TextInputAction.next,
          style: AppTypography.body2Regular.copyWith(color: AppColors.white),
          cursorColor: AppColors.yellow500,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTypography.body2Regular.copyWith(
              color: AppColors.grayscale300,
            ),
            suffixIcon: IconButton(
              onPressed: onToggleVisibility,
              icon: Icon(
                obscureText
                    ? FluentIcons.eye_off_24_regular
                    : FluentIcons.eye_24_regular,
                color: AppColors.white,
              ),
            ),
            filled: true,
            fillColor: AppColors.grayscale900,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.yellow500),
            ),
          ),
        ),
      ],
    );
  }
}
