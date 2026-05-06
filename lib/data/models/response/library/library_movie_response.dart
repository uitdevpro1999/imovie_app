import 'package:imovie_app/domain/entities/library/library_movie.dart';
import 'package:imovie_app/domain/entities/movie_detail/movie_detail.dart';
import 'package:imovie_app/domain/entities/movie_detail/movie_person.dart';
import 'package:imovie_app/domain/entities/movie_detail/movie_stream_episode.dart';
import 'package:imovie_app/domain/entities/movie_detail/movie_stream_server.dart';

class LibraryMovieResponse {
  const LibraryMovieResponse({
    required this.id,
    required this.userId,
    required this.movie,
    required this.createdAt,
  });

  factory LibraryMovieResponse.fromJson(Map<String, dynamic> json) {
    final movieJson = _asMap(json['movie']);
    return LibraryMovieResponse(
      id: json['id']?.toString() ?? '',
      userId: json['user_id']?.toString() ?? '',
      movie: movieJson.isEmpty
          ? MovieDetailStorageMapper.fromLibraryRow(json)
          : MovieDetailStorageMapper.fromJson(movieJson),
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
    );
  }

  final String id;
  final String userId;
  final MovieDetail movie;
  final DateTime? createdAt;

  LibraryMovie toEntity() {
    return LibraryMovie(
      id: id,
      userId: userId,
      movie: movie,
      createdAt: createdAt,
    );
  }
}

abstract final class MovieDetailStorageMapper {
  static Map<String, dynamic> toLibraryRow({
    required String userId,
    required MovieDetail movie,
  }) {
    return {
      'user_id': userId,
      'movie_id': movie.id,
      'slug': movie.slug,
      'title': movie.title,
      'original_title': movie.originalTitle,
      'poster_url': movie.posterUrl,
      'backdrop_url': movie.backdropUrl,
      'year': movie.year,
      'type': movie.type,
      'quality': movie.quality,
      'language': movie.language,
      'runtime': movie.runtime,
      'current_episode': movie.currentEpisode,
      'total_episodes': movie.totalEpisodes,
      'rating': movie.rating,
      'genres': movie.genres,
      'countries': movie.countries,
      'movie': toJson(movie),
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    };
  }

  static Map<String, dynamic> toJson(MovieDetail movie) {
    return {
      'id': movie.id,
      'imdb_id': movie.imdbId,
      'tmdb_id': movie.tmdbId,
      'tmdb_type': movie.tmdbType,
      'slug': movie.slug,
      'title': movie.title,
      'original_title': movie.originalTitle,
      'poster_url': movie.posterUrl,
      'backdrop_url': movie.backdropUrl,
      'description': movie.description,
      'status': movie.status,
      'type': movie.type,
      'quality': movie.quality,
      'language': movie.language,
      'runtime': movie.runtime,
      'current_episode': movie.currentEpisode,
      'total_episodes': movie.totalEpisodes,
      'year': movie.year,
      'rating': movie.rating,
      'rating_count': movie.ratingCount,
      'genres': movie.genres,
      'countries': movie.countries,
      'actors': movie.actors.map(_personToJson).toList(growable: false),
      'directors': movie.directors,
      'trailer_url': movie.trailerUrl,
      'servers': movie.servers.map(_serverToJson).toList(growable: false),
    };
  }

