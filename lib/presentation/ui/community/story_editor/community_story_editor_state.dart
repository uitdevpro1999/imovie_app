import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/domain/entities/home/home_movie.dart';

part 'community_story_editor_state.freezed.dart';

@freezed
abstract class CommunityStoryEditorState
    with _$CommunityStoryEditorState
    implements BaseState {
  const CommunityStoryEditorState._();

  const factory CommunityStoryEditorState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(false) bool resolvingLocation,
    @Default(false) bool searchingMovies,
    AppFailure? failure,
    XFile? selectedImage,
    @Default('') String storyText,
    @Default('') String locationName,
    @Default('') String selectedMovieTitle,
    @Default('') String selectedMovieSlug,
    @Default('') String selectedMoviePosterUrl,
    @Default(0.5) double textPositionX,
    @Default(0.45) double textPositionY,
    @Default(0.28) double moviePositionX,
    @Default(0.78) double moviePositionY,
    @Default(0.32) double locationPositionX,
    @Default(0.88) double locationPositionY,
    @Default(<HomeMovie>[]) List<HomeMovie> movieSearchResults,
  }) = _CommunityStoryEditorState;

  bool get hasImage => selectedImage != null;

  @override
  CommunityStoryEditorState copyWithBase({
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
