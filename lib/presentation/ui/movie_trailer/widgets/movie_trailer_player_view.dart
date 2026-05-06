import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieTrailerPlayerView extends StatefulWidget {
  const MovieTrailerPlayerView({
    super.key,
    required this.title,
    required this.videoId,
  });

  final String title;
  final String videoId;

  @override
  State<MovieTrailerPlayerView> createState() => _MovieTrailerPlayerViewState();
}

class _MovieTrailerPlayerViewState extends State<MovieTrailerPlayerView> {
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
        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(14), child: player),
            if (widget.title.trim().isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                widget.title,
                style: AppTypography.h3.copyWith(color: AppColors.white),
              ),
            ],
          ],
        );
      },
    );
  }
}