  static MovieDetail fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      id: json['id']?.toString() ?? '',
      imdbId: json['imdb_id']?.toString() ?? '',
      tmdbId: json['tmdb_id']?.toString() ?? '',
      tmdbType: json['tmdb_type']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      originalTitle: json['original_title']?.toString() ?? '',
      posterUrl: json['poster_url']?.toString() ?? '',
      backdropUrl: json['backdrop_url']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      quality: json['quality']?.toString() ?? '',
      language: json['language']?.toString() ?? '',
      runtime: json['runtime']?.toString() ?? '',
      currentEpisode: json['current_episode']?.toString() ?? '',
      totalEpisodes: json['total_episodes']?.toString() ?? '',
      year: (json['year'] as num?)?.toInt() ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      ratingCount: (json['rating_count'] as num?)?.toInt() ?? 0,
      genres: _asStringList(json['genres']),
      countries: _asStringList(json['countries']),
      actors: _asList(
        json['actors'],
      ).map(_personFromJson).toList(growable: false),
      directors: _asStringList(json['directors']),
      trailerUrl: json['trailer_url']?.toString() ?? '',
      servers: _asList(
        json['servers'],
      ).map(_serverFromJson).toList(growable: false),
    );
  }

  static MovieDetail fromLibraryRow(Map<String, dynamic> json) {
    return MovieDetail(
      id: json['movie_id']?.toString() ?? '',
      imdbId: json['imdb_id']?.toString() ?? '',
      tmdbId: json['tmdb_id']?.toString() ?? '',
      tmdbType: json['tmdb_type']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      originalTitle: json['original_title']?.toString() ?? '',
      posterUrl: json['poster_url']?.toString() ?? '',
      backdropUrl: json['backdrop_url']?.toString() ?? '',
      description: '',
      status: '',
      type: json['type']?.toString() ?? '',
      quality: json['quality']?.toString() ?? '',
      language: json['language']?.toString() ?? '',
      runtime: json['runtime']?.toString() ?? '',
      currentEpisode: json['current_episode']?.toString() ?? '',
      totalEpisodes: json['total_episodes']?.toString() ?? '',
      year: (json['year'] as num?)?.toInt() ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      ratingCount: 0,
      genres: _asStringList(json['genres']),
      countries: _asStringList(json['countries']),
      actors: const [],
      directors: const [],
      trailerUrl: '',
      servers: const [],
    );
  }

  static Map<String, dynamic> _personToJson(MoviePerson person) {
    return {
      'id': person.id,
      'name': person.name,
      'original_name': person.originalName,
      'character': person.character,
      'department': person.department,
      'profile_url': person.profileUrl,
    };
  }

  static MoviePerson _personFromJson(Map<String, dynamic> json) {
    return MoviePerson(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      originalName: json['original_name']?.toString() ?? '',
      character: json['character']?.toString() ?? '',
      department: json['department']?.toString() ?? '',
      profileUrl: json['profile_url']?.toString() ?? '',
    );
  }

  static Map<String, dynamic> _serverToJson(MovieStreamServer server) {
    return {
      'name': server.name,
      'is_ai': server.isAi,
      'episodes': server.episodes.map(_episodeToJson).toList(growable: false),
    };
  }

  static MovieStreamServer _serverFromJson(Map<String, dynamic> json) {
    return MovieStreamServer(
      name: json['name']?.toString() ?? '',
      isAi: json['is_ai'] as bool? ?? false,
      episodes: _asList(
        json['episodes'],
      ).map(_episodeFromJson).toList(growable: false),
    );
  }

  static Map<String, dynamic> _episodeToJson(MovieStreamEpisode episode) {
    return {
      'name': episode.name,
      'slug': episode.slug,
      'file_name': episode.fileName,
      'embed_url': episode.embedUrl,
      'm3u8_url': episode.m3u8Url,
    };
  }

  static MovieStreamEpisode _episodeFromJson(Map<String, dynamic> json) {
    return MovieStreamEpisode(
      name: json['name']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
      fileName: json['file_name']?.toString() ?? '',
      embedUrl: json['embed_url']?.toString() ?? '',
      m3u8Url: json['m3u8_url']?.toString() ?? '',
    );
  }
}

List<Map<String, dynamic>> _asList(Object? value) {
  return (value as List<dynamic>? ?? const [])
      .whereType<Map<String, dynamic>>()
      .toList(growable: false);
}

Map<String, dynamic> _asMap(Object? value) {
  return value is Map<String, dynamic> ? value : const {};
}

List<String> _asStringList(Object? value) {
  return (value as List<dynamic>? ?? const [])
      .map((item) => item.toString())
      .where((item) => item.trim().isNotEmpty)
      .toList(growable: false);
}
