import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imovie_app/domain/entities/movie_detail/movie_stream_episode.dart';

part 'movie_stream_server.freezed.dart';

@freezed
abstract class MovieStreamServer with _$MovieStreamServer {
  const MovieStreamServer._();

  const factory MovieStreamServer({
    required String name,
    required bool isAi,
    required List<MovieStreamEpisode> episodes,
  }) = _MovieStreamServer;

  bool get hasPlayableEpisodes =>
      episodes.any((episode) => episode.hasPlayableStream);

  List<MovieStreamEpisode> get playableEpisodes => episodes
      .where((episode) => episode.hasPlayableStream)
      .toList(growable: false);
}
