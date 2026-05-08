import 'dart:typed_data';

import 'package:imovie_app/config/flavors/app_bootstrap.dart';
import 'package:imovie_app/core/error/app_exception.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/logger/app_logger.dart';
import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/services/local_storage_service.dart';
import 'package:imovie_app/data/datasources/profile/profile_remote_data_source.dart';
import 'package:imovie_app/data/models/response/profile/profile_response.dart';
import 'package:imovie_app/domain/entities/profile/app_profile.dart';
import 'package:imovie_app/domain/repositories/profile_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl({
    required this.bootstrap,
    required this.remoteDataSource,
    required this.localStorageService,
  });

  static const _cachedProfileKey = 'profile.current';

  final AppBootstrap bootstrap;
  final ProfileRemoteDataSource remoteDataSource;
  final LocalStorageService localStorageService;

  @override
  Future<Result<AppProfile?>> getCachedProfile() async {
    try {
      final json = await localStorageService.readJsonMap(_cachedProfileKey);
      return Success(json == null ? null : _profileFromJson(json));
    } catch (error) {
      return FailureResult(
        AppFailure.unknown(
          'Unexpected error while loading cached profile.',
          details: error.toString(),
        ),
      );
    }
  }

  @override
  Future<Result<AppProfile>> getCurrentProfile() async {
    return _runProfileRequest(
      request: remoteDataSource.getCurrentProfile,
      authMessage: 'Unable to load your profile.',
      unknownMessage: 'Unexpected error while loading your profile.',
    );
  }

  @override
  Future<Result<AppProfile>> updateProfile({
    required String fullName,
    required String phone,
  }) async {
    return _runProfileRequest(
      request: () =>
          remoteDataSource.updateProfile(fullName: fullName, phone: phone),
      authMessage: 'Unable to update your profile.',
      unknownMessage: 'Unexpected error while updating your profile.',
    );
  }

  @override
  Future<Result<AppProfile>> updateAvatar({
    required Uint8List bytes,
    required String fileName,
    required String contentType,
  }) async {
    return _runProfileRequest(
      request: () => remoteDataSource.updateAvatar(
        bytes: bytes,
        fileName: fileName,
        contentType: contentType,
      ),
      authMessage: 'Unable to update your avatar.',
      unknownMessage: 'Unexpected error while updating your avatar.',
    );
  }

  @override
  Future<Result<AppProfile>> updateCover({
    required Uint8List bytes,
    required String fileName,
    required String contentType,
  }) async {
    return _runProfileRequest(
      request: () => remoteDataSource.updateCover(
        bytes: bytes,
        fileName: fileName,
        contentType: contentType,
      ),
      authMessage: 'Unable to update your cover image.',
      unknownMessage: 'Unexpected error while updating your cover image.',
    );
  }

  @override
  Future<Result<void>> clearCachedProfile() async {
    try {
      await localStorageService.remove(_cachedProfileKey);
      return const Success<void>(null);
    } catch (error) {
      return FailureResult(
        AppFailure.unknown(
          'Unexpected error while clearing cached profile.',
          details: error.toString(),
        ),
      );
    }
  }

  Future<Result<AppProfile>> _runProfileRequest({
    required Future<ProfileResponse> Function() request,
    required String authMessage,
    required String unknownMessage,
  }) async {
    final readinessFailure = _readinessFailure();
    if (readinessFailure != null) {
      return FailureResult(readinessFailure);
    }

    try {
      final response = await request();
      final profile = response.toEntity();
      await _cacheProfile(profile);
      return Success(profile);
    } on AppException catch (error) {
      return FailureResult(error.failure);
    } on AuthException catch (error) {
      return FailureResult(
        AppFailure.unauthorized(authMessage, details: error.message),
      );
    } on StorageException catch (error) {
      return FailureResult(
        AppFailure.network(authMessage, details: error.message),
      );
    } on PostgrestException catch (error) {
      return FailureResult(
        AppFailure.network(authMessage, details: error.message),
      );
    } catch (error) {
      return FailureResult(
        AppFailure.unknown(unknownMessage, details: error.toString()),
      );
    }
  }

  AppFailure? _readinessFailure() {
    if (!bootstrap.environment.isSupabaseConfigured) {
      return AppFailure.configuration(
        'Supabase is not configured. Provide SUPABASE_URL and SUPABASE_ANON_KEY via --dart-define.',
      );
    }

    return bootstrap.initializationFailure;
  }

  Future<void> _cacheProfile(AppProfile profile) async {
    try {
      await localStorageService.writeJsonMap(
        _cachedProfileKey,
        _profileToJson(profile),
      );
    } catch (error, stackTrace) {
      AppLogger.warning(
        'Unable to cache profile locally.',
        name: 'Profile.Cache',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  AppProfile _profileFromJson(Map<String, dynamic> json) {
    return AppProfile(
      id: json['id']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      fullName: json['full_name']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      avatarUrl: json['avatar_url']?.toString() ?? '',
      coverUrl: json['cover_url']?.toString() ?? '',
    );
  }

  Map<String, dynamic> _profileToJson(AppProfile profile) {
    return {
      'id': profile.id,
      'email': profile.email,
      'full_name': profile.fullName,
      'phone': profile.phone,
      'avatar_url': profile.avatarUrl,
      'cover_url': profile.coverUrl,
    };
  }
}
