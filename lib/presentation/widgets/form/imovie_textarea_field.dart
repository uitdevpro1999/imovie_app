import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/presentation/widgets/form/imovie_field_state.dart';

class IMovieTextareaField extends StatelessWidget {
  const IMovieTextareaField({
    super.key,
    required this.state,
    this.label = 'Description',
    this.supportingText = 'Supporting text',
  });

  final IMovieFieldState state;
  final String label;
  final String supportingText;

  @override
  Widget build(BuildContext context) {
    final borderColor = switch (state) {
      IMovieFieldState.defaultState => AppColors.surfaceStroke,
      IMovieFieldState.typing => AppColors.yellow500,
      IMovieFieldState.error => AppColors.danger,
      IMovieFieldState.filled => AppColors.green500,
    };

    final content = switch (state) {
      IMovieFieldState.defaultState => 'Placeholder',
      IMovieFieldState.typing => 'Typing your message here...',
      IMovieFieldState.error => 'Wrong value entered',
      IMovieFieldState.filled => 'This field is complete',
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
                  color: state == IMovieFieldState.defaultState
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
              color: state == IMovieFieldState.error
                  ? AppColors.danger
                  : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
