import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';

class IMovieFaqItem extends StatelessWidget {
  const IMovieFaqItem({
    super.key,
    required this.question,
    this.answer,
    this.expanded = false,
  });

  final String question;
  final String? answer;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(question, style: AppTypography.body2Medium)),
              const SizedBox(width: 12),
              Icon(
                expanded ? Icons.remove_rounded : Icons.add_rounded,
                color: AppColors.textPrimary,
              ),
            ],
          ),
          if (expanded && answer != null) ...[
            const SizedBox(height: 12),
            Text(
              answer!,
              style: AppTypography.body2Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
