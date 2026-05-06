import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/profile/app_profile.dart';
import 'package:imovie_app/domain/usecases/get_current_session_use_case.dart';
import 'package:imovie_app/domain/usecases/profile/get_current_profile_use_case.dart';
import 'package:imovie_app/domain/usecases/profile/update_profile_avatar_use_case.dart';
import 'package:imovie_app/domain/usecases/profile/update_profile_use_case.dart';
import 'package:imovie_app/domain/usecases/session/sign_out_use_case.dart';
import 'package:imovie_app/presentation/ui/profile/profile_state.dart';

class ProfileCubit extends BaseCubit<ProfileState> {
  ProfileCubit({
    required GetCurrentSessionUseCase getCurrentSessionUseCase,
    required GetCurrentProfileUseCase getCurrentProfileUseCase,
    required UpdateProfileUseCase updateProfileUseCase,
    required UpdateProfileAvatarUseCase updateProfileAvatarUseCase,
    required SignOutUseCase signOutUseCase,
  }) : _getCurrentSessionUseCase = getCurrentSessionUseCase,
       _getCurrentProfileUseCase = getCurrentProfileUseCase,
       _updateProfileUseCase = updateProfileUseCase,
       _updateProfileAvatarUseCase = updateProfileAvatarUseCase,
       _signOutUseCase = signOutUseCase,
       super(const ProfileState());

  final GetCurrentSessionUseCase _getCurrentSessionUseCase;
  final GetCurrentProfileUseCase _getCurrentProfileUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final UpdateProfileAvatarUseCase _updateProfileAvatarUseCase;
  final SignOutUseCase _signOutUseCase;

  @override
  Future<void> initData() => load();

  Future<void> load() async {
    emit(
      state.copyWithBase(pageStatus: PageStatus.loading, clearFailure: true),
    );

    final sessionResult = await _getCurrentSessionUseCase(const NoParams());
    final session = sessionResult.map(
      success: (session) => session,
      failure: (failure) {
        emit(state.copyWith(pageStatus: PageStatus.error, failure: failure));
        return null;
      },
    );
    if (session == null) {
      return;
    }

    if (!session.isAuthenticated) {
      emit(
        state.copyWith(
          pageStatus: PageStatus.loaded,
          isAuthenticated: false,
          profile: null,
          failure: null,
        ),
      );
      return;
    }

    final profileResult = await _getCurrentProfileUseCase(const NoParams());
    emit(
      profileResult.map(
        success: (profile) => state.copyWith(
          pageStatus: PageStatus.loaded,
          isAuthenticated: true,
          profile: profile,
          failure: null,
        ),
        failure: (failure) =>
            state.copyWith(pageStatus: PageStatus.error, failure: failure),
      ),
    );
  }

  Future<void> saveProfile({
    required String fullName,
    required String phone,
    required String successMessage,
    required String emptyNameMessage,
  }) async {
    final normalizedName = fullName.trim();
    if (normalizedName.isEmpty) {
      final failure = AppFailure.unknown(emptyNameMessage);
      emit(state.copyWith(failure: failure, actionMessage: null));
      showFailureToast(failure);
      return;
    }

    emit(state.copyWith(processing: true, failure: null, actionMessage: null));

    final result = await _updateProfileUseCase(
      UpdateProfileParams(fullName: normalizedName, phone: phone.trim()),
    );
    emit(
      result.map(
        success: (profile) => state.copyWith(
          processing: false,
          profile: profile,
          failure: null,
          actionMessage: successMessage,
        ),
        failure: (failure) => state.copyWith(
          processing: false,
          failure: failure,
          actionMessage: null,
        ),
      ),
    );
    result.map(
      success: (_) => showSuccessToast(successMessage),
      failure: showFailureToast,
    );
  }

  Future<void> updateAvatar({
    required XFile file,
    required String successMessage,
    required String invalidFileMessage,
  }) async {
    final bytes = await file.readAsBytes();
    if (bytes.isEmpty) {
      final failure = AppFailure.unknown(invalidFileMessage);
      emit(state.copyWith(failure: failure, actionMessage: null));
      showFailureToast(failure);
      return;
    }

    await _uploadAvatarBytes(
      bytes: bytes,
      fileName: file.name,
      contentType: _contentTypeFor(file),
      successMessage: successMessage,
    );
  }

  Future<bool> signOut({required String failureMessage}) async {
    emit(state.copyWith(processing: true, failure: null, actionMessage: null));

    final result = await _signOutUseCase(const NoParams());
    return result.map(
      success: (_) {
        emit(
          state.copyWith(
            processing: false,
            isAuthenticated: false,
            profile: null,
            failure: null,
          ),
        );
        return true;
      },
      failure: (failure) {
        final resolvedFailure = failure.message.trim().isEmpty
            ? AppFailure.unknown(failureMessage)
            : failure;
        emit(state.copyWith(processing: false, failure: resolvedFailure));
        showFailureToast(resolvedFailure);
        return false;
      },
    );
  }

  Future<void> _uploadAvatarBytes({
    required Uint8List bytes,
    required String fileName,
    required String contentType,
    required String successMessage,
  }) async {
    emit(state.copyWith(processing: true, failure: null, actionMessage: null));

    final result = await _updateProfileAvatarUseCase(
      UpdateProfileAvatarParams(
        bytes: bytes,
        fileName: fileName,
        contentType: contentType,
      ),
    );
    emit(
      result.map(
        success: (profile) => state.copyWith(
          processing: false,
          profile: _bustAvatarCache(profile),
          failure: null,
          actionMessage: successMessage,
        ),
        failure: (failure) => state.copyWith(
          processing: false,
          failure: failure,
          actionMessage: null,
        ),
      ),
    );
    result.map(
      success: (_) => showSuccessToast(successMessage),
      failure: showFailureToast,
    );
  }

  AppProfile _bustAvatarCache(AppProfile profile) {
    final uri = Uri.tryParse(profile.avatarUrl);
    if (uri == null) {
      return profile;
    }

    final updated = uri.replace(
      queryParameters: {
        ...uri.queryParameters,
        'v': DateTime.now().millisecondsSinceEpoch.toString(),
      },
    );
    return profile.copyWith(avatarUrl: updated.toString());
  }

  String _contentTypeFor(XFile file) {
    final mimeType = file.mimeType;
    if (mimeType != null && mimeType.startsWith('image/')) {
      return mimeType;
    }

    final lowerName = file.name.toLowerCase();
    if (lowerName.endsWith('.png')) {
      return 'image/png';
    }
    if (lowerName.endsWith('.gif')) {
      return 'image/gif';
    }
    if (lowerName.endsWith('.webp')) {
      return 'image/webp';
    }

    return 'image/jpeg';
  }
}
