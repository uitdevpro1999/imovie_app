import 'dart:typed_data';

import 'package:imovie_app/config/flavors/app_bootstrap.dart';
import 'package:imovie_app/core/error/app_exception.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/data/datasources/profile/profile_remote_data_source.dart';
import 'package:imovie_app/data/models/response/profile/profile_response.dart';
import 'package:imovie_app/domain/entities/profile/app_profile.dart';
import 'package:imovie_app/domain/repositories/profile_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl({
    required this.bootstrap,
    required this.remoteDataSource,
  });

  final AppBootstrap bootstrap;
  final ProfileRemoteDataSource remoteDataSource;

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
      return Success(response.toEntity());
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
}
