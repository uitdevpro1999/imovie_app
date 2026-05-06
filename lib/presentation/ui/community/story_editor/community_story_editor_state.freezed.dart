// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_story_editor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CommunityStoryEditorState {

 PageStatus get pageStatus; bool get processing; bool get resolvingLocation; bool get searchingMovies; AppFailure? get failure; XFile? get selectedImage; String get storyText; String get locationName; String get selectedMovieTitle; String get selectedMovieSlug; String get selectedMoviePosterUrl; double get textPositionX; double get textPositionY; double get moviePositionX; double get moviePositionY; double get locationPositionX; double get locationPositionY; List<HomeMovie> get movieSearchResults;
/// Create a copy of CommunityStoryEditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityStoryEditorStateCopyWith<CommunityStoryEditorState> get copyWith => _$CommunityStoryEditorStateCopyWithImpl<CommunityStoryEditorState>(this as CommunityStoryEditorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityStoryEditorState&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.resolvingLocation, resolvingLocation) || other.resolvingLocation == resolvingLocation)&&(identical(other.searchingMovies, searchingMovies) || other.searchingMovies == searchingMovies)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.selectedImage, selectedImage) || other.selectedImage == selectedImage)&&(identical(other.storyText, storyText) || other.storyText == storyText)&&(identical(other.locationName, locationName) || other.locationName == locationName)&&(identical(other.selectedMovieTitle, selectedMovieTitle) || other.selectedMovieTitle == selectedMovieTitle)&&(identical(other.selectedMovieSlug, selectedMovieSlug) || other.selectedMovieSlug == selectedMovieSlug)&&(identical(other.selectedMoviePosterUrl, selectedMoviePosterUrl) || other.selectedMoviePosterUrl == selectedMoviePosterUrl)&&(identical(other.textPositionX, textPositionX) || other.textPositionX == textPositionX)&&(identical(other.textPositionY, textPositionY) || other.textPositionY == textPositionY)&&(identical(other.moviePositionX, moviePositionX) || other.moviePositionX == moviePositionX)&&(identical(other.moviePositionY, moviePositionY) || other.moviePositionY == moviePositionY)&&(identical(other.locationPositionX, locationPositionX) || other.locationPositionX == locationPositionX)&&(identical(other.locationPositionY, locationPositionY) || other.locationPositionY == locationPositionY)&&const DeepCollectionEquality().equals(other.movieSearchResults, movieSearchResults));
}


@override
int get hashCode => Object.hash(runtimeType,pageStatus,processing,resolvingLocation,searchingMovies,failure,selectedImage,storyText,locationName,selectedMovieTitle,selectedMovieSlug,selectedMoviePosterUrl,textPositionX,textPositionY,moviePositionX,moviePositionY,locationPositionX,locationPositionY,const DeepCollectionEquality().hash(movieSearchResults));

@override
String toString() {
  return 'CommunityStoryEditorState(pageStatus: $pageStatus, processing: $processing, resolvingLocation: $resolvingLocation, searchingMovies: $searchingMovies, failure: $failure, selectedImage: $selectedImage, storyText: $storyText, locationName: $locationName, selectedMovieTitle: $selectedMovieTitle, selectedMovieSlug: $selectedMovieSlug, selectedMoviePosterUrl: $selectedMoviePosterUrl, textPositionX: $textPositionX, textPositionY: $textPositionY, moviePositionX: $moviePositionX, moviePositionY: $moviePositionY, locationPositionX: $locationPositionX, locationPositionY: $locationPositionY, movieSearchResults: $movieSearchResults)';
}


}

