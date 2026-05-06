import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/profile/app_profile.dart';
import 'package:imovie_app/domain/repositories/profile_repository.dart';

class UpdateProfileUseCase implements UseCase<AppProfile, UpdateProfileParams> {
  const UpdateProfileUseCase(this.repository);

  final ProfileRepository repository;

  @override
  Future<Result<AppProfile>> call(UpdateProfileParams params) {
    return repository.updateProfile(
      fullName: params.fullName,
      phone: params.phone,
    );
  }
}

class UpdateProfileParams {
  const UpdateProfileParams({required this.fullName, required this.phone});

  final String fullName;
  final String phone;
}
