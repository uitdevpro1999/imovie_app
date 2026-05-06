import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/session/app_session.dart';
import 'package:imovie_app/domain/repositories/session_repository.dart';

class SignUpWithPasswordUseCase
    implements UseCase<AppSession, SignUpWithPasswordParams> {
  const SignUpWithPasswordUseCase(this.repository);

  final SessionRepository repository;

  @override
  Future<Result<AppSession>> call(SignUpWithPasswordParams params) {
    return repository.signUp(email: params.email, password: params.password);
  }
}

class SignUpWithPasswordParams {
  const SignUpWithPasswordParams({required this.email, required this.password});

  final String email;
  final String password;
}
