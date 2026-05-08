import 'dart:async';

import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/events/app_community_event.dart';
import 'package:imovie_app/core/events/app_event_bus.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/usecases/community/get_community_profile_use_case.dart';
import 'package:imovie_app/domain/usecases/profile/get_cached_profile_use_case.dart';
import 'package:imovie_app/presentation/ui/main/main_cubit.dart';
import 'package:imovie_app/presentation/ui/main/main_state.dart';
import 'package:imovie_app/presentation/ui/profile/settings/settings_state.dart';

class SettingsCubit extends BaseCubit<SettingsState> {
  SettingsCubit({
    required MainCubit mainCubit,
    required GetCachedProfileUseCase getCachedProfileUseCase,
    required GetCommunityProfileUseCase getCommunityProfileUseCase,
  }) : _mainCubit = mainCubit,
       _getCachedProfileUseCase = getCachedProfileUseCase,
       _getCommunityProfileUseCase = getCommunityProfileUseCase,
       super(const SettingsState()) {
    _mainSubscription = _mainCubit.stream.listen(_syncMainState);
    _communitySubscription = appEventBus.communityStream.listen(
      _handleCommunityEvent,
    );
  }

  final MainCubit _mainCubit;
  final GetCachedProfileUseCase _getCachedProfileUseCase;
  final GetCommunityProfileUseCase _getCommunityProfileUseCase;
  late final StreamSubscription<MainState> _mainSubscription;
  late final StreamSubscription<AppCommunityEvent> _communitySubscription;
  String? _loadingCommunityProfileUserId;
  String? _loadedCommunityProfileUserId;

  @override
  Future<void> initData() async {
    await _loadCachedProfile();
    _syncMainState(_mainCubit.state);
    if (_mainCubit.state.pageStatus == PageStatus.initial ||
        _mainCubit.state.pageStatus == PageStatus.error) {
      await _mainCubit.load();
    }
  }

  Future<void> signOut({required String failureMessage}) async {
    await _mainCubit.signOut(failureMessage: failureMessage);
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

    final profile = mainState.profile;
    final profileUserId = profile?.id.trim();
    final shouldKeepCommunityProfile =
        profileUserId != null &&
        state.communityProfile?.userId == profileUserId;
    final shouldKeepCommunityStatsLoading =
        profileUserId != null &&
        _loadingCommunityProfileUserId == profileUserId;

    if (profileUserId == null || profileUserId.isEmpty) {
      _loadingCommunityProfileUserId = null;
      _loadedCommunityProfileUserId = null;
    }

    emit(
      state.copyWith(
        pageStatus: mainState.pageStatus,
        isAuthenticated: mainState.isAuthenticated,
        profile: profile,
        communityProfile: shouldKeepCommunityProfile
            ? state.communityProfile
            : null,
        communityStatsLoading: shouldKeepCommunityProfile
            ? state.communityStatsLoading
            : shouldKeepCommunityStatsLoading,
        processing: mainState.processing,
        failure: mainState.failure,
      ),
    );

    if (mainState.pageStatus == PageStatus.loaded &&
        mainState.isAuthenticated &&
        profile != null) {
      _requestCommunityStats(profile.id);
    }
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
    _requestCommunityStats(cachedProfile.id);
  }

  void _requestCommunityStats(String userId) {
    final normalizedUserId = userId.trim();
    if (normalizedUserId.isEmpty ||
        _loadingCommunityProfileUserId == normalizedUserId ||
        _loadedCommunityProfileUserId == normalizedUserId) {
      return;
    }

    _loadingCommunityProfileUserId = normalizedUserId;
    emit(
      state.copyWith(
        communityStatsLoading: true,
        communityProfile: state.communityProfile?.userId == normalizedUserId
            ? state.communityProfile
            : null,
      ),
    );
    unawaited(_loadCommunityStats(normalizedUserId));
  }

  Future<void> _loadCommunityStats(String userId) async {
    final result = await _getCommunityProfileUseCase(
      GetCommunityProfileParams(userId: userId),
    );
    if (isClosed || _loadingCommunityProfileUserId != userId) {
      return;
    }

    _loadingCommunityProfileUserId = null;
    result.map(
      success: (profile) {
        _loadedCommunityProfileUserId = userId;
        emit(
          state.copyWith(
            communityProfile: profile,
            communityStatsLoading: false,
          ),
        );
      },
      failure: (_) {
        emit(state.copyWith(communityStatsLoading: false));
      },
    );
  }

  void _handleCommunityEvent(AppCommunityEvent event) {
    if (event.isFallbackRefresh) {
      _invalidateCommunityStats();
      return;
    }

    switch (event.table) {
      case 'community_posts':
        _patchPostStats(event);
        break;
      case 'community_follows':
        _patchFollowStats(event);
        break;
    }
  }

  void _patchPostStats(AppCommunityEvent event) {
    final communityProfile = state.communityProfile;
    final userId = state.profile?.id.trim() ?? communityProfile?.userId ?? '';
    if (communityProfile == null || userId.isEmpty) {
      return;
    }

    final postUserId = event.valueOf('user_id');
    if (postUserId.isEmpty && event.isDeleted) {
      _reloadCommunityStats(userId);
      return;
    }

    if (postUserId != userId) {
      return;
    }

    final delta = switch (event.action) {
      AppCommunityRealtimeAction.inserted => 1,
      AppCommunityRealtimeAction.deleted => -1,
      _ => 0,
    };
    if (delta == 0) {
      return;
    }

    emit(
      state.copyWith(
        communityProfile: communityProfile.copyWith(
          postCount: (communityProfile.postCount + delta).clamp(0, 999999),
        ),
      ),
    );
  }

  void _patchFollowStats(AppCommunityEvent event) {
    final communityProfile = state.communityProfile;
    final userId = state.profile?.id.trim() ?? communityProfile?.userId ?? '';
    if (communityProfile == null || userId.isEmpty) {
      return;
    }

    final followerId = event.valueOf('follower_id');
    final followingId = event.valueOf('following_id');
    if (followerId != userId && followingId != userId) {
      return;
    }

    final delta = switch (event.action) {
      AppCommunityRealtimeAction.inserted => 1,
      AppCommunityRealtimeAction.deleted => -1,
      _ => 0,
    };
    if (delta == 0) {
      return;
    }

    emit(
      state.copyWith(
        communityProfile: communityProfile.copyWith(
          followerCount: followingId == userId
              ? (communityProfile.followerCount + delta).clamp(0, 999999)
              : communityProfile.followerCount,
          followingCount: followerId == userId
              ? (communityProfile.followingCount + delta).clamp(0, 999999)
              : communityProfile.followingCount,
        ),
      ),
    );
  }

  void _invalidateCommunityStats() {
    _loadedCommunityProfileUserId = null;
  }

  void _reloadCommunityStats(String userId) {
    _invalidateCommunityStats();
    _requestCommunityStats(userId);
  }

  @override
  Future<void> close() async {
    await _mainSubscription.cancel();
    await _communitySubscription.cancel();
    return super.close();
  }
}
