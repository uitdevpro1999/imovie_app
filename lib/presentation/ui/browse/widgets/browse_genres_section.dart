part of '../browse_page.dart';

class _BrowseGenresSection extends StatelessWidget {
  const _BrowseGenresSection({required this.state});

  final BrowseState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (state.visibleGenres.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IMovieSectionHeader(
          title: l10n.movieDetailGenres,
          actionLabel: state.hasHiddenGenres ? l10n.homeSectionViewMore : '',
          titleColor: AppColors.white,
          actionColor: AppColors.yellow500,
          onActionTap: state.hasHiddenGenres
              ? () => context.router.push(GenresRoute(genres: state.genres))
              : null,
        ),
        const SizedBox(height: 16),
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.grayscale900,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.white.withValues(alpha: 0.06)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final genre in state.visibleGenres)
                  InkWell(
                    borderRadius: BorderRadius.circular(999),
                    onTap: () => context.router.push(
                      GenreMoviesRoute(slug: genre.slug, title: genre.name),
                    ),
                    child: IMovieGenreChip(
                      label: genre.name,
                      backgroundColor: AppColors.black.withValues(alpha: 0.22),
                      textColor: AppColors.white,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
