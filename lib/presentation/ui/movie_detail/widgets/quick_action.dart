part of '../movie_detail_page.dart';

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    this.processing = false,
    this.onTap,
  });

  final IconData icon;
  // Kept for call-site readability and future semantics/tooltips.
  final String label;
  final bool processing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final child = processing
        ? const SizedBox.square(
            dimension: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.yellow500,
            ),
          )
        : Icon(icon, size: 30, color: AppColors.white);

    return SizedBox(
      height: 64,
      child: Material(
        color: AppColors.grayscale900,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: processing ? null : onTap,
          borderRadius: BorderRadius.circular(12),
          child: Tooltip(
            message: label,
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
