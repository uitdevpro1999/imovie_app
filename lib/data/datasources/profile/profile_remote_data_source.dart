import 'dart:typed_data';

import 'package:imovie_app/core/error/app_exception.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/logger/app_logger.dart';
import 'package:imovie_app/core/services/supabase_data_service.dart';
import 'package:imovie_app/data/models/response/profile/profile_response.dart';

abstract interface class ProfileRemoteDataSource {
  Future<ProfileResponse> getCurrentProfile();

  Future<ProfileResponse> updateProfile({
    required String fullName,
    required String phone,
  });

  Future<ProfileResponse> updateAvatar({
    required Uint8List bytes,
    required String fileName,
    required String contentType,
  });
}

class SupabaseProfileRemoteDataSource implements ProfileRemoteDataSource {
  const SupabaseProfileRemoteDataSource({required this.dataService});

  static const _table = 'profiles';
  static const _avatarBucket = 'avatars';

  final SupabaseDataService dataService;

  @override
  Future<ProfileResponse> getCurrentProfile() async {
    final user = _currentUser();
    AppLogger.info(
      'Loading profile for ${AppLogger.shortId(user.id)}.',
      name: 'Supabase.Profile',
    );
    final json = await dataService.selectMaybeSingle(
      table: _table,
      equals: {'id': user.id},
    );

    if (json == null) {
      AppLogger.warning(
        'Profile not found for ${AppLogger.shortId(user.id)}.',
        name: 'Supabase.Profile',
      );
      throw AppException(
        AppFailure.notFound('Profile was not found for the current account.'),
      );
    }

    AppLogger.info(
      'Profile loaded for ${AppLogger.shortId(user.id)}.',
      name: 'Supabase.Profile',
    );
    return ProfileResponse.fromJson(json);
  }

  @override
  Future<ProfileResponse> updateProfile({
    required String fullName,
    required String phone,
  }) async {
    final user = _currentUser();
    AppLogger.info(
      'Updating profile fields for ${AppLogger.shortId(user.id)}.',
      name: 'Supabase.Profile',
    );
    final json = await dataService.updateAndSelectSingle(
      table: _table,
      values: {'full_name': fullName.trim(), 'phone': phone.trim()},
      equals: {'id': user.id},
    );

    AppLogger.info(
      'Profile fields updated for ${AppLogger.shortId(user.id)}.',
      name: 'Supabase.Profile',
    );
    return ProfileResponse.fromJson(json);
  }

  @override
  Future<ProfileResponse> updateAvatar({
    required Uint8List bytes,
    required String fileName,
    required String contentType,
  }) async {
    final user = _currentUser();
    final extension = _extensionFor(
      fileName: fileName,
      contentType: contentType,
    );
    final path = '${user.id}/avatar$extension';

    AppLogger.info(
      'Uploading avatar for ${AppLogger.shortId(user.id)} to $_avatarBucket/$path.',
      name: 'Supabase.Profile',
    );
    await dataService.uploadBinary(
      bucket: _avatarBucket,
      path: path,
      bytes: bytes,
      contentType: contentType,
      upsert: true,
    );

    final avatarUrl = dataService.getPublicUrl(
      bucket: _avatarBucket,
      path: path,
    );
    AppLogger.info(
      'Avatar uploaded for ${AppLogger.shortId(user.id)}.',
      name: 'Supabase.Profile',
    );
    final json = await dataService.updateAndSelectSingle(
      table: _table,
      values: {'avatar_url': avatarUrl},
      equals: {'id': user.id},
    );

    AppLogger.info(
      'Profile avatar URL updated for ${AppLogger.shortId(user.id)}.',
      name: 'Supabase.Profile',
    );
    return ProfileResponse.fromJson(json);
  }

  SupabaseDataUser _currentUser() {
    return dataService.requireCurrentUser(
      unauthorizedMessage: 'Sign in before editing your profile.',
      logName: 'Supabase.Profile',
      blockedLogMessage:
          'Profile request blocked because no Supabase user is signed in.',
    );
  }

  String _extensionFor({
    required String fileName,
    required String contentType,
  }) {
    final normalizedFileName = fileName.toLowerCase().trim();
    final dotIndex = normalizedFileName.lastIndexOf('.');
    if (dotIndex >= 0 && dotIndex < normalizedFileName.length - 1) {
      final extension = normalizedFileName.substring(dotIndex);
      if (extension.length <= 6) {
        return extension;
      }
    }

    return switch (contentType.toLowerCase()) {
      'image/png' => '.png',
      'image/gif' => '.gif',
      'image/webp' => '.webp',
      _ => '.jpg',
    };
  }
}

class UnconfiguredProfileRemoteDataSource implements ProfileRemoteDataSource {
  const UnconfiguredProfileRemoteDataSource();

  @override
  Future<ProfileResponse> getCurrentProfile() async {
    throw const AppException(_configurationFailure);
  }

  @override
  Future<ProfileResponse> updateProfile({
    required String fullName,
    required String phone,
  }) async {
    throw const AppException(_configurationFailure);
  }

  @override
  Future<ProfileResponse> updateAvatar({
    required Uint8List bytes,
    required String fileName,
    required String contentType,
  }) async {
    throw const AppException(_configurationFailure);
  }
}

const _configurationFailure = AppFailure(
  type: FailureType.configuration,
  message:
      'Supabase is not configured. Provide SUPABASE_URL and SUPABASE_ANON_KEY via --dart-define.',
);
