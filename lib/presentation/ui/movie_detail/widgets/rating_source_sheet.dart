part of '../movie_detail_page.dart';

enum _RatingSourceType { imdb, tmdb }

class _RatingSource {
  const _RatingSource({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final _RatingSourceType type;
  final String title;
  final String subtitle;
  final IconData icon;
}

class _RatingSourceSheet extends StatelessWidget {
  const _RatingSourceSheet({required this.sources});

  final List<_RatingSource> sources;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bottomPadding = MediaQuery.paddingOf(context).bottom + 16;
    final sheetHeight = 106.0 + (sources.length * 68) + bottomPadding;

    return SizedBox(
      height: sheetHeight,
      child: Column(
        children: [
          _RatingSourceSheetHeader(title: l10n.movieDetailRatingSourceTitle),
          Expanded(
            child: ListView.separated(
              primary: false,
              padding: EdgeInsets.fromLTRB(16, 8, 16, bottomPadding),
              itemBuilder: (context, index) {
                final source = sources[index];
                return _RatingSourceTile(source: source);
              },
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemCount: sources.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingSourceSheetHeader extends StatelessWidget {
  const _RatingSourceSheetHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.grayscale950,
        border: Border(bottom: BorderSide(color: AppColors.grayscale900)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44,
            height: 4,
            margin: const EdgeInsets.only(top: 12, bottom: 16),
            decoration: BoxDecoration(
              color: AppColors.grayscale600,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 8, 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: AppTypography.h3.copyWith(color: AppColors.white),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close_rounded, color: AppColors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingSourceTile extends StatelessWidget {
  const _RatingSourceTile({required this.source});

  final _RatingSource source;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => Navigator.of(context).pop(source),
      child: Ink(
        height: 68,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: AppColors.grayscale900,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.grayscale800),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.yellow950,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(source.icon, color: AppColors.yellow500),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    source.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.body1Regular.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    source.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.body2Regular.copyWith(
                      color: AppColors.grayscale400,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.grayscale500,
            ),
          ],
        ),
      ),
    );
  }
}
