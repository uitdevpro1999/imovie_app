import 'dart:async';

import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/events/app_auth_event.dart';
import 'package:imovie_app/core/events/app_event_bus.dart';
import 'package:imovie_app/core/events/app_profile_event.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/profile/app_profile.dart';
import 'package:imovie_app/domain/usecases/get_current_session_use_case.dart';
import 'package:imovie_app/domain/usecases/profile/clear_cached_profile_use_case.dart';
import 'package:imovie_app/domain/usecases/profile/get_cached_profile_use_case.dart';
import 'package:imovie_app/domain/usecases/profile/get_current_profile_use_case.dart';
import 'package:imovie_app/domain/usecases/session/sign_out_use_case.dart';
import 'package:imovie_app/presentation/ui/main/main_state.dart';

class MainCubit extends BaseCubit<MainState> {
  MainCubit({
    required GetCurrentSessionUseCase getCurrentSessionUseCase,
    required GetCurrentProfileUseCase getCurrentProfileUseCase,
    required GetCachedProfileUseCase getCachedProfileUseCase,
    required ClearCachedProfileUseCase clearCachedProfileUseCase,
    required SignOutUseCase signOutUseCase,
  }) : _getCurrentSessionUseCase = getCurrentSessionUseCase,
       _getCurrentProfileUseCase = getCurrentProfileUseCase,
       _getCachedProfileUseCase = getCachedProfileUseCase,
       _clearCachedProfileUseCase = clearCachedProfileUseCase,
       _signOutUseCase = signOutUseCase,
       super(const MainState()) {
    _profileSubscription = appEventBus.profileStream.listen(
      _handleProfileEvent,
    );
  }

  final GetCurrentSessionUseCase _getCurrentSessionUseCase;
  final GetCurrentProfileUseCase _getCurrentProfileUseCase;
  final GetCachedProfileUseCase _getCachedProfileUseCase;
  final ClearCachedProfileUseCase _clearCachedProfileUseCase;
  final SignOutUseCase _signOutUseCase;
  late final StreamSubscription<AppProfileEvent> _profileSubscription;

  bool _isLoadingProfile = false;

  @override
  Future<void> initData() => load();

  Future<void> load() {
    return _loadProfile(
      showFullLoading: state.pageStatus == PageStatus.initial,
      includeCachedProfile: true,
    );
  }

  Future<void> _reloadProfile() {
    return _loadProfile(showFullLoading: false, includeCachedProfile: false);
  }

  Future<bool> signOut({required String failureMessage}) async {
    emit(state.copyWith(processing: true, failure: null));

    final result = await _signOutUseCase(const NoParams());
    return result.map<Future<bool>>(
      success: (_) async {
        await _clearCachedProfile();
        emit(
          state.copyWith(
            pageStatus: PageStatus.loaded,
            processing: false,
            isAuthenticated: false,
            profile: null,
            failure: null,
          ),
        );
        appEventBus.emitAuth(AppAuthEvent.unauthenticated());
        return true;
      },
      failure: (failure) async {
        final resolvedFailure = failure.message.trim().isEmpty
            ? AppFailure.unknown(failureMessage)
            : failure;
        emit(state.copyWith(processing: false, failure: resolvedFailure));
        showFailureToast(resolvedFailure);
        return false;
      },
    );
  }

  Future<void> _loadProfile({
    required bool showFullLoading,
    required bool includeCachedProfile,
  }) async {
    if (_isLoadingProfile) {
      return;
    }

    _isLoadingProfile = true;
    final useFullLoading =
        showFullLoading || state.pageStatus == PageStatus.initial;
    emit(
      state.copyWith(
        pageStatus: useFullLoading ? PageStatus.loading : state.pageStatus,
        processing: useFullLoading ? false : true,
        failure: null,
      ),
    );

    try {
      final sessionResult = await _getCurrentSessionUseCase(const NoParams());
      final session = sessionResult.map(
        success: (session) => session,
        failure: (failure) {
          _emitLoadFailure(failure);
          return null;
        },
      );
      if (session == null) {
        return;
      }

      if (!session.isAuthenticated) {
        await _clearCachedProfile();
        emit(
          state.copyWith(
            pageStatus: PageStatus.loaded,
            processing: false,
            isAuthenticated: false,
            profile: null,
            failure: null,
          ),
        );
        return;
      }

      if (includeCachedProfile && state.profile == null) {
        await _emitCachedProfile();
      }

      final profileResult = await _getCurrentProfileUseCase(const NoParams());
      profileResult.map(
        success: (profile) {
          emit(
            state.copyWith(
              pageStatus: PageStatus.loaded,
              processing: false,
              isAuthenticated: true,
              profile: profile,
              failure: null,
            ),
          );
        },
        failure: _emitLoadFailure,
      );
    } finally {
      _isLoadingProfile = false;
    }
  }

  Future<void> _handleProfileEvent(AppProfileEvent event) async {
    final bustAvatarCache =
        event.changeType == AppProfileChangeType.avatar ||
        event.changeType == AppProfileChangeType.media;
    final bustCoverCache =
        event.changeType == AppProfileChangeType.cover ||
        event.changeType == AppProfileChangeType.media;
    await _emitCachedProfile(
      force: true,
      processing: event.reloadRemote,
      bustAvatarCache: bustAvatarCache,
      bustCoverCache: bustCoverCache,
    );

    if (event.reloadRemote) {
      await _reloadProfile();
    }
  }

  Future<void> _emitCachedProfile({
    bool force = false,
    bool processing = true,
    bool bustAvatarCache = false,
    bool bustCoverCache = false,
  }) async {
    if (!force && state.profile != null) {
      return;
    }

    final cachedProfile = await _readCachedProfile();
    if (cachedProfile == null) {
      return;
    }

    var profile = cachedProfile;
    if (bustAvatarCache) {
      profile = profile.copyWith(avatarUrl: _bustImageUrl(profile.avatarUrl));
    }
    if (bustCoverCache) {
      profile = profile.copyWith(coverUrl: _bustImageUrl(profile.coverUrl));
    }
    emit(
      state.copyWith(
        pageStatus: PageStatus.loaded,
        processing: processing,
        isAuthenticated: true,
        profile: profile,
        failure: null,
      ),
    );
  }

  Future<AppProfile?> _readCachedProfile() async {
    final cachedResult = await _getCachedProfileUseCase(const NoParams());
    return cachedResult.map(
      success: (profile) => profile,
      failure: (_) => null,
    );
  }

  void _emitLoadFailure(AppFailure failure) {
    if (state.profile != null) {
      emit(
        state.copyWith(
          pageStatus: PageStatus.loaded,
          processing: false,
          failure: failure,
        ),
      );
      showFailureToast(failure);
      return;
    }

    emit(
      state.copyWith(
        pageStatus: PageStatus.error,
        processing: false,
        failure: failure,
      ),
    );
  }

  Future<void> _clearCachedProfile() async {
    await _clearCachedProfileUseCase(const NoParams());
  }

  String _bustImageUrl(String imageUrl) {
    final uri = Uri.tryParse(imageUrl);
    if (uri == null) {
      return imageUrl;
    }

    final updated = uri.replace(
      queryParameters: {
        ...uri.queryParameters,
        'v': DateTime.now().millisecondsSinceEpoch.toString(),
      },
    );
    return updated.toString();
  }

  @override
  Future<void> close() async {
    await _profileSubscription.cancel();
    return super.close();
  }
}
