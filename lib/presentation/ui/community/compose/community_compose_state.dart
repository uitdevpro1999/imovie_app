import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/domain/entities/community/community_post.dart';
import 'package:imovie_app/domain/entities/home/home_movie.dart';

part 'community_compose_state.freezed.dart';

@freezed
abstract class CommunityComposeState
    with _$CommunityComposeState
    implements BaseState {
  const CommunityComposeState._();

  const factory CommunityComposeState({
    CommunityPost? initialPost,
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(false) bool resolvingLocation,
    @Default(false) bool searchingMovies,
    AppFailure? failure,
    XFile? selectedImage,
    @Default('') String locationName,
    @Default('') String selectedMovieTitle,
    @Default('') String selectedMovieSlug,
    @Default('') String selectedMoviePosterUrl,
    @Default(<HomeMovie>[]) List<HomeMovie> movieSearchResults,
  }) = _CommunityComposeState;

  bool get isEditing => initialPost != null;

  @override
  CommunityComposeState copyWithBase({
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
