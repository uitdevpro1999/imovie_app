import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/domain/entities/community/community_story.dart';

part 'community_story_viewer_state.freezed.dart';

@freezed
abstract class CommunityStoryViewerState
    with _$CommunityStoryViewerState
    implements BaseState {
  const CommunityStoryViewerState._();

  const factory CommunityStoryViewerState({
    required String storyId,
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    AppFailure? failure,
    @Default(<CommunityStory>[]) List<CommunityStory> stories,
    @Default(0) int initialIndex,
  }) = _CommunityStoryViewerState;

  @override
  CommunityStoryViewerState copyWithBase({
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
