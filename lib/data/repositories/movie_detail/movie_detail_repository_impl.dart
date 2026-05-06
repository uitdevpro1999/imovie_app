import 'package:imovie_app/core/error/app_exception.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/data/datasources/movie_detail/movie_detail_remote_data_source.dart';
import 'package:imovie_app/domain/entities/movie_detail/movie_detail.dart';
import 'package:imovie_app/domain/entities/movie_detail/movie_person.dart';
import 'package:imovie_app/domain/entities/movie_detail/movie_stream_episode.dart';
import 'package:imovie_app/domain/entities/movie_detail/movie_stream_server.dart';
import 'package:imovie_app/domain/repositories/movie_detail_repository.dart';

class MovieDetailRepositoryImpl implements MovieDetailRepository {
  const MovieDetailRepositoryImpl({required this.remoteDataSource});

  final MovieDetailRemoteDataSource remoteDataSource;

  @override
  Future<Result<MovieDetail>> getMovieDetail(String slug) async {
    try {
      final response = await remoteDataSource.getMovieDetail(slug);
      final item = response.item;
      final actors = await _loadActors(slug, item.actors);

      return Success(
        MovieDetail(
          id: item.id,
          slug: item.slug,
          title: item.name,
          originalTitle: item.originName,
          posterUrl: _resolveMovieImage(response.imageBaseUrl, item.posterUrl),
          backdropUrl: _resolveMovieImage(response.imageBaseUrl, item.thumbUrl),
          description: _stripHtml(item.content),
          status: item.status,
          type: item.type,
          quality: item.quality,
          language: item.lang,
          runtime: item.time,
          currentEpisode: item.episodeCurrent,
          totalEpisodes: item.episodeTotal,
          year: item.year,
          rating: item.imdbVoteAverage > 0
              ? item.imdbVoteAverage
              : item.tmdbVoteAverage,
          ratingCount: item.imdbVoteCount > 0
              ? item.imdbVoteCount
              : item.tmdbVoteCount,
          genres: item.categories,
          countries: item.countries,
          actors: actors,
          directors: item.directors,
          trailerUrl: item.trailerUrl,
          servers: item.episodes
              .map(
                (server) => MovieStreamServer(
                  name: server.serverName,
                  isAi: server.isAi,
                  episodes: server.serverData
                      .map(
                        (episode) => MovieStreamEpisode(
                          name: episode.name,
                          slug: episode.slug,
                          fileName: episode.fileName,
                          embedUrl: episode.linkEmbed,
                          m3u8Url: episode.linkM3u8,
                        ),
                      )
                      .toList(growable: false),
                ),
              )
              .toList(growable: false),
        ),
      );
    } on AppException catch (error) {
      return FailureResult(error.failure);
    } catch (error) {
      return FailureResult(
        AppFailure.unknown(
          'Unexpected error while loading movie detail.',
          details: error.toString(),
        ),
      );
    }
  }

  Future<List<MoviePerson>> _loadActors(
    String slug,
    List<String> fallbackNames,
  ) async {
    try {
      final response = await remoteDataSource.getMoviePeoples(slug);
      final people = response.peoples
          .map(
            (person) => MoviePerson(
              id: person.id,
              name: person.name,
              originalName: person.originalName,
              character: person.character,
              department: person.department,
              profileUrl: _resolveProfileImage(
                response.profileImageBaseUrl,
                person.profilePath,
              ),
            ),
          )
          .toList(growable: false);

      if (people.isNotEmpty) {
        return people;
      }
    } catch (_) {
      // Detail data remains usable when the optional people endpoint fails.
    }

    return fallbackNames.map(_fallbackActor).toList(growable: false);
  }

  MoviePerson _fallbackActor(String name) {
    return MoviePerson(
      id: '',
      name: name,
      originalName: name,
      character: '',
      department: 'Acting',
      profileUrl:
          'https://ui-avatars.com/api/?name=${Uri.encodeComponent(name)}&background=2b2b2b&color=ffffff&size=128',
    );
  }

  String _resolveMovieImage(String imageBaseUrl, String fileName) {
    if (fileName.trim().isEmpty) {
      return '';
    }

    return Uri.parse(
      imageBaseUrl,
    ).resolve('uploads/movies/$fileName').toString();
  }

  String _resolveProfileImage(String imageBaseUrl, String profilePath) {
    final trimmedBaseUrl = imageBaseUrl.trim();
    final trimmedProfilePath = profilePath.trim();
    if (trimmedBaseUrl.isEmpty || trimmedProfilePath.isEmpty) {
      return '';
    }

    if (trimmedProfilePath.startsWith('http://') ||
        trimmedProfilePath.startsWith('https://')) {
      return trimmedProfilePath;
    }

    final baseUrl = trimmedBaseUrl.endsWith('/')
        ? trimmedBaseUrl
        : '$trimmedBaseUrl/';
    final relativePath = trimmedProfilePath.startsWith('/')
        ? trimmedProfilePath.substring(1)
        : trimmedProfilePath;

    return Uri.parse(baseUrl).resolve(relativePath).toString();
  }

  String _stripHtml(String input) {
    return input
        .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .trim();
  }
}
