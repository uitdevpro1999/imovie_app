part of '../home_page.dart';

class _HomeGenresSection extends StatelessWidget {
  const _HomeGenresSection({
    required this.title,
    required this.actionLabel,
    required this.state,
    required this.onShowMore,
  });

  final String title;
  final String actionLabel;
  final HomeState state;
  final VoidCallback onShowMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTypography.h3.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
            ),
            if (state.hasHiddenGenres)
              InkWell(
                onTap: onShowMore,
                borderRadius: BorderRadius.circular(999),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  child: Text(
                    actionLabel,
                    style: AppTypography.body2Medium.copyWith(
                      color: AppColors.yellow500,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final genre in state.visibleGenres)
              MovieGoGenreChip(
                label: genre.name,
                backgroundColor: AppColors.grayscale900,
                textColor: AppColors.white,
              ),
          ],
        ),
      ],
    );
  }
}
