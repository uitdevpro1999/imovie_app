part of '../movie_detail_page.dart';

class _PillLabel extends StatelessWidget {
  const _PillLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.grayscale900,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Text(
        text,
        style: AppTypography.body2Medium.copyWith(color: AppColors.white),
      ),
    );
  }
}
