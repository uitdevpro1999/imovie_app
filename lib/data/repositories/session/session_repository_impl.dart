import 'package:imovie_app/config/flavors/app_bootstrap.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/logger/app_logger.dart';
import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/data/datasources/session/session_remote_data_source.dart';
import 'package:imovie_app/domain/entities/session/app_session.dart';
import 'package:imovie_app/domain/repositories/session_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SessionRepositoryImpl implements SessionRepository {
  const SessionRepositoryImpl({
    required this.bootstrap,
    required this.remoteDataSource,
  });

  final AppBootstrap bootstrap;
  final SessionRemoteDataSource remoteDataSource;

  @override
  Future<Result<AppSession>> getCurrentSession() async {
    if (!bootstrap.environment.isSupabaseConfigured) {
      return FailureResult(
        AppFailure.configuration(
          'Supabase is not configured. Provide SUPABASE_URL and SUPABASE_ANON_KEY via --dart-define.',
        ),
      );
    }

    final initializationFailure = bootstrap.initializationFailure;
    if (initializationFailure != null) {
      return FailureResult(initializationFailure);
    }

    try {
      final session = await remoteDataSource.getCurrentSession();
      final user = session?.user;

      if (user == null) {
        return Success(AppSession.guest());
      }

      return Success(
        AppSession.authenticated(userId: user.id, email: user.email),
      );
    } on AuthException catch (error) {
      AppLogger.error(
        'Read current Supabase session failed: ${error.message}',
        name: 'Supabase.Session',
        error: error,
      );
      return FailureResult(
        AppFailure.unauthorized(
          'Unable to read the current Supabase session.',
          details: error.message,
        ),
      );
    } catch (error, stackTrace) {
      AppLogger.error(
        'Read current Supabase session failed unexpectedly.',
        name: 'Supabase.Session',
        error: error,
        stackTrace: stackTrace,
      );
      return FailureResult(
        AppFailure.unknown(
          'Unexpected error while reading the current session.',
          details: error.toString(),
        ),
      );
    }
  }

  @override
  Future<Result<AppSession>> signInWithPassword({
    required String email,
    required String password,
  }) async {
    return _runAuthRequest(
      request: () =>
          remoteDataSource.signInWithPassword(email: email, password: password),
      authMessage: 'Unable to sign in with the provided credentials.',
      unknownMessage: 'Unexpected error while signing in.',
    );
  }

  @override
  Future<Result<AppSession>> signUp({
    required String email,
    required String password,
  }) async {
    return _runAuthRequest(
      request: () => remoteDataSource.signUp(email: email, password: password),
      authMessage: 'Unable to create this account.',
      unknownMessage: 'Unexpected error while signing up.',
    );
  }

  @override
  Future<Result<void>> resetPasswordForEmail({required String email}) async {
    final readinessFailure = _readinessFailure();
    if (readinessFailure != null) {
      return FailureResult(readinessFailure);
    }

    try {
      await remoteDataSource.resetPasswordForEmail(email: email);
      return const Success(null);
    } on AuthException catch (error) {
      AppLogger.error(
        'Unable to send password reset email. Supabase detail: ${error.message}',
        name: 'Supabase.Session',
        error: error,
      );
      return FailureResult(
        AppFailure.unauthorized(
          'Unable to send password reset email. ${error.message}',
          details: error.message,
        ),
      );
    } catch (error, stackTrace) {
      AppLogger.error(
        'Password reset request failed unexpectedly. Unexpected detail: $error',
        name: 'Supabase.Session',
        error: error,
        stackTrace: stackTrace,
      );
      return FailureResult(
        AppFailure.unknown(
          'Unexpected error while sending password reset email.',
          details: error.toString(),
        ),
      );
    }
  }

  @override
  Future<Result<void>> signOut() async {
    if (!bootstrap.environment.isSupabaseConfigured) {
      return const Success(null);
    }

    try {
      await remoteDataSource.signOut();
      return const Success(null);
    } on AuthException catch (error) {
      AppLogger.error(
        'Supabase sign out failed: ${error.message}',
        name: 'Supabase.Session',
        error: error,
      );
      return FailureResult(
        AppFailure.unauthorized('Unable to sign out.', details: error.message),
      );
    } catch (error, stackTrace) {
      AppLogger.error(
        'Supabase sign out failed unexpectedly.',
        name: 'Supabase.Session',
        error: error,
        stackTrace: stackTrace,
      );
      return FailureResult(
        AppFailure.unknown(
          'Unexpected error while signing out.',
          details: error.toString(),
        ),
      );
    }
  }

  Future<Result<AppSession>> _runAuthRequest({
    required Future<Session?> Function() request,
    required String authMessage,
    required String unknownMessage,
  }) async {
    final readinessFailure = _readinessFailure();
    if (readinessFailure != null) {
      return FailureResult(readinessFailure);
    }

    try {
      final session = await request();
      final user = session?.user;

      if (user == null) {
        return Success(AppSession.guest());
      }

      return Success(
        AppSession.authenticated(userId: user.id, email: user.email),
      );
    } on AuthException catch (error) {
      AppLogger.error(
        '$authMessage Supabase detail: ${error.message}',
        name: 'Supabase.Session',
        error: error,
      );
      return FailureResult(
        AppFailure.unauthorized(
          '$authMessage ${error.message}',
          details: error.message,
        ),
      );
    } catch (error, stackTrace) {
      AppLogger.error(
        '$unknownMessage Unexpected detail: $error',
        name: 'Supabase.Session',
        error: error,
        stackTrace: stackTrace,
      );
      return FailureResult(
        AppFailure.unknown(unknownMessage, details: error.toString()),
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
