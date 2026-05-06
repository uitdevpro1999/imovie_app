import 'package:imovie_app/config/flavors/app_bootstrap.dart';
import 'package:imovie_app/core/error/app_exception.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/data/datasources/library/library_remote_data_source.dart';
import 'package:imovie_app/domain/entities/library/library_movie.dart';
import 'package:imovie_app/domain/entities/movie_detail/movie_detail.dart';
import 'package:imovie_app/domain/repositories/library_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LibraryRepositoryImpl implements LibraryRepository {
  const LibraryRepositoryImpl({
    required this.bootstrap,
    required this.remoteDataSource,
  });

  final AppBootstrap bootstrap;
  final LibraryRemoteDataSource remoteDataSource;

  @override
  Future<Result<List<LibraryMovie>>> getLibraryMovies() async {
    final readinessFailure = _readinessFailure();
    if (readinessFailure != null) {
      return FailureResult(readinessFailure);
    }

    try {
      final response = await remoteDataSource.getLibraryMovies();
      return Success(
        response.map((item) => item.toEntity()).toList(growable: false),
      );
    } on AppException catch (error) {
      return FailureResult(error.failure);
    } on AuthException catch (error) {
      return FailureResult(
        AppFailure.unauthorized(
          'Unable to load your movie library.',
          details: error.message,
        ),
      );
    } on PostgrestException catch (error) {
      return FailureResult(
        AppFailure.network(
          'Unable to load your movie library.',
          details: error.message,
        ),
      );
    } catch (error) {
      return FailureResult(
        AppFailure.unknown(
          'Unexpected error while loading your movie library.',
          details: error.toString(),
        ),
      );
    }
  }

  @override
  Future<Result<LibraryMovie>> addMovie(MovieDetail movie) async {
    final readinessFailure = _readinessFailure();
    if (readinessFailure != null) {
      return FailureResult(readinessFailure);
    }

    try {
      final response = await remoteDataSource.addMovie(movie);
      return Success(response.toEntity());
    } on AppException catch (error) {
      return FailureResult(error.failure);
    } on AuthException catch (error) {
      return FailureResult(
        AppFailure.unauthorized(
          'Unable to save this movie to your library.',
          details: error.message,
        ),
      );
    } on PostgrestException catch (error) {
      return FailureResult(
        AppFailure.network(
          'Unable to save this movie to your library.',
          details: error.message,
        ),
      );
    } catch (error) {
      return FailureResult(
        AppFailure.unknown(
          'Unexpected error while saving this movie to your library.',
          details: error.toString(),
        ),
      );
    }
  }

  @override
  Future<Result<void>> removeMovie(String id) async {
    final readinessFailure = _readinessFailure();
    if (readinessFailure != null) {
      return FailureResult(readinessFailure);
    }

    try {
      await remoteDataSource.removeMovie(id);
      return const Success(null);
    } on AppException catch (error) {
      return FailureResult(error.failure);
    } on AuthException catch (error) {
      return FailureResult(
        AppFailure.unauthorized(
          'Unable to remove this movie from your library.',
          details: error.message,
        ),
      );
    } on PostgrestException catch (error) {
      return FailureResult(
        AppFailure.network(
          'Unable to remove this movie from your library.',
          details: error.message,
        ),
      );
    } catch (error) {
      return FailureResult(
        AppFailure.unknown(
          'Unexpected error while removing this movie from your library.',
          details: error.toString(),
        ),
      );
    }
  }

  AppFailure? _readinessFailure() {
    if (!bootstrap.environment.isSupabaseConfigured) {
      return AppFailure.configuration(
        'Supabase is not configured. Provide SUPABASE_URL and SUPABASE_ANON_KEY via --dart-define.',
      );
    }

    return bootstrap.initializationFailure;
  }
}
