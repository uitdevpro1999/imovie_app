import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imovie_app/config/refresh/imovie_refresh_config.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/domain/entities/community/community_comment.dart';
import 'package:imovie_app/domain/entities/community/community_post.dart';
import 'package:imovie_app/domain/entities/community/community_story.dart';

part 'community_state.freezed.dart';

@freezed
abstract class CommunityState with _$CommunityState implements BaseState {
  const CommunityState._();

  const factory CommunityState({
    @Default(false) bool mineOnly,
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    AppFailure? failure,
    @Default(<CommunityStory>[]) List<CommunityStory> stories,
    @Default(<CommunityPost>[]) List<CommunityPost> posts,
    @Default(1) int page,
    @Default(IMovieRefreshConfig.communityPageSize) int pageSize,
    @Default(true) bool hasMore,
    @Default(false) bool loadingMore,
    @Default(<String, List<CommunityComment>>{})
    Map<String, List<CommunityComment>> commentsByPost,
    @Default(<String>{}) Set<String> loadingCommentPostIds,
  }) = _CommunityState;

  bool get canLoadMore => hasMore && !loadingMore;

  @override
  CommunityState copyWithBase({
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
