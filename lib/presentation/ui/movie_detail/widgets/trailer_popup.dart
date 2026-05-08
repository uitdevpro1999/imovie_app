part of '../movie_detail_page.dart';

class _MovieTrailerPopup extends StatelessWidget {
  const _MovieTrailerPopup({required this.title, required this.videoId});

  final String title;
  final String videoId;

  @override
  Widget build(BuildContext context) =>
      IMovieTrailerPopup(title: title, videoId: videoId);
}
