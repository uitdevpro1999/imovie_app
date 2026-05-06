part of '../movie_detail_page.dart';

class _SquareActionButton extends StatelessWidget {
  const _SquareActionButton({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.grayscale900,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: AppColors.white),
    );
  }
}
