part of '../movie_watch_page.dart';

const _episodeGroupSize = 40;
const _episodeGridSpacing = 12.0;
const _episodeChipHeight = 44.0;

class _EpisodeGrid extends StatefulWidget {
  const _EpisodeGrid({
    required this.server,
    required this.selectedEpisodeIndex,
    required this.onSelectEpisode,
  });

  final MovieStreamServer server;
  final int selectedEpisodeIndex;
  final ValueChanged<int> onSelectEpisode;

  @override
  State<_EpisodeGrid> createState() => _EpisodeGridState();
}

class _EpisodeGridState extends State<_EpisodeGrid> {
  late int _groupIndex;

  @override
  void initState() {
    super.initState();
    _groupIndex = _groupIndexForEpisode(widget.selectedEpisodeIndex);
  }

  @override
  void didUpdateWidget(covariant _EpisodeGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.server != widget.server ||
        oldWidget.selectedEpisodeIndex != widget.selectedEpisodeIndex) {
      _groupIndex = _groupIndexForEpisode(widget.selectedEpisodeIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final episodeCount = widget.server.episodes.length;
    final groupCount = (episodeCount / _episodeGroupSize).ceil();
    final activeGroupIndex = math.min(_groupIndex, math.max(0, groupCount - 1));
    final startIndex = activeGroupIndex * _episodeGroupSize;
    final endIndex = math.min(startIndex + _episodeGroupSize, episodeCount);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (groupCount > 1) ...[
          _EpisodeGroupSelector(
            episodeCount: episodeCount,
            selectedGroupIndex: activeGroupIndex,
            onSelectGroup: (index) => setState(() => _groupIndex = index),
          ),
          const SizedBox(height: 12),
        ],
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = _columnCountFor(constraints.maxWidth);
            final chipWidth =
                (constraints.maxWidth - ((columns - 1) * _episodeGridSpacing)) /
                columns;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: _episodeGridSpacing,
                mainAxisSpacing: _episodeGridSpacing,
                childAspectRatio: chipWidth / _episodeChipHeight,
              ),
              itemBuilder: (context, visibleIndex) {
                final episodeIndex = startIndex + visibleIndex;
                final episode = widget.server.episodes[episodeIndex];

                return _SelectablePill(
                  label: episode.displayName,
                  isSelected: episodeIndex == widget.selectedEpisodeIndex,
                  enabled: episode.hasPlayableStream,
                  onTap: () => widget.onSelectEpisode(episodeIndex),
                );
              },
              itemCount: endIndex - startIndex,
            );
          },
        ),
      ],
    );
  }

  int _columnCountFor(double width) {
    if (width <= 0) {
      return 3;
    }

    return (width / 84).floor().clamp(3, 6);
  }

  int _groupIndexForEpisode(int episodeIndex) {
    if (episodeIndex < 0) {
      return 0;
    }

    return episodeIndex ~/ _episodeGroupSize;
  }
}

class _EpisodeGroupSelector extends StatelessWidget {
  const _EpisodeGroupSelector({
    required this.episodeCount,
    required this.selectedGroupIndex,
    required this.onSelectGroup,
  });

  final int episodeCount;
  final int selectedGroupIndex;
  final ValueChanged<int> onSelectGroup;

  @override
  Widget build(BuildContext context) {
    final groupCount = (episodeCount / _episodeGroupSize).ceil();
    final l10n = AppLocalizations.of(context)!;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.grayscale900,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.grayscale800),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: selectedGroupIndex,
          isExpanded: true,
          dropdownColor: AppColors.grayscale900,
          borderRadius: BorderRadius.circular(14),
          menuMaxHeight: 320,
          icon: const Icon(
            FluentIcons.chevron_down_24_regular,
            color: AppColors.grayscale300,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          style: AppTypography.body2Medium.copyWith(color: AppColors.white),
          selectedItemBuilder: (context) {
            return [
              for (var index = 0; index < groupCount; index++)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${l10n.watchEpisodeSection} ${_labelForGroup(index)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.body2Medium.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
            ];
          },
          items: [
            for (var index = 0; index < groupCount; index++)
              DropdownMenuItem<int>(
                value: index,
                child: Text(
                  '${l10n.watchEpisodeSection} ${_labelForGroup(index)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.body2Medium.copyWith(
                    color: index == selectedGroupIndex
                        ? AppColors.yellow500
                        : AppColors.white,
                  ),
                ),
              ),
          ],
          onChanged: (value) {
            if (value == null) {
              return;
            }
            onSelectGroup(value);
          },
        ),
      ),
    );
  }

  String _labelForGroup(int groupIndex) {
    final start = (groupIndex * _episodeGroupSize) + 1;
    final end = math.min(start + _episodeGroupSize - 1, episodeCount);
    return '$start-$end';
  }
}
