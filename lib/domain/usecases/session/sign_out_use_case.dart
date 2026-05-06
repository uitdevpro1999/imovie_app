import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/repositories/session_repository.dart';

class SignOutUseCase implements UseCase<void, NoParams> {
  const SignOutUseCase(this.repository);

  final SessionRepository repository;

  @override
  Future<Result<void>> call(NoParams params) {
    return repository.signOut();
  }
}
