part of '../movie_watch_page.dart';

class _MoviePlayerCard extends StatelessWidget {
  const _MoviePlayerCard({required this.streamUrl});

  final String streamUrl;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (_isFlutterTest || _isWidgetTestRuntime) {
      return _PlayerShell(
        child: _PlayerPlaceholder(message: l10n.watchPlayerPreview),
      );
    }

    if (streamUrl.isEmpty) {
      return _PlayerShell(
        child: _PlayerPlaceholder(message: l10n.watchNoPlayableSource),
      );
    }

    return _PlayerShell(
      child: Stack(
        fit: StackFit.expand,
        children: [
          M3u8PlayerWidget(
            key: ValueKey(streamUrl),
            config: PlayerConfig(
              url: streamUrl,
              autoPlay: true,
              theme: const PlayerTheme(
                primaryColor: AppColors.white,
                backgroundColor: AppColors.black88,
                progressColor: AppColors.yellow500,
                bufferColor: AppColors.grayscale500,
                iconSize: 26,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayerShell extends StatelessWidget {
  const _PlayerShell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: math.max(220, MediaQuery.sizeOf(context).width * 9 / 16),
      decoration: BoxDecoration(
        color: AppColors.grayscale900,
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}

class _PlayerPlaceholder extends StatelessWidget {
  const _PlayerPlaceholder({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.grayscale800, AppColors.grayscale950],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              message,
              style: AppTypography.body2Regular.copyWith(
                color: AppColors.grayscale200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
