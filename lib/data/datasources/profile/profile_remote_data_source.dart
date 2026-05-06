import 'dart:typed_data';

import 'package:imovie_app/core/error/app_exception.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/logger/app_logger.dart';
import 'package:imovie_app/data/models/response/profile/profile_response.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  const SupabaseProfileRemoteDataSource({required this.client});

  static const _table = 'profiles';
  static const _avatarBucket = 'avatars';

  final SupabaseClient client;

  @override
  Future<ProfileResponse> getCurrentProfile() async {
    final user = _currentUser();
    AppLogger.info(
      'Loading profile for ${AppLogger.shortId(user.id)}.',
      name: 'Supabase.Profile',
    );
    final json = await client
        .from(_table)
        .select()
        .eq('id', user.id)
        .maybeSingle();

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
    final json = await client
        .from(_table)
        .update({'full_name': fullName.trim(), 'phone': phone.trim()})
        .eq('id', user.id)
        .select()
        .single();

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
    await client.storage
        .from(_avatarBucket)
        .uploadBinary(
          path,
          bytes,
          fileOptions: FileOptions(
            cacheControl: '3600',
            contentType: contentType,
            upsert: true,
          ),
        );

    final avatarUrl = client.storage.from(_avatarBucket).getPublicUrl(path);
    AppLogger.info(
      'Avatar uploaded for ${AppLogger.shortId(user.id)}.',
      name: 'Supabase.Profile',
    );
    final json = await client
        .from(_table)
        .update({'avatar_url': avatarUrl})
        .eq('id', user.id)
        .select()
        .single();

    AppLogger.info(
      'Profile avatar URL updated for ${AppLogger.shortId(user.id)}.',
      name: 'Supabase.Profile',
    );
    return ProfileResponse.fromJson(json);
  }

  User _currentUser() {
    final user = client.auth.currentUser;
    if (user == null) {
      AppLogger.warning(
        'Profile request blocked because no Supabase user is signed in.',
        name: 'Supabase.Profile',
      );
      throw AppException(
        AppFailure.unauthorized('Sign in before editing your profile.'),
      );
    }

    return user;
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
