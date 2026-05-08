import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class IMovieTrailerPopup extends StatefulWidget {
  const IMovieTrailerPopup({
    super.key,
    required this.title,
    required this.videoId,
  });

  final String title;
  final String videoId;

  static String? videoIdFromUrl(String url) =>
      YoutubePlayer.convertUrlToId(url);

  @override
  State<IMovieTrailerPopup> createState() => _IMovieTrailerPopupState();
}

class _IMovieTrailerPopupState extends State<IMovieTrailerPopup> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: true,
        controlsVisibleAtStart: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final title = widget.title.trim().isEmpty
        ? l10n.movieDetailActionTrailer
        : widget.title;

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: AppColors.yellow500,
        progressColors: const ProgressBarColors(
          playedColor: AppColors.yellow500,
          handleColor: AppColors.yellow400,
          bufferedColor: AppColors.grayscale600,
          backgroundColor: AppColors.grayscale800,
        ),
      ),
      builder: (context, player) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          backgroundColor: AppColors.grayscale950,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          clipBehavior: Clip.antiAlias,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 8, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.h3.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          FluentIcons.dismiss_24_regular,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                player,
              ],
            ),
          ),
        );
      },
    );
  }
}
