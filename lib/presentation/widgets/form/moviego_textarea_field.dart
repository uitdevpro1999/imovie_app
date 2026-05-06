import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/presentation/widgets/form/moviego_field_state.dart';

class MovieGoTextareaField extends StatelessWidget {
  const MovieGoTextareaField({
    super.key,
    required this.state,
    this.label = 'Description',
    this.supportingText = 'Supporting text',
  });

  final MovieGoFieldState state;
  final String label;
  final String supportingText;

  @override
  Widget build(BuildContext context) {
    final borderColor = switch (state) {
      MovieGoFieldState.defaultState => AppColors.surfaceStroke,
      MovieGoFieldState.typing => AppColors.yellow500,
      MovieGoFieldState.error => AppColors.danger,
      MovieGoFieldState.filled => AppColors.green500,
    };

    final content = switch (state) {
      MovieGoFieldState.defaultState => 'Placeholder',
      MovieGoFieldState.typing => 'Typing your message here...',
      MovieGoFieldState.error => 'Wrong value entered',
      MovieGoFieldState.filled => 'This field is complete',
    };

    return SizedBox(
      width: 358,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTypography.captionMedium),
          const SizedBox(height: 8),
          Container(
            height: 132,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.fieldSurface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: borderColor, width: 1.5),
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                content,
                style: AppTypography.body2Regular.copyWith(
                  color: state == MovieGoFieldState.defaultState
                      ? AppColors.textSecondary
                      : AppColors.textPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            supportingText,
            style: AppTypography.captionRegular1.copyWith(
              color: state == MovieGoFieldState.error
                  ? AppColors.danger
                  : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
