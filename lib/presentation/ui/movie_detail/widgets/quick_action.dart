part of '../movie_detail_page.dart';

class _QuickAction extends StatelessWidget {
  const _QuickAction({required this.icon, required this.label});

  final IconData icon;
  // Kept for call-site readability and future semantics/tooltips.
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.grayscale900,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Tooltip(
          message: label,
          child: Center(child: Icon(icon, size: 30, color: AppColors.white)),
        ),
      ),
    );
  }
}
