import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/profile/app_profile.dart';
import 'package:imovie_app/domain/repositories/profile_repository.dart';

class GetCurrentProfileUseCase implements UseCase<AppProfile, NoParams> {
  const GetCurrentProfileUseCase(this.repository);

  final ProfileRepository repository;

  @override
  Future<Result<AppProfile>> call(NoParams params) {
    return repository.getCurrentProfile();
  }
}