/// @nodoc
abstract mixin class $CommunityStoryEditorStateCopyWith<$Res>  {
  factory $CommunityStoryEditorStateCopyWith(CommunityStoryEditorState value, $Res Function(CommunityStoryEditorState) _then) = _$CommunityStoryEditorStateCopyWithImpl;
@useResult
$Res call({
 PageStatus pageStatus, bool processing, bool resolvingLocation, bool searchingMovies, AppFailure? failure, XFile? selectedImage, String storyText, String locationName, String selectedMovieTitle, String selectedMovieSlug, String selectedMoviePosterUrl, double textPositionX, double textPositionY, double moviePositionX, double moviePositionY, double locationPositionX, double locationPositionY, List<HomeMovie> movieSearchResults
});


$AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$CommunityStoryEditorStateCopyWithImpl<$Res>
    implements $CommunityStoryEditorStateCopyWith<$Res> {
  _$CommunityStoryEditorStateCopyWithImpl(this._self, this._then);

  final CommunityStoryEditorState _self;
  final $Res Function(CommunityStoryEditorState) _then;

/// Create a copy of CommunityStoryEditorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pageStatus = null,Object? processing = null,Object? resolvingLocation = null,Object? searchingMovies = null,Object? failure = freezed,Object? selectedImage = freezed,Object? storyText = null,Object? locationName = null,Object? selectedMovieTitle = null,Object? selectedMovieSlug = null,Object? selectedMoviePosterUrl = null,Object? textPositionX = null,Object? textPositionY = null,Object? moviePositionX = null,Object? moviePositionY = null,Object? locationPositionX = null,Object? locationPositionY = null,Object? movieSearchResults = null,}) {
  return _then(_self.copyWith(
pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,resolvingLocation: null == resolvingLocation ? _self.resolvingLocation : resolvingLocation // ignore: cast_nullable_to_non_nullable
as bool,searchingMovies: null == searchingMovies ? _self.searchingMovies : searchingMovies // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,selectedImage: freezed == selectedImage ? _self.selectedImage : selectedImage // ignore: cast_nullable_to_non_nullable
as XFile?,storyText: null == storyText ? _self.storyText : storyText // ignore: cast_nullable_to_non_nullable
as String,locationName: null == locationName ? _self.locationName : locationName // ignore: cast_nullable_to_non_nullable
as String,selectedMovieTitle: null == selectedMovieTitle ? _self.selectedMovieTitle : selectedMovieTitle // ignore: cast_nullable_to_non_nullable
as String,selectedMovieSlug: null == selectedMovieSlug ? _self.selectedMovieSlug : selectedMovieSlug // ignore: cast_nullable_to_non_nullable
as String,selectedMoviePosterUrl: null == selectedMoviePosterUrl ? _self.selectedMoviePosterUrl : selectedMoviePosterUrl // ignore: cast_nullable_to_non_nullable
as String,textPositionX: null == textPositionX ? _self.textPositionX : textPositionX // ignore: cast_nullable_to_non_nullable
as double,textPositionY: null == textPositionY ? _self.textPositionY : textPositionY // ignore: cast_nullable_to_non_nullable
as double,moviePositionX: null == moviePositionX ? _self.moviePositionX : moviePositionX // ignore: cast_nullable_to_non_nullable
as double,moviePositionY: null == moviePositionY ? _self.moviePositionY : moviePositionY // ignore: cast_nullable_to_non_nullable
as double,locationPositionX: null == locationPositionX ? _self.locationPositionX : locationPositionX // ignore: cast_nullable_to_non_nullable
as double,locationPositionY: null == locationPositionY ? _self.locationPositionY : locationPositionY // ignore: cast_nullable_to_non_nullable
as double,movieSearchResults: null == movieSearchResults ? _self.movieSearchResults : movieSearchResults // ignore: cast_nullable_to_non_nullable
as List<HomeMovie>,
  ));
}
/// Create a copy of CommunityStoryEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppFailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $AppFailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}


/// Adds pattern-matching-related methods to [CommunityStoryEditorState].
extension CommunityStoryEditorStatePatterns on CommunityStoryEditorState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityStoryEditorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityStoryEditorState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityStoryEditorState value)  $default,){
final _that = this;
switch (_that) {
case _CommunityStoryEditorState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityStoryEditorState value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityStoryEditorState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PageStatus pageStatus,  bool processing,  bool resolvingLocation,  bool searchingMovies,  AppFailure? failure,  XFile? selectedImage,  String storyText,  String locationName,  String selectedMovieTitle,  String selectedMovieSlug,  String selectedMoviePosterUrl,  double textPositionX,  double textPositionY,  double moviePositionX,  double moviePositionY,  double locationPositionX,  double locationPositionY,  List<HomeMovie> movieSearchResults)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityStoryEditorState() when $default != null:
return $default(_that.pageStatus,_that.processing,_that.resolvingLocation,_that.searchingMovies,_that.failure,_that.selectedImage,_that.storyText,_that.locationName,_that.selectedMovieTitle,_that.selectedMovieSlug,_that.selectedMoviePosterUrl,_that.textPositionX,_that.textPositionY,_that.moviePositionX,_that.moviePositionY,_that.locationPositionX,_that.locationPositionY,_that.movieSearchResults);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PageStatus pageStatus,  bool processing,  bool resolvingLocation,  bool searchingMovies,  AppFailure? failure,  XFile? selectedImage,  String storyText,  String locationName,  String selectedMovieTitle,  String selectedMovieSlug,  String selectedMoviePosterUrl,  double textPositionX,  double textPositionY,  double moviePositionX,  double moviePositionY,  double locationPositionX,  double locationPositionY,  List<HomeMovie> movieSearchResults)  $default,) {final _that = this;
switch (_that) {
case _CommunityStoryEditorState():
return $default(_that.pageStatus,_that.processing,_that.resolvingLocation,_that.searchingMovies,_that.failure,_that.selectedImage,_that.storyText,_that.locationName,_that.selectedMovieTitle,_that.selectedMovieSlug,_that.selectedMoviePosterUrl,_that.textPositionX,_that.textPositionY,_that.moviePositionX,_that.moviePositionY,_that.locationPositionX,_that.locationPositionY,_that.movieSearchResults);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PageStatus pageStatus,  bool processing,  bool resolvingLocation,  bool searchingMovies,  AppFailure? failure,  XFile? selectedImage,  String storyText,  String locationName,  String selectedMovieTitle,  String selectedMovieSlug,  String selectedMoviePosterUrl,  double textPositionX,  double textPositionY,  double moviePositionX,  double moviePositionY,  double locationPositionX,  double locationPositionY,  List<HomeMovie> movieSearchResults)?  $default,) {final _that = this;
switch (_that) {
case _CommunityStoryEditorState() when $default != null:
return $default(_that.pageStatus,_that.processing,_that.resolvingLocation,_that.searchingMovies,_that.failure,_that.selectedImage,_that.storyText,_that.locationName,_that.selectedMovieTitle,_that.selectedMovieSlug,_that.selectedMoviePosterUrl,_that.textPositionX,_that.textPositionY,_that.moviePositionX,_that.moviePositionY,_that.locationPositionX,_that.locationPositionY,_that.movieSearchResults);case _:
  return null;

}
}

}

