import 'package:imovie_app/core/error/app_exception.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/logger/app_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class SupabaseAuthService {
  Future<Session?> getCurrentSession();

  Future<Session?> signInWithPassword({
    required String email,
    required String password,
  });

  Future<Session?> signUp({required String email, required String password});

  Future<void> resetPasswordForEmail({required String email});

  Future<void> updatePassword({required String password});

  Future<void> signOut();
}

class ConfiguredSupabaseAuthService implements SupabaseAuthService {
  const ConfiguredSupabaseAuthService({required this.client});

  final SupabaseClient client;

  @override
  Future<Session?> getCurrentSession() async {
    final session = client.auth.currentSession;
    AppLogger.info(
      session?.user == null
          ? 'Current session: guest.'
          : 'Current session: ${AppLogger.shortId(session!.user.id)}.',
      name: 'Supabase.Auth',
    );
    return session;
  }

  @override
  Future<Session?> signInWithPassword({
    required String email,
    required String password,
  }) async {
    AppLogger.info(
      'Signing in ${AppLogger.maskEmail(email)}.',
      name: 'Supabase.Auth',
    );
    final response = await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    AppLogger.info(
      response.session?.user == null
          ? 'Sign in completed without a session.'
          : 'Sign in completed for ${AppLogger.shortId(response.session!.user.id)}.',
      name: 'Supabase.Auth',
    );
    return response.session;
  }

  @override
  Future<Session?> signUp({
    required String email,
    required String password,
  }) async {
    AppLogger.info(
      'Signing up ${AppLogger.maskEmail(email)}.',
      name: 'Supabase.Auth',
    );
    final response = await client.auth.signUp(email: email, password: password);
    AppLogger.info(
      response.session?.user == null
          ? 'Sign up completed without a session.'
          : 'Sign up completed for ${AppLogger.shortId(response.session!.user.id)}.',
      name: 'Supabase.Auth',
    );
    return response.session;
  }

  @override
  Future<void> resetPasswordForEmail({required String email}) async {
    AppLogger.info(
      'Sending password reset email to ${AppLogger.maskEmail(email)}.',
      name: 'Supabase.Auth',
    );
    await client.auth.resetPasswordForEmail(email);
    AppLogger.info(
      'Password reset email requested for ${AppLogger.maskEmail(email)}.',
      name: 'Supabase.Auth',
    );
  }

  @override
  Future<void> updatePassword({required String password}) async {
    AppLogger.info('Updating current user password.', name: 'Supabase.Auth');
    await client.auth.updateUser(UserAttributes(password: password));
    AppLogger.info('Current user password updated.', name: 'Supabase.Auth');
  }

  @override
  Future<void> signOut() {
    AppLogger.info('Signing out current user.', name: 'Supabase.Auth');
    return client.auth.signOut();
  }
}

class UnconfiguredSupabaseAuthService implements SupabaseAuthService {
  const UnconfiguredSupabaseAuthService();

  @override
  Future<Session?> getCurrentSession() async {
    AppLogger.warning(
      'Read current session skipped because Supabase is not configured.',
      name: 'Supabase.Auth',
    );
    return null;
  }

  @override
  Future<Session?> signInWithPassword({
    required String email,
    required String password,
  }) async {
    AppLogger.warning(
      'Sign in blocked because Supabase is not configured.',
      name: 'Supabase.Auth',
    );
    throw const AppException(_configurationFailure);
  }

  @override
  Future<Session?> signUp({
    required String email,
    required String password,
  }) async {
    AppLogger.warning(
      'Sign up blocked because Supabase is not configured.',
      name: 'Supabase.Auth',
    );
    throw const AppException(_configurationFailure);
  }

  @override
  Future<void> resetPasswordForEmail({required String email}) async {
    AppLogger.warning(
      'Password reset blocked because Supabase is not configured.',
      name: 'Supabase.Auth',
    );
    throw const AppException(_configurationFailure);
  }

  @override
  Future<void> updatePassword({required String password}) async {
    AppLogger.warning(
      'Password update blocked because Supabase is not configured.',
      name: 'Supabase.Auth',
    );
    throw const AppException(_configurationFailure);
  }

  @override
  Future<void> signOut() async {
    AppLogger.warning(
      'Sign out skipped because Supabase is not configured.',
      name: 'Supabase.Auth',
    );
  }
}

const _configurationFailure = AppFailure(
  type: FailureType.configuration,
  message:
      'Supabase is not configured. Provide SUPABASE_URL and SUPABASE_ANON_KEY via --dart-define.',
);
