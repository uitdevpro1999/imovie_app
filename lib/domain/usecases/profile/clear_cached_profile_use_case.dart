import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/repositories/profile_repository.dart';

class ClearCachedProfileUseCase implements UseCase<void, NoParams> {
  const ClearCachedProfileUseCase(this.repository);

  final ProfileRepository repository;

  @override
  Future<Result<void>> call(NoParams params) {
    return repository.clearCachedProfile();
  }
}