/// @nodoc


class _CommunityStoryEditorState extends CommunityStoryEditorState {
  const _CommunityStoryEditorState({this.pageStatus = PageStatus.loaded, this.processing = false, this.resolvingLocation = false, this.searchingMovies = false, this.failure, this.selectedImage, this.storyText = '', this.locationName = '', this.selectedMovieTitle = '', this.selectedMovieSlug = '', this.selectedMoviePosterUrl = '', this.textPositionX = 0.5, this.textPositionY = 0.45, this.moviePositionX = 0.28, this.moviePositionY = 0.78, this.locationPositionX = 0.32, this.locationPositionY = 0.88, final  List<HomeMovie> movieSearchResults = const <HomeMovie>[]}): _movieSearchResults = movieSearchResults,super._();
  

@override@JsonKey() final  PageStatus pageStatus;
@override@JsonKey() final  bool processing;
@override@JsonKey() final  bool resolvingLocation;
@override@JsonKey() final  bool searchingMovies;
@override final  AppFailure? failure;
@override final  XFile? selectedImage;
@override@JsonKey() final  String storyText;
@override@JsonKey() final  String locationName;
@override@JsonKey() final  String selectedMovieTitle;
@override@JsonKey() final  String selectedMovieSlug;
@override@JsonKey() final  String selectedMoviePosterUrl;
@override@JsonKey() final  double textPositionX;
@override@JsonKey() final  double textPositionY;
@override@JsonKey() final  double moviePositionX;
@override@JsonKey() final  double moviePositionY;
@override@JsonKey() final  double locationPositionX;
@override@JsonKey() final  double locationPositionY;
 final  List<HomeMovie> _movieSearchResults;
@override@JsonKey() List<HomeMovie> get movieSearchResults {
  if (_movieSearchResults is EqualUnmodifiableListView) return _movieSearchResults;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_movieSearchResults);
}


