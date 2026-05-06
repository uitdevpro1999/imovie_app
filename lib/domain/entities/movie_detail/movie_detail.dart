import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imovie_app/domain/entities/movie_detail/movie_person.dart';
import 'package:imovie_app/domain/entities/movie_detail/movie_stream_server.dart';

part 'movie_detail.freezed.dart';

@freezed
abstract class MovieDetail with _$MovieDetail {
  const MovieDetail._();

  const factory MovieDetail({
    required String id,
    @Default('') String imdbId,
    @Default('') String tmdbId,
    @Default('') String tmdbType,
    required String slug,
    required String title,
    required String originalTitle,
    required String posterUrl,
    required String backdropUrl,
    required String description,
    required String status,
    required String type,
    required String quality,
    required String language,
    required String runtime,
    required String currentEpisode,
    required String totalEpisodes,
    required int year,
    required double rating,
    required int ratingCount,
    required List<String> genres,
    required List<String> countries,
    required List<MoviePerson> actors,
    required List<String> directors,
    required String trailerUrl,
    required List<MovieStreamServer> servers,
  }) = _MovieDetail;

  String get yearLabel => year > 0 ? year.toString() : '';

  String get ageRatingLabel => '16+';

  bool get hasPlayableContent =>
      servers.any((server) => server.hasPlayableEpisodes);

  List<MovieStreamServer> get playableServers => servers
      .where((server) => server.hasPlayableEpisodes)
      .toList(growable: false);

  String get episodeSummary {
    if (currentEpisode.trim().isEmpty) {
      return totalEpisodes;
    }

    if (totalEpisodes.trim().isEmpty) {
      return currentEpisode;
    }

    return '$currentEpisode / $totalEpisodes';
  }
}
