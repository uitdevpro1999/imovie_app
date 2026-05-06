part of '../movie_watch_page.dart';

class _MetaPill extends StatelessWidget {
  const _MetaPill({required this.label, this.isHighlighted = false});

  final String label;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isHighlighted ? AppColors.yellow950 : AppColors.grayscale900,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: isHighlighted ? AppColors.yellow700 : AppColors.grayscale800,
        ),
      ),
      child: Text(
        label,
        style: AppTypography.body2Medium.copyWith(
          color: isHighlighted ? AppColors.yellow300 : AppColors.white,
        ),
      ),
    );
  }
}
