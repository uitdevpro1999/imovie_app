part of '../movie_watch_page.dart';

class _MovieWatchSuccessView extends StatelessWidget {
  const _MovieWatchSuccessView({
    required this.state,
    required this.onSelectServer,
    required this.onSelectEpisode,
  });

  final MovieWatchState state;
  final ValueChanged<int> onSelectServer;
  final ValueChanged<int> onSelectEpisode;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final detail = state.detail!;
    final selectedServer = state.selectedServer;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MoviePlayerCard(streamUrl: state.selectedStreamUrl),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detail.title,
                  style: AppTypography.display.copyWith(color: AppColors.white),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    _MetaPill(label: detail.quality),
                    _MetaPill(label: detail.language),
                    if (selectedServer != null)
                      _MetaPill(
                        label: l10n.watchServerValue(selectedServer.name),
                        isHighlighted: true,
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  detail.description,
                  style: AppTypography.body1Regular.copyWith(
                    color: AppColors.grayscale300,
                  ),
                ),
                const SizedBox(height: 24),
                _SectionTitle(title: l10n.watchServerSection),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    for (var index = 0; index < detail.servers.length; index++)
                      _SelectablePill(
                        label: detail.servers[index].name,
                        isSelected: index == state.selectedServerIndex,
                        enabled: detail.servers[index].episodes.isNotEmpty,
                        onTap: () => onSelectServer(index),
                      ),
                  ],
                ),
                const SizedBox(height: 24),
                _SectionTitle(title: l10n.watchEpisodeSection),
                const SizedBox(height: 12),
                if (!state.hasSelectedServerEpisodes)
                  _InfoCard(message: l10n.watchNoEpisodes)
                else
                  _EpisodeGrid(
                    server: selectedServer!,
                    selectedEpisodeIndex: state.selectedEpisodeIndex,
                    onSelectEpisode: onSelectEpisode,
                  ),
                const SizedBox(height: 24),
                _SectionTitle(title: l10n.movieDetailInformation),
                const SizedBox(height: 12),
                _InfoSummary(state: state),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
