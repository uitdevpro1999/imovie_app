import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/domain/entities/community/community_comment.dart';
import 'package:imovie_app/domain/entities/community/community_post.dart';

part 'community_post_detail_state.freezed.dart';

@freezed
abstract class CommunityPostDetailState
    with _$CommunityPostDetailState
    implements BaseState {
  const CommunityPostDetailState._();

  const factory CommunityPostDetailState({
    required String postId,
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    AppFailure? failure,
    CommunityPost? post,
    @Default(<CommunityComment>[]) List<CommunityComment> comments,
    @Default(false) bool loadingComments,
  }) = _CommunityPostDetailState;

  @override
  CommunityPostDetailState copyWithBase({
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
