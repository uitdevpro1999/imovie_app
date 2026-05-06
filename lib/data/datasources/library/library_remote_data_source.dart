import 'package:imovie_app/core/error/app_exception.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/logger/app_logger.dart';
import 'package:imovie_app/core/services/supabase_data_service.dart';
import 'package:imovie_app/data/models/response/library/library_movie_response.dart';
import 'package:imovie_app/domain/entities/movie_detail/movie_detail.dart';

abstract interface class LibraryRemoteDataSource {
  Future<List<LibraryMovieResponse>> getLibraryMovies();

  Future<LibraryMovieResponse> addMovie(MovieDetail movie);

  Future<void> removeMovie(String id);
}

class SupabaseLibraryRemoteDataSource implements LibraryRemoteDataSource {
  const SupabaseLibraryRemoteDataSource({required this.dataService});

  static const _table = 'library_movies';

  final SupabaseDataService dataService;

  @override
  Future<List<LibraryMovieResponse>> getLibraryMovies() async {
    final user = _currentUser();
    AppLogger.info(
      'Loading library movies for ${AppLogger.shortId(user.id)}.',
      name: 'Supabase.Library',
    );

    final rows = await dataService.selectList(
      table: _table,
      equals: {'user_id': user.id},
      orderBy: 'created_at',
      ascending: false,
    );

    AppLogger.info(
      'Loaded ${rows.length} library movies for ${AppLogger.shortId(user.id)}.',
      name: 'Supabase.Library',
    );
    return rows
        .whereType<Map<String, dynamic>>()
        .map(LibraryMovieResponse.fromJson)
        .toList(growable: false);
  }

  @override
  Future<LibraryMovieResponse> addMovie(MovieDetail movie) async {
    final user = _currentUser();
    AppLogger.info(
      'Adding movie ${movie.slug} to library for ${AppLogger.shortId(user.id)}.',
      name: 'Supabase.Library',
    );

    final json = await dataService.upsertAndSelectSingle(
      table: _table,
      values: MovieDetailStorageMapper.toLibraryRow(
        userId: user.id,
        movie: movie,
      ),
      onConflict: 'user_id,slug',
    );

    AppLogger.info(
      'Movie ${movie.slug} saved to library for ${AppLogger.shortId(user.id)}.',
      name: 'Supabase.Library',
    );
    return LibraryMovieResponse.fromJson(json);
  }

  @override
  Future<void> removeMovie(String id) async {
    final user = _currentUser();
    AppLogger.info(
      'Removing library movie $id for ${AppLogger.shortId(user.id)}.',
      name: 'Supabase.Library',
    );

    await dataService.delete(
      table: _table,
      equals: {'id': id, 'user_id': user.id},
    );

    AppLogger.info(
      'Removed library movie $id for ${AppLogger.shortId(user.id)}.',
      name: 'Supabase.Library',
    );
  }

  SupabaseDataUser _currentUser() {
    return dataService.requireCurrentUser(
      unauthorizedMessage: 'Sign in before using your movie library.',
      logName: 'Supabase.Library',
      blockedLogMessage:
          'Library request blocked because no Supabase user is signed in.',
    );
  }
}

class UnconfiguredLibraryRemoteDataSource implements LibraryRemoteDataSource {
  const UnconfiguredLibraryRemoteDataSource();

  @override
  Future<List<LibraryMovieResponse>> getLibraryMovies() async {
    throw const AppException(_configurationFailure);
  }

  @override
  Future<LibraryMovieResponse> addMovie(MovieDetail movie) async {
    throw const AppException(_configurationFailure);
  }

  @override
  Future<void> removeMovie(String id) async {
    throw const AppException(_configurationFailure);
  }
}

const _configurationFailure = AppFailure(
  type: FailureType.configuration,
  message:
      'Supabase is not configured. Provide SUPABASE_URL and SUPABASE_ANON_KEY via --dart-define.',
);