/// Create a copy of CommunityStoryEditorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityStoryEditorStateCopyWith<_CommunityStoryEditorState> get copyWith => __$CommunityStoryEditorStateCopyWithImpl<_CommunityStoryEditorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityStoryEditorState&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.resolvingLocation, resolvingLocation) || other.resolvingLocation == resolvingLocation)&&(identical(other.searchingMovies, searchingMovies) || other.searchingMovies == searchingMovies)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.selectedImage, selectedImage) || other.selectedImage == selectedImage)&&(identical(other.storyText, storyText) || other.storyText == storyText)&&(identical(other.locationName, locationName) || other.locationName == locationName)&&(identical(other.selectedMovieTitle, selectedMovieTitle) || other.selectedMovieTitle == selectedMovieTitle)&&(identical(other.selectedMovieSlug, selectedMovieSlug) || other.selectedMovieSlug == selectedMovieSlug)&&(identical(other.selectedMoviePosterUrl, selectedMoviePosterUrl) || other.selectedMoviePosterUrl == selectedMoviePosterUrl)&&(identical(other.textPositionX, textPositionX) || other.textPositionX == textPositionX)&&(identical(other.textPositionY, textPositionY) || other.textPositionY == textPositionY)&&(identical(other.moviePositionX, moviePositionX) || other.moviePositionX == moviePositionX)&&(identical(other.moviePositionY, moviePositionY) || other.moviePositionY == moviePositionY)&&(identical(other.locationPositionX, locationPositionX) || other.locationPositionX == locationPositionX)&&(identical(other.locationPositionY, locationPositionY) || other.locationPositionY == locationPositionY)&&const DeepCollectionEquality().equals(other._movieSearchResults, _movieSearchResults));
}


@override
int get hashCode => Object.hash(runtimeType,pageStatus,processing,resolvingLocation,searchingMovies,failure,selectedImage,storyText,locationName,selectedMovieTitle,selectedMovieSlug,selectedMoviePosterUrl,textPositionX,textPositionY,moviePositionX,moviePositionY,locationPositionX,locationPositionY,const DeepCollectionEquality().hash(_movieSearchResults));

@override
String toString() {
  return 'CommunityStoryEditorState(pageStatus: $pageStatus, processing: $processing, resolvingLocation: $resolvingLocation, searchingMovies: $searchingMovies, failure: $failure, selectedImage: $selectedImage, storyText: $storyText, locationName: $locationName, selectedMovieTitle: $selectedMovieTitle, selectedMovieSlug: $selectedMovieSlug, selectedMoviePosterUrl: $selectedMoviePosterUrl, textPositionX: $textPositionX, textPositionY: $textPositionY, moviePositionX: $moviePositionX, moviePositionY: $moviePositionY, locationPositionX: $locationPositionX, locationPositionY: $locationPositionY, movieSearchResults: $movieSearchResults)';
}


}

