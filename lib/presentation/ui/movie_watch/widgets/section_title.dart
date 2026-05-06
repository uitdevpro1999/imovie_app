part of '../movie_watch_page.dart';

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTypography.h3.copyWith(color: AppColors.white),
    );
  }
}
