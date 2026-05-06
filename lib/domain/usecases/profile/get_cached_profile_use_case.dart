import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/profile/app_profile.dart';
import 'package:imovie_app/domain/repositories/profile_repository.dart';

class GetCachedProfileUseCase implements UseCase<AppProfile?, NoParams> {
  const GetCachedProfileUseCase(this.repository);

  final ProfileRepository repository;

  @override
  Future<Result<AppProfile?>> call(NoParams params) {
    return repository.getCachedProfile();
  }
}
