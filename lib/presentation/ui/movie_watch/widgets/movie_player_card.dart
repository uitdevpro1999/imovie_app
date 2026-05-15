part of '../movie_watch_page.dart';

enum _PlaybackMode { embed, m3u8 }

class _MoviePlayerCard extends StatefulWidget {
  const _MoviePlayerCard({required this.embedUrl, required this.m3u8Url});

  final String embedUrl;
  final String m3u8Url;

  @override
  State<_MoviePlayerCard> createState() => _MoviePlayerCardState();
}

class _MoviePlayerCardState extends State<_MoviePlayerCard> {
  late _PlaybackMode _mode;

  @override
  void initState() {
    super.initState();
    _mode = _initialMode;
  }

  @override
  void didUpdateWidget(covariant _MoviePlayerCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.embedUrl != widget.embedUrl ||
        oldWidget.m3u8Url != widget.m3u8Url) {
      _mode = _initialMode;
    }
  }

  _PlaybackMode get _initialMode {
    return _canUseEmbed ? _PlaybackMode.embed : _PlaybackMode.m3u8;
  }

  bool get _canUseEmbed => _isPlayableNetworkUrl(widget.embedUrl);

  bool get _canUseM3u8 => _isPlayableNetworkUrl(widget.m3u8Url);

  bool get _canFallbackToM3u8 => _canUseM3u8 && _mode != _PlaybackMode.m3u8;

  bool get _canSwitchPlaybackSource => _canUseEmbed && _canUseM3u8;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (_isFlutterTest || _isWidgetTestRuntime) {
      return _PlayerShell(
        child: _PlayerPlaceholder(message: l10n.watchPlayerPreview),
      );
    }

    if (!_canUseEmbed && !_canUseM3u8) {
      return _PlayerShell(
        child: _PlayerPlaceholder(message: l10n.watchNoPlayableSource),
      );
    }

    if (_mode == _PlaybackMode.embed && _canUseEmbed) {
      return _PlayerShell(
        child: _withPlaybackSourceSwitch(
          child: _EmbedPlayer(
            key: ValueKey(widget.embedUrl),
            embedUrl: widget.embedUrl,
            onLoadError: _fallbackToM3u8,
          ),
        ),
      );
    }

    if (!_canUseM3u8) {
      return _PlayerShell(
        child: _PlayerPlaceholder(message: l10n.watchPlayerError),
      );
    }

    return _PlayerShell(
      child: _withPlaybackSourceSwitch(
        child: _M3u8Player(streamUrl: widget.m3u8Url),
      ),
    );
  }

  void _fallbackToM3u8() {
    if (!mounted || !_canFallbackToM3u8) {
      return;
    }
    setState(() => _mode = _PlaybackMode.m3u8);
  }

  void _switchPlaybackSource() {
    if (!_canSwitchPlaybackSource) {
      return;
    }
    setState(() {
      _mode = _mode == _PlaybackMode.embed
          ? _PlaybackMode.m3u8
          : _PlaybackMode.embed;
    });
  }

  Widget _withPlaybackSourceSwitch({required Widget child}) {
    if (!_canSwitchPlaybackSource) {
      return child;
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        child,
        Positioned(
          top: 8,
          right: 8,
          child: _PlaybackSourceSwitchButton(
            currentMode: _mode,
            onPressed: _switchPlaybackSource,
          ),
        ),
      ],
    );
  }

  bool _isPlayableNetworkUrl(String value) {
    final uri = Uri.tryParse(value.trim());
    return uri != null && (uri.isScheme('http') || uri.isScheme('https'));
  }
}

class _PlaybackSourceSwitchButton extends StatelessWidget {
  const _PlaybackSourceSwitchButton({
    required this.currentMode,
    required this.onPressed,
  });

  final _PlaybackMode currentMode;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final targetMode = currentMode == _PlaybackMode.embed
        ? _PlaybackMode.m3u8
        : _PlaybackMode.embed;
    final label = targetMode == _PlaybackMode.embed
        ? l10n.watchPlaybackSourceEmbed
        : l10n.watchPlaybackSourceM3u8;
    final tooltip = targetMode == _PlaybackMode.embed
        ? l10n.watchSwitchToEmbed
        : l10n.watchSwitchToM3u8;

    return Tooltip(
      message: tooltip,
      child: Material(
        color: AppColors.black88,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: onPressed,
          child: Container(
            height: 28,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0x1FFFFFFF)),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  FluentIcons.arrow_swap_20_regular,
                  color: AppColors.white,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  label,
                  style: AppTypography.captionMedium.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmbedPlayer extends StatefulWidget {
  const _EmbedPlayer({
    super.key,
    required this.embedUrl,
    required this.onLoadError,
  });

  final String embedUrl;
  final VoidCallback onLoadError;

  @override
  State<_EmbedPlayer> createState() => _EmbedPlayerState();
}

class _EmbedPlayerState extends State<_EmbedPlayer> {
  bool _isFullscreen = false;

  @override
  void dispose() {
    if (_isFullscreen) {
      _exitFullscreenOrientation();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(widget.embedUrl)),
      initialSettings: InAppWebViewSettings(
        allowsInlineMediaPlayback: true,
        allowsPictureInPictureMediaPlayback: true,
        iframeAllowFullscreen: true,
        isElementFullscreenEnabled: true,
        javaScriptCanOpenWindowsAutomatically: true,
        javaScriptEnabled: true,
        mediaPlaybackRequiresUserGesture: false,
        transparentBackground: false,
        useHybridComposition: true,
      ),
      onReceivedError: (controller, request, error) {
        if (request.isForMainFrame != false) {
          widget.onLoadError();
        }
      },
      onReceivedHttpError: (controller, request, errorResponse) {
        final statusCode = errorResponse.statusCode ?? 0;
        if (request.isForMainFrame != false && statusCode >= 400) {
          widget.onLoadError();
        }
      },
      onEnterFullscreen: (_) => _enterFullscreenOrientation(),
      onExitFullscreen: (_) => _exitFullscreenOrientation(),
    );
  }

  Future<void> _enterFullscreenOrientation() async {
    _isFullscreen = true;
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    await SystemChrome.setPreferredOrientations(const [
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  Future<void> _exitFullscreenOrientation() async {
    _isFullscreen = false;
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    await SystemChrome.setPreferredOrientations(const [
      DeviceOrientation.portraitUp,
    ]);
  }
}

class _M3u8Player extends StatelessWidget {
  const _M3u8Player({required this.streamUrl});

  final String streamUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}

class _PlayerShell extends StatelessWidget {
  const _PlayerShell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: math.max(220, MediaQuery.sizeOf(context).width * 9 / 16),
      child: ClipRect(
        child: ColoredBox(color: AppColors.grayscale900, child: child),
      ),
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
