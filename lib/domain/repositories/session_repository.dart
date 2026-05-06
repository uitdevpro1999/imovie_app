import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/domain/entities/session/app_session.dart';

abstract interface class SessionRepository {
  Future<Result<AppSession>> getCurrentSession();

  Future<Result<AppSession>> signInWithPassword({
    required String email,
    required String password,
  });

  Future<Result<AppSession>> signUp({
    required String email,
    required String password,
  });

  Future<Result<void>> resetPasswordForEmail({required String email});

  Future<Result<void>> signOut();
}
