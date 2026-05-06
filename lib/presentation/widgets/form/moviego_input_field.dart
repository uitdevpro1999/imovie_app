import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/presentation/widgets/form/moviego_field_state.dart';

class MovieGoInputField extends StatelessWidget {
  const MovieGoInputField({
    super.key,
    required this.state,
    this.label = 'Label',
    this.placeholder = 'Placeholder',
    this.text,
    this.supportingText = 'Supporting text',
    this.controller,
    this.icon = Icons.mail_outline_rounded,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.onChanged,
    this.textColor = AppColors.textPrimary,
    this.placeholderColor = AppColors.textSecondary,
    this.labelColor = AppColors.textPrimary,
    this.fillColor = AppColors.fieldSurface,
    this.iconColor = AppColors.fieldIcon,
    this.borderRadius = 16,
    this.showSupportingText = true,
    this.width = 358,
  });

  final MovieGoFieldState state;
  final String label;
  final String placeholder;
  final String? text;
  final String supportingText;
  final TextEditingController? controller;
  final IconData icon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final Color textColor;
  final Color placeholderColor;
  final Color labelColor;
  final Color fillColor;
  final Color iconColor;
  final double borderRadius;
  final bool showSupportingText;
  final double width;

  @override
  Widget build(BuildContext context) {
    final palette = _MovieGoFieldPalette.fromState(state);

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTypography.captionMedium.copyWith(color: labelColor),
          ),
          const SizedBox(height: 8),
          Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: fillColor,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: palette.borderColor, width: 1.5),
            ),
            child: Row(
              children: [
                Icon(icon, color: iconColor, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: controller == null
                      ? Text(
                          text ?? placeholder,
                          style: AppTypography.body2Regular.copyWith(
                            color: text == null ? placeholderColor : textColor,
                          ),
                        )
                      : TextField(
                          controller: controller,
                          keyboardType: keyboardType,
                          textInputAction: textInputAction,
                          obscureText: obscureText,
                          onChanged: onChanged,
                          style: AppTypography.body2Regular.copyWith(
                            color: textColor,
                          ),
                          decoration: InputDecoration.collapsed(
                            hintText: placeholder,
                            hintStyle: AppTypography.body2Regular.copyWith(
                              color: placeholderColor,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
          if (showSupportingText) ...[
            const SizedBox(height: 8),
            Text(
              supportingText,
              style: AppTypography.captionRegular1.copyWith(
                color: palette.supportingColor,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MovieGoFieldPalette {
  const _MovieGoFieldPalette({
    required this.borderColor,
    required this.supportingColor,
  });

  factory _MovieGoFieldPalette.fromState(MovieGoFieldState state) {
    return switch (state) {
      MovieGoFieldState.defaultState => const _MovieGoFieldPalette(
        borderColor: AppColors.surfaceStroke,
        supportingColor: AppColors.textSecondary,
      ),
      MovieGoFieldState.typing => const _MovieGoFieldPalette(
        borderColor: AppColors.yellow500,
        supportingColor: AppColors.textSecondary,
      ),
      MovieGoFieldState.error => const _MovieGoFieldPalette(
        borderColor: AppColors.danger,
        supportingColor: AppColors.danger,
      ),
      MovieGoFieldState.filled => const _MovieGoFieldPalette(
        borderColor: AppColors.green500,
        supportingColor: AppColors.textSecondary,
      ),
    };
  }

  final Color borderColor;
  final Color supportingColor;
}
