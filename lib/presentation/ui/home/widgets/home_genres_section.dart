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
            Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                color: AppColors.red400,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            const SizedBox(width: 10),
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
        SizedBox(
          height: 44,
          child: ListView.separated(
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final genre = state.visibleGenres[index];
              return InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () => context.router.push(
                  GenreMoviesRoute(slug: genre.slug, title: genre.name),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    color: AppColors.grayscale900,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.grayscale800),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Center(
                    child: Text(
                      genre.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.body2Medium.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemCount: state.visibleGenres.length,
          ),
        ),
      ],
    );
  }
}
