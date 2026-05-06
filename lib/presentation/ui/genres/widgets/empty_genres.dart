part of '../genres_page.dart';

class _EmptyGenres extends StatelessWidget {
  const _EmptyGenres();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppLocalizations.of(context)!.movieDetailGenres,
        style: AppTypography.body1Regular.copyWith(
          color: AppColors.grayscale300,
        ),
      ),
    );
  }
}
