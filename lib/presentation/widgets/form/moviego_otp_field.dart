import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/presentation/widgets/form/moviego_field_state.dart';

class MovieGoOtpField extends StatelessWidget {
  const MovieGoOtpField({
    super.key,
    required this.state,
    this.value,
    this.supportingText = 'Supporting text',
  });

  final MovieGoFieldState state;
  final String? value;
  final String supportingText;

  @override
  Widget build(BuildContext context) {
    final borderColor = switch (state) {
      MovieGoFieldState.defaultState => AppColors.surfaceStroke,
      MovieGoFieldState.typing => AppColors.yellow500,
      MovieGoFieldState.error => AppColors.danger,
      MovieGoFieldState.filled => AppColors.green500,
    };

    return SizedBox(
      width: 358,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Code', style: AppTypography.captionMedium),
          const SizedBox(height: 8),
          Row(
            children: List.generate(5, (index) {
              final char = value != null && index < value!.length
                  ? value![index]
                  : null;

              return Padding(
                padding: EdgeInsets.only(right: index == 4 ? 0 : 10),
                child: Container(
                  width: 56,
                  height: 56,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.fieldSurface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: borderColor, width: 1.5),
                  ),
                  child: Text(char ?? '', style: AppTypography.h4),
                ),
              );
            }),
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
