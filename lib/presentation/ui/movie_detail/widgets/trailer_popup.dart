part of '../movie_detail_page.dart';

class _MovieTrailerPopup extends StatefulWidget {
  const _MovieTrailerPopup({required this.title, required this.videoId});

  final String title;
  final String videoId;

  @override
  State<_MovieTrailerPopup> createState() => _MovieTrailerPopupState();
}

class _MovieTrailerPopupState extends State<_MovieTrailerPopup> {
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
                          Icons.close_rounded,
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
