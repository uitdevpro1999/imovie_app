import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/session/app_session.dart';
import 'package:imovie_app/domain/repositories/session_repository.dart';

class GetCurrentSessionUseCase implements UseCase<AppSession, NoParams> {
  const GetCurrentSessionUseCase(this.repository);

  final SessionRepository repository;

  @override
  Future<Result<AppSession>> call(NoParams params) {
    return repository.getCurrentSession();
  }
}
