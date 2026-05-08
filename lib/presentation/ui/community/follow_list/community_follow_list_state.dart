import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imovie_app/config/refresh/imovie_refresh_config.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/domain/entities/community/community_profile.dart';
import 'package:imovie_app/presentation/ui/community/follow_list/community_follow_list_type.dart';

part 'community_follow_list_state.freezed.dart';

@freezed
abstract class CommunityFollowListState
    with _$CommunityFollowListState
    implements BaseState {
  const CommunityFollowListState._();

  const factory CommunityFollowListState({
    required String userId,
    required CommunityFollowListType type,
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    AppFailure? failure,
    @Default(<CommunityProfile>[]) List<CommunityProfile> profiles,
    @Default(1) int page,
    @Default(IMovieRefreshConfig.communityPageSize) int pageSize,
    @Default(true) bool hasMore,
    @Default(false) bool loadingMore,
  }) = _CommunityFollowListState;

  @override
  CommunityFollowListState copyWithBase({
    PageStatus? pageStatus,
    bool? processing,
    AppFailure? failure,
    bool clearFailure = false,
  }) {
    return copyWith(
      pageStatus: pageStatus ?? this.pageStatus,
      processing: processing ?? this.processing,
      failure: clearFailure ? null : failure ?? this.failure,
    );
  }
}
