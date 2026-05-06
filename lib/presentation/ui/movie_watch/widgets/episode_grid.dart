part of '../movie_watch_page.dart';

class _EpisodeGrid extends StatelessWidget {
  const _EpisodeGrid({
    required this.server,
    required this.selectedEpisodeIndex,
    required this.onSelectEpisode,
  });

  final MovieStreamServer server;
  final int selectedEpisodeIndex;
  final ValueChanged<int> onSelectEpisode;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        for (var index = 0; index < server.episodes.length; index++)
          SizedBox(
            width: 72,
            child: _SelectablePill(
              label: server.episodes[index].displayName,
              isSelected: index == selectedEpisodeIndex,
              enabled: server.episodes[index].hasPlayableStream,
              onTap: () => onSelectEpisode(index),
            ),
          ),
      ],
    );
  }
}
