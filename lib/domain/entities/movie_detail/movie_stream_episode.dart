import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_stream_episode.freezed.dart';

@freezed
abstract class MovieStreamEpisode with _$MovieStreamEpisode {
  const MovieStreamEpisode._();

  const factory MovieStreamEpisode({
    required String name,
    required String slug,
    required String fileName,
    required String embedUrl,
    required String m3u8Url,
  }) = _MovieStreamEpisode;

  bool get hasPlayableStream =>
      embedUrl.trim().isNotEmpty || m3u8Url.trim().isNotEmpty;

  String get displayName {
    if (name.trim().isNotEmpty) {
      return name.trim();
    }
    if (slug.trim().isNotEmpty) {
      return slug.trim();
    }
    if (fileName.trim().isNotEmpty) {
      return fileName.trim();
    }
    return 'Episode';
  }
}