/// @nodoc
abstract mixin class _$CommunityStoryEditorStateCopyWith<$Res> implements $CommunityStoryEditorStateCopyWith<$Res> {
  factory _$CommunityStoryEditorStateCopyWith(_CommunityStoryEditorState value, $Res Function(_CommunityStoryEditorState) _then) = __$CommunityStoryEditorStateCopyWithImpl;
@override @useResult
$Res call({
 PageStatus pageStatus, bool processing, bool resolvingLocation, bool searchingMovies, AppFailure? failure, XFile? selectedImage, String storyText, String locationName, String selectedMovieTitle, String selectedMovieSlug, String selectedMoviePosterUrl, double textPositionX, double textPositionY, double moviePositionX, double moviePositionY, double locationPositionX, double locationPositionY, List<HomeMovie> movieSearchResults
});


@override $AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$CommunityStoryEditorStateCopyWithImpl<$Res>
    implements _$CommunityStoryEditorStateCopyWith<$Res> {
  __$CommunityStoryEditorStateCopyWithImpl(this._self, this._then);

  final _CommunityStoryEditorState _self;
  final $Res Function(_CommunityStoryEditorState) _then;

/// Create a copy of CommunityStoryEditorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pageStatus = null,Object? processing = null,Object? resolvingLocation = null,Object? searchingMovies = null,Object? failure = freezed,Object? selectedImage = freezed,Object? storyText = null,Object? locationName = null,Object? selectedMovieTitle = null,Object? selectedMovieSlug = null,Object? selectedMoviePosterUrl = null,Object? textPositionX = null,Object? textPositionY = null,Object? moviePositionX = null,Object? moviePositionY = null,Object? locationPositionX = null,Object? locationPositionY = null,Object? movieSearchResults = null,}) {
  return _then(_CommunityStoryEditorState(
pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,resolvingLocation: null == resolvingLocation ? _self.resolvingLocation : resolvingLocation // ignore: cast_nullable_to_non_nullable
as bool,searchingMovies: null == searchingMovies ? _self.searchingMovies : searchingMovies // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,selectedImage: freezed == selectedImage ? _self.selectedImage : selectedImage // ignore: cast_nullable_to_non_nullable
as XFile?,storyText: null == storyText ? _self.storyText : storyText // ignore: cast_nullable_to_non_nullable
as String,locationName: null == locationName ? _self.locationName : locationName // ignore: cast_nullable_to_non_nullable
as String,selectedMovieTitle: null == selectedMovieTitle ? _self.selectedMovieTitle : selectedMovieTitle // ignore: cast_nullable_to_non_nullable
as String,selectedMovieSlug: null == selectedMovieSlug ? _self.selectedMovieSlug : selectedMovieSlug // ignore: cast_nullable_to_non_nullable
as String,selectedMoviePosterUrl: null == selectedMoviePosterUrl ? _self.selectedMoviePosterUrl : selectedMoviePosterUrl // ignore: cast_nullable_to_non_nullable
as String,textPositionX: null == textPositionX ? _self.textPositionX : textPositionX // ignore: cast_nullable_to_non_nullable
as double,textPositionY: null == textPositionY ? _self.textPositionY : textPositionY // ignore: cast_nullable_to_non_nullable
as double,moviePositionX: null == moviePositionX ? _self.moviePositionX : moviePositionX // ignore: cast_nullable_to_non_nullable
as double,moviePositionY: null == moviePositionY ? _self.moviePositionY : moviePositionY // ignore: cast_nullable_to_non_nullable
as double,locationPositionX: null == locationPositionX ? _self.locationPositionX : locationPositionX // ignore: cast_nullable_to_non_nullable
as double,locationPositionY: null == locationPositionY ? _self.locationPositionY : locationPositionY // ignore: cast_nullable_to_non_nullable
as double,movieSearchResults: null == movieSearchResults ? _self._movieSearchResults : movieSearchResults // ignore: cast_nullable_to_non_nullable
as List<HomeMovie>,
  ));
}

/// Create a copy of CommunityStoryEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppFailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $AppFailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
