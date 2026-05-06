import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/session/app_session.dart';
import 'package:imovie_app/domain/repositories/session_repository.dart';

class SignInWithPasswordUseCase
    implements UseCase<AppSession, SignInWithPasswordParams> {
  const SignInWithPasswordUseCase(this.repository);

  final SessionRepository repository;

  @override
  Future<Result<AppSession>> call(SignInWithPasswordParams params) {
    return repository.signInWithPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class SignInWithPasswordParams {
  const SignInWithPasswordParams({required this.email, required this.password});

  final String email;
  final String password;
}
