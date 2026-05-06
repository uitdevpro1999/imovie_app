part of '../movie_watch_page.dart';

class _SelectablePill extends StatelessWidget {
  const _SelectablePill({
    required this.label,
    required this.isSelected,
    required this.enabled,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.45,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.yellow500 : AppColors.grayscale900,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.yellow500 : AppColors.grayscale800,
            ),
          ),
          child: Text(
            label,
            style: AppTypography.body2Medium.copyWith(
              color: isSelected ? AppColors.white : AppColors.grayscale200,
            ),
          ),
        ),
      ),
    );
  }
}
