import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/repositories/session_repository.dart';

class ResetPasswordForEmailUseCase
    implements UseCase<void, ResetPasswordForEmailParams> {
  const ResetPasswordForEmailUseCase(this.repository);

  final SessionRepository repository;

  @override
  Future<Result<void>> call(ResetPasswordForEmailParams params) {
    return repository.resetPasswordForEmail(email: params.email);
  }
}

class ResetPasswordForEmailParams {
  const ResetPasswordForEmailParams({required this.email});

  final String email;
}
