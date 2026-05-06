import 'dart:typed_data';

import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/domain/entities/profile/app_profile.dart';

abstract interface class ProfileRepository {
  Future<Result<AppProfile?>> getCachedProfile();

  Future<Result<AppProfile>> getCurrentProfile();

  Future<Result<AppProfile>> updateProfile({
    required String fullName,
    required String phone,
  });

  Future<Result<AppProfile>> updateAvatar({
    required Uint8List bytes,
    required String fileName,
    required String contentType,
  });

  Future<Result<void>> clearCachedProfile();
}
