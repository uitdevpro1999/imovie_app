import 'package:imovie_app/core/services/supabase_auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class SessionRemoteDataSource {
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

class SupabaseSessionRemoteDataSource implements SessionRemoteDataSource {
  const SupabaseSessionRemoteDataSource({required this.authService});

  final SupabaseAuthService authService;

  @override
  Future<Session?> getCurrentSession() async {
    return authService.getCurrentSession();
  }

  @override
  Future<Session?> signInWithPassword({
    required String email,
    required String password,
  }) {
    return authService.signInWithPassword(email: email, password: password);
  }

  @override
  Future<Session?> signUp({required String email, required String password}) {
    return authService.signUp(email: email, password: password);
  }

  @override
  Future<void> resetPasswordForEmail({required String email}) {
    return authService.resetPasswordForEmail(email: email);
  }

  @override
  Future<void> updatePassword({required String password}) {
    return authService.updatePassword(password: password);
  }

  @override
  Future<void> signOut() {
    return authService.signOut();
  }
}

class UnconfiguredSessionRemoteDataSource implements SessionRemoteDataSource {
  const UnconfiguredSessionRemoteDataSource();

  @override
  Future<Session?> getCurrentSession() async {
    return null;
  }

  @override
  Future<Session?> signInWithPassword({
    required String email,
    required String password,
  }) async {
    return null;
  }

  @override
  Future<Session?> signUp({
    required String email,
    required String password,
  }) async {
    return null;
  }

  @override
  Future<void> resetPasswordForEmail({required String email}) async {}

  @override
  Future<void> updatePassword({required String password}) async {}

  @override
  Future<void> signOut() async {}
}
