part of '../movie_watch_page.dart';

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.grayscale900,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        message,
        style: AppTypography.body2Regular.copyWith(
          color: AppColors.grayscale200,
        ),
      ),
    );
  }
}
