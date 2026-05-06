import 'dart:async';

import 'package:image_picker/image_picker.dart';
import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/events/app_event_bus.dart';
import 'package:imovie_app/core/events/app_profile_event.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/profile/app_profile.dart';
import 'package:imovie_app/domain/usecases/profile/get_cached_profile_use_case.dart';
import 'package:imovie_app/domain/usecases/profile/update_profile_avatar_use_case.dart';
import 'package:imovie_app/domain/usecases/profile/update_profile_use_case.dart';
import 'package:imovie_app/presentation/ui/main/main_cubit.dart';
import 'package:imovie_app/presentation/ui/main/main_state.dart';
import 'package:imovie_app/presentation/ui/profile/edit_profile/edit_profile_state.dart';

class EditProfileCubit extends BaseCubit<EditProfileState> {
  EditProfileCubit({
    required MainCubit mainCubit,
    required GetCachedProfileUseCase getCachedProfileUseCase,
    required UpdateProfileUseCase updateProfileUseCase,
    required UpdateProfileAvatarUseCase updateProfileAvatarUseCase,
  }) : _mainCubit = mainCubit,
       _getCachedProfileUseCase = getCachedProfileUseCase,
       _updateProfileUseCase = updateProfileUseCase,
       _updateProfileAvatarUseCase = updateProfileAvatarUseCase,
       super(const EditProfileState()) {
    _mainSubscription = _mainCubit.stream.listen(_syncMainState);
  }

  final MainCubit _mainCubit;
  final GetCachedProfileUseCase _getCachedProfileUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final UpdateProfileAvatarUseCase _updateProfileAvatarUseCase;
  late final StreamSubscription<MainState> _mainSubscription;

  @override
  Future<void> initData() async {
    await _loadCachedProfile();
    _syncMainState(_mainCubit.state);
    if (_mainCubit.state.pageStatus == PageStatus.initial ||
        _mainCubit.state.pageStatus == PageStatus.error) {
      await _mainCubit.load();
    }
  }

  Future<bool> saveProfile({
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
      return false;
    }

    emit(state.copyWith(processing: true, failure: null, actionMessage: null));

    final profileResult = await _updateProfileUseCase(
      UpdateProfileParams(fullName: normalizedName, phone: phone.trim()),
    );
    final updatedProfile = profileResult.map<AppProfile?>(
      success: (profile) => profile,
      failure: (failure) {
        _emitSaveFailure(failure);
        return null;
      },
    );
    if (updatedProfile == null) {
      return false;
    }

    final pendingAvatarBytes = state.pendingAvatarBytes;
    AppProfile? savedProfile = updatedProfile;
    if (pendingAvatarBytes != null) {
      final avatarResult = await _updateProfileAvatarUseCase(
        UpdateProfileAvatarParams(
          bytes: pendingAvatarBytes,
          fileName: state.pendingAvatarFileName,
          contentType: state.pendingAvatarContentType,
        ),
      );
      savedProfile = avatarResult.map<AppProfile?>(
        success: (profile) => profile,
        failure: (failure) {
          _emitSaveFailure(failure);
          return null;
        },
      );
      if (savedProfile == null) {
        return false;
      }
    }

    emit(
      state.copyWith(
        processing: false,
        failure: null,
        profile: savedProfile,
        pendingAvatarBytes: null,
        pendingAvatarFileName: '',
        pendingAvatarContentType: '',
        actionMessage: successMessage,
      ),
    );
    appEventBus.emitProfile(
      pendingAvatarBytes == null
          ? AppProfileEvent.profileUpdated()
          : AppProfileEvent.avatarUpdated(),
    );
    showSuccessToast(successMessage);
    return true;
  }

  Future<void> selectAvatar({
    required XFile file,
    required String invalidFileMessage,
  }) async {
    final bytes = await file.readAsBytes();
    if (bytes.isEmpty) {
      final failure = AppFailure.unknown(invalidFileMessage);
      emit(state.copyWith(failure: failure, actionMessage: null));
      showFailureToast(failure);
      return;
    }

    emit(
      state.copyWith(
        pendingAvatarBytes: bytes,
        pendingAvatarFileName: file.name,
        pendingAvatarContentType: _contentTypeFor(file),
        failure: null,
        actionMessage: null,
      ),
    );
  }

  void _emitSaveFailure(AppFailure failure) {
    emit(
      state.copyWith(processing: false, failure: failure, actionMessage: null),
    );
    showFailureToast(failure);
  }

  void _syncMainState(MainState mainState) {
    if (mainState.pageStatus == PageStatus.initial) {
      return;
    }

    if (mainState.pageStatus == PageStatus.loading && state.profile != null) {
      emit(state.copyWith(processing: mainState.processing, failure: null));
      return;
    }

    if (mainState.pageStatus == PageStatus.error && state.profile != null) {
      emit(
        state.copyWith(
          pageStatus: PageStatus.loaded,
          processing: false,
          failure: mainState.failure,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        pageStatus: mainState.pageStatus,
        isAuthenticated: mainState.isAuthenticated,
        profile: mainState.profile,
        processing: mainState.processing,
        failure: mainState.failure,
      ),
    );
  }

  Future<void> _loadCachedProfile() async {
    final result = await _getCachedProfileUseCase(const NoParams());
    final cachedProfile = result.map(
      success: (profile) => profile,
      failure: (_) => null,
    );
    if (cachedProfile == null) {
      return;
    }

    emit(
      state.copyWith(
        pageStatus: PageStatus.loaded,
        isAuthenticated: true,
        profile: cachedProfile,
        failure: null,
      ),
    );
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

  @override
  Future<void> close() async {
    await _mainSubscription.cancel();
    return super.close();
  }
}
