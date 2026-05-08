import 'dart:async';

import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/events/app_community_event.dart';
import 'package:imovie_app/core/events/app_event_bus.dart';
import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/domain/entities/community/community_profile.dart';
import 'package:imovie_app/domain/usecases/community/get_community_followers_use_case.dart';
import 'package:imovie_app/domain/usecases/community/get_community_following_use_case.dart';
import 'package:imovie_app/presentation/ui/community/follow_list/community_follow_list_state.dart';
import 'package:imovie_app/presentation/ui/community/follow_list/community_follow_list_type.dart';

class CommunityFollowListCubit extends BaseCubit<CommunityFollowListState> {
  CommunityFollowListCubit({
    required String userId,
    required String typeSlug,
    required GetCommunityFollowersUseCase getCommunityFollowersUseCase,
    required GetCommunityFollowingUseCase getCommunityFollowingUseCase,
  }) : _getCommunityFollowersUseCase = getCommunityFollowersUseCase,
       _getCommunityFollowingUseCase = getCommunityFollowingUseCase,
       super(
         CommunityFollowListState(
           userId: userId,
           type: communityFollowListTypeFromSlug(typeSlug),
         ),
       ) {
    _communitySubscription = appEventBus.communityStream.listen(
      _handleCommunityEvent,
    );
  }

  static const _initialPage = 1;

  final GetCommunityFollowersUseCase _getCommunityFollowersUseCase;
  final GetCommunityFollowingUseCase _getCommunityFollowingUseCase;
  late final StreamSubscription<AppCommunityEvent> _communitySubscription;

  @override
  Future<void> initData() async {
    await load();
  }

  Future<bool> load({bool showLoading = true}) async {
    final targetUserId = state.userId.trim();
    if (targetUserId.isEmpty) {
      final failure = AppFailure.unknown('Community user id is empty.');
      emit(
        state.copyWith(
          pageStatus: PageStatus.error,
          processing: false,
          failure: failure,
        ),
      );
      showFailureToast(failure);
      return false;
    }

    if (showLoading) {
      emit(
        state.copyWith(
          pageStatus: state.profiles.isEmpty
              ? PageStatus.loading
              : PageStatus.loaded,
          processing: state.profiles.isNotEmpty,
          failure: null,
        ),
      );
    } else {
      emit(state.copyWith(failure: null));
    }

    final result = await _getProfiles(page: _initialPage);
    return result.map(
      success: (profiles) {
        emit(
          state.copyWith(
            pageStatus: PageStatus.loaded,
            processing: false,
            failure: null,
            profiles: profiles,
            page: _initialPage,
            hasMore: profiles.length == state.pageSize,
            loadingMore: false,
          ),
        );
        return true;
      },
      failure: (failure) {
        emit(
          state.copyWith(
            pageStatus: showLoading && state.profiles.isEmpty
                ? PageStatus.error
                : PageStatus.loaded,
            processing: false,
            failure: failure,
            loadingMore: false,
          ),
        );
        showFailureToast(failure);
        return false;
      },
    );
  }

  Future<bool> refresh() => load(showLoading: false);

  Future<void> _handleCommunityEvent(AppCommunityEvent event) async {
    if (event.isFallbackRefresh) {
      await refresh();
      return;
    }

    if (event.table == 'community_follows') {
      final followerId = event.valueOf('follower_id');
      final followingId = event.valueOf('following_id');
      final visibleUserIds = state.profiles
          .map((profile) => profile.userId)
          .toSet();
      if (followerId == state.userId ||
          followingId == state.userId ||
          visibleUserIds.contains(followerId) ||
          visibleUserIds.contains(followingId)) {
        await refresh();
      }
      return;
    }

    if (event.table == 'profiles') {
      final targetUserId = event.valueOfAny(const ['id', 'user_id']);
      if (targetUserId == state.userId ||
          state.profiles.any((profile) => profile.userId == targetUserId)) {
        await refresh();
      }
    }
  }

  Future<bool> loadMore() async {
    if (state.loadingMore || !state.hasMore) {
      return true;
    }

    final nextPage = state.page + 1;
    emit(state.copyWith(loadingMore: true, failure: null));
    final result = await _getProfiles(page: nextPage);
    return result.map(
      success: (profiles) {
        final existingIds = state.profiles.map((item) => item.userId).toSet();
        final nextProfiles = profiles
            .where((profile) => !existingIds.contains(profile.userId))
            .toList(growable: false);
        emit(
          state.copyWith(
            profiles: [...state.profiles, ...nextProfiles],
            page: nextPage,
            hasMore: profiles.length == state.pageSize,
            loadingMore: false,
            failure: null,
          ),
        );
        return true;
      },
      failure: (failure) {
        emit(state.copyWith(loadingMore: false, failure: failure));
        showFailureToast(failure);
        return false;
      },
    );
  }

  Future<Result<List<CommunityProfile>>> _getProfiles({required int page}) {
    return switch (state.type) {
      CommunityFollowListType.followers => _getCommunityFollowersUseCase(
        GetCommunityFollowersParams(
          userId: state.userId,
          page: page,
          limit: state.pageSize,
        ),
      ),
      CommunityFollowListType.following => _getCommunityFollowingUseCase(
        GetCommunityFollowingParams(
          userId: state.userId,
          page: page,
          limit: state.pageSize,
        ),
      ),
    };
  }

  @override
  Future<void> close() async {
    await _communitySubscription.cancel();
    return super.close();
  }
}
