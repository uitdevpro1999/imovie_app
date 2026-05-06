import 'dart:typed_data';

import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/profile/app_profile.dart';
import 'package:imovie_app/domain/repositories/profile_repository.dart';

class UpdateProfileAvatarUseCase
    implements UseCase<AppProfile, UpdateProfileAvatarParams> {
  const UpdateProfileAvatarUseCase(this.repository);

  final ProfileRepository repository;

  @override
  Future<Result<AppProfile>> call(UpdateProfileAvatarParams params) {
    return repository.updateAvatar(
      bytes: params.bytes,
      fileName: params.fileName,
      contentType: params.contentType,
    );
  }
}

class UpdateProfileAvatarParams {
  const UpdateProfileAvatarParams({
    required this.bytes,
    required this.fileName,
    required this.contentType,
  });

  final Uint8List bytes;
  final String fileName;
  final String contentType;
}
