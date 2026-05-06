part of '../movie_watch_page.dart';

class _InfoSummary extends StatelessWidget {
  const _InfoSummary({required this.state});

  final MovieWatchState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final rows = [
      (l10n.movieDetailInfoOriginalTitle, state.originalTitleValue),
      (l10n.movieDetailInfoRuntime, state.runtimeValue),
      (l10n.movieDetailInfoQuality, state.qualityValue),
      (l10n.movieDetailInfoLanguage, state.languageValue),
      (l10n.watchEpisodeSection, state.selectedEpisodeName),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.grayscale900,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          for (final row in rows) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    row.$1,
                    style: AppTypography.body2Regular.copyWith(
                      color: AppColors.grayscale300,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    row.$2,
                    style: AppTypography.body2Regular.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
            if (row != rows.last) const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}
