// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_compose_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CommunityComposeState {

 CommunityPost? get initialPost; PageStatus get pageStatus; bool get processing; bool get resolvingLocation; bool get searchingMovies; AppFailure? get failure; List<XFile> get selectedImages; List<String> get existingImageUrls; String get locationName; String get locationFullName; String get selectedMovieTitle; String get selectedMovieSlug; String get selectedMoviePosterUrl; List<HomeMovie> get movieSearchResults;
/// Create a copy of CommunityComposeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityComposeStateCopyWith<CommunityComposeState> get copyWith => _$CommunityComposeStateCopyWithImpl<CommunityComposeState>(this as CommunityComposeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityComposeState&&(identical(other.initialPost, initialPost) || other.initialPost == initialPost)&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.resolvingLocation, resolvingLocation) || other.resolvingLocation == resolvingLocation)&&(identical(other.searchingMovies, searchingMovies) || other.searchingMovies == searchingMovies)&&(identical(other.failure, failure) || other.failure == failure)&&const DeepCollectionEquality().equals(other.selectedImages, selectedImages)&&const DeepCollectionEquality().equals(other.existingImageUrls, existingImageUrls)&&(identical(other.locationName, locationName) || other.locationName == locationName)&&(identical(other.locationFullName, locationFullName) || other.locationFullName == locationFullName)&&(identical(other.selectedMovieTitle, selectedMovieTitle) || other.selectedMovieTitle == selectedMovieTitle)&&(identical(other.selectedMovieSlug, selectedMovieSlug) || other.selectedMovieSlug == selectedMovieSlug)&&(identical(other.selectedMoviePosterUrl, selectedMoviePosterUrl) || other.selectedMoviePosterUrl == selectedMoviePosterUrl)&&const DeepCollectionEquality().equals(other.movieSearchResults, movieSearchResults));
}


@override
int get hashCode => Object.hash(runtimeType,initialPost,pageStatus,processing,resolvingLocation,searchingMovies,failure,const DeepCollectionEquality().hash(selectedImages),const DeepCollectionEquality().hash(existingImageUrls),locationName,locationFullName,selectedMovieTitle,selectedMovieSlug,selectedMoviePosterUrl,const DeepCollectionEquality().hash(movieSearchResults));

@override
String toString() {
  return 'CommunityComposeState(initialPost: $initialPost, pageStatus: $pageStatus, processing: $processing, resolvingLocation: $resolvingLocation, searchingMovies: $searchingMovies, failure: $failure, selectedImages: $selectedImages, existingImageUrls: $existingImageUrls, locationName: $locationName, locationFullName: $locationFullName, selectedMovieTitle: $selectedMovieTitle, selectedMovieSlug: $selectedMovieSlug, selectedMoviePosterUrl: $selectedMoviePosterUrl, movieSearchResults: $movieSearchResults)';
}


}

/// @nodoc
abstract mixin class $CommunityComposeStateCopyWith<$Res>  {
  factory $CommunityComposeStateCopyWith(CommunityComposeState value, $Res Function(CommunityComposeState) _then) = _$CommunityComposeStateCopyWithImpl;
@useResult
$Res call({
 CommunityPost? initialPost, PageStatus pageStatus, bool processing, bool resolvingLocation, bool searchingMovies, AppFailure? failure, List<XFile> selectedImages, List<String> existingImageUrls, String locationName, String locationFullName, String selectedMovieTitle, String selectedMovieSlug, String selectedMoviePosterUrl, List<HomeMovie> movieSearchResults
});


$AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$CommunityComposeStateCopyWithImpl<$Res>
    implements $CommunityComposeStateCopyWith<$Res> {
  _$CommunityComposeStateCopyWithImpl(this._self, this._then);

  final CommunityComposeState _self;
  final $Res Function(CommunityComposeState) _then;

/// Create a copy of CommunityComposeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? initialPost = freezed,Object? pageStatus = null,Object? processing = null,Object? resolvingLocation = null,Object? searchingMovies = null,Object? failure = freezed,Object? selectedImages = null,Object? existingImageUrls = null,Object? locationName = null,Object? locationFullName = null,Object? selectedMovieTitle = null,Object? selectedMovieSlug = null,Object? selectedMoviePosterUrl = null,Object? movieSearchResults = null,}) {
  return _then(_self.copyWith(
initialPost: freezed == initialPost ? _self.initialPost : initialPost // ignore: cast_nullable_to_non_nullable
as CommunityPost?,pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,resolvingLocation: null == resolvingLocation ? _self.resolvingLocation : resolvingLocation // ignore: cast_nullable_to_non_nullable
as bool,searchingMovies: null == searchingMovies ? _self.searchingMovies : searchingMovies // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,selectedImages: null == selectedImages ? _self.selectedImages : selectedImages // ignore: cast_nullable_to_non_nullable
as List<XFile>,existingImageUrls: null == existingImageUrls ? _self.existingImageUrls : existingImageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,locationName: null == locationName ? _self.locationName : locationName // ignore: cast_nullable_to_non_nullable
as String,locationFullName: null == locationFullName ? _self.locationFullName : locationFullName // ignore: cast_nullable_to_non_nullable
as String,selectedMovieTitle: null == selectedMovieTitle ? _self.selectedMovieTitle : selectedMovieTitle // ignore: cast_nullable_to_non_nullable
as String,selectedMovieSlug: null == selectedMovieSlug ? _self.selectedMovieSlug : selectedMovieSlug // ignore: cast_nullable_to_non_nullable
as String,selectedMoviePosterUrl: null == selectedMoviePosterUrl ? _self.selectedMoviePosterUrl : selectedMoviePosterUrl // ignore: cast_nullable_to_non_nullable
as String,movieSearchResults: null == movieSearchResults ? _self.movieSearchResults : movieSearchResults // ignore: cast_nullable_to_non_nullable
as List<HomeMovie>,
  ));
}
/// Create a copy of CommunityComposeState
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


/// Adds pattern-matching-related methods to [CommunityComposeState].
extension CommunityComposeStatePatterns on CommunityComposeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityComposeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityComposeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityComposeState value)  $default,){
final _that = this;
switch (_that) {
case _CommunityComposeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityComposeState value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityComposeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CommunityPost? initialPost,  PageStatus pageStatus,  bool processing,  bool resolvingLocation,  bool searchingMovies,  AppFailure? failure,  List<XFile> selectedImages,  List<String> existingImageUrls,  String locationName,  String locationFullName,  String selectedMovieTitle,  String selectedMovieSlug,  String selectedMoviePosterUrl,  List<HomeMovie> movieSearchResults)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityComposeState() when $default != null:
return $default(_that.initialPost,_that.pageStatus,_that.processing,_that.resolvingLocation,_that.searchingMovies,_that.failure,_that.selectedImages,_that.existingImageUrls,_that.locationName,_that.locationFullName,_that.selectedMovieTitle,_that.selectedMovieSlug,_that.selectedMoviePosterUrl,_that.movieSearchResults);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CommunityPost? initialPost,  PageStatus pageStatus,  bool processing,  bool resolvingLocation,  bool searchingMovies,  AppFailure? failure,  List<XFile> selectedImages,  List<String> existingImageUrls,  String locationName,  String locationFullName,  String selectedMovieTitle,  String selectedMovieSlug,  String selectedMoviePosterUrl,  List<HomeMovie> movieSearchResults)  $default,) {final _that = this;
switch (_that) {
case _CommunityComposeState():
return $default(_that.initialPost,_that.pageStatus,_that.processing,_that.resolvingLocation,_that.searchingMovies,_that.failure,_that.selectedImages,_that.existingImageUrls,_that.locationName,_that.locationFullName,_that.selectedMovieTitle,_that.selectedMovieSlug,_that.selectedMoviePosterUrl,_that.movieSearchResults);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CommunityPost? initialPost,  PageStatus pageStatus,  bool processing,  bool resolvingLocation,  bool searchingMovies,  AppFailure? failure,  List<XFile> selectedImages,  List<String> existingImageUrls,  String locationName,  String locationFullName,  String selectedMovieTitle,  String selectedMovieSlug,  String selectedMoviePosterUrl,  List<HomeMovie> movieSearchResults)?  $default,) {final _that = this;
switch (_that) {
case _CommunityComposeState() when $default != null:
return $default(_that.initialPost,_that.pageStatus,_that.processing,_that.resolvingLocation,_that.searchingMovies,_that.failure,_that.selectedImages,_that.existingImageUrls,_that.locationName,_that.locationFullName,_that.selectedMovieTitle,_that.selectedMovieSlug,_that.selectedMoviePosterUrl,_that.movieSearchResults);case _:
  return null;

}
}

}

/// @nodoc


class _CommunityComposeState extends CommunityComposeState {
  const _CommunityComposeState({this.initialPost, this.pageStatus = PageStatus.loaded, this.processing = false, this.resolvingLocation = false, this.searchingMovies = false, this.failure, final  List<XFile> selectedImages = const <XFile>[], final  List<String> existingImageUrls = const <String>[], this.locationName = '', this.locationFullName = '', this.selectedMovieTitle = '', this.selectedMovieSlug = '', this.selectedMoviePosterUrl = '', final  List<HomeMovie> movieSearchResults = const <HomeMovie>[]}): _selectedImages = selectedImages,_existingImageUrls = existingImageUrls,_movieSearchResults = movieSearchResults,super._();
  

@override final  CommunityPost? initialPost;
@override@JsonKey() final  PageStatus pageStatus;
@override@JsonKey() final  bool processing;
@override@JsonKey() final  bool resolvingLocation;
@override@JsonKey() final  bool searchingMovies;
@override final  AppFailure? failure;
 final  List<XFile> _selectedImages;
@override@JsonKey() List<XFile> get selectedImages {
  if (_selectedImages is EqualUnmodifiableListView) return _selectedImages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedImages);
}

 final  List<String> _existingImageUrls;
@override@JsonKey() List<String> get existingImageUrls {
  if (_existingImageUrls is EqualUnmodifiableListView) return _existingImageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_existingImageUrls);
}

@override@JsonKey() final  String locationName;
@override@JsonKey() final  String locationFullName;
@override@JsonKey() final  String selectedMovieTitle;
@override@JsonKey() final  String selectedMovieSlug;
@override@JsonKey() final  String selectedMoviePosterUrl;
 final  List<HomeMovie> _movieSearchResults;
@override@JsonKey() List<HomeMovie> get movieSearchResults {
  if (_movieSearchResults is EqualUnmodifiableListView) return _movieSearchResults;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_movieSearchResults);
}


/// Create a copy of CommunityComposeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityComposeStateCopyWith<_CommunityComposeState> get copyWith => __$CommunityComposeStateCopyWithImpl<_CommunityComposeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityComposeState&&(identical(other.initialPost, initialPost) || other.initialPost == initialPost)&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.resolvingLocation, resolvingLocation) || other.resolvingLocation == resolvingLocation)&&(identical(other.searchingMovies, searchingMovies) || other.searchingMovies == searchingMovies)&&(identical(other.failure, failure) || other.failure == failure)&&const DeepCollectionEquality().equals(other._selectedImages, _selectedImages)&&const DeepCollectionEquality().equals(other._existingImageUrls, _existingImageUrls)&&(identical(other.locationName, locationName) || other.locationName == locationName)&&(identical(other.locationFullName, locationFullName) || other.locationFullName == locationFullName)&&(identical(other.selectedMovieTitle, selectedMovieTitle) || other.selectedMovieTitle == selectedMovieTitle)&&(identical(other.selectedMovieSlug, selectedMovieSlug) || other.selectedMovieSlug == selectedMovieSlug)&&(identical(other.selectedMoviePosterUrl, selectedMoviePosterUrl) || other.selectedMoviePosterUrl == selectedMoviePosterUrl)&&const DeepCollectionEquality().equals(other._movieSearchResults, _movieSearchResults));
}


@override
int get hashCode => Object.hash(runtimeType,initialPost,pageStatus,processing,resolvingLocation,searchingMovies,failure,const DeepCollectionEquality().hash(_selectedImages),const DeepCollectionEquality().hash(_existingImageUrls),locationName,locationFullName,selectedMovieTitle,selectedMovieSlug,selectedMoviePosterUrl,const DeepCollectionEquality().hash(_movieSearchResults));

@override
String toString() {
  return 'CommunityComposeState(initialPost: $initialPost, pageStatus: $pageStatus, processing: $processing, resolvingLocation: $resolvingLocation, searchingMovies: $searchingMovies, failure: $failure, selectedImages: $selectedImages, existingImageUrls: $existingImageUrls, locationName: $locationName, locationFullName: $locationFullName, selectedMovieTitle: $selectedMovieTitle, selectedMovieSlug: $selectedMovieSlug, selectedMoviePosterUrl: $selectedMoviePosterUrl, movieSearchResults: $movieSearchResults)';
}


}

/// @nodoc
abstract mixin class _$CommunityComposeStateCopyWith<$Res> implements $CommunityComposeStateCopyWith<$Res> {
  factory _$CommunityComposeStateCopyWith(_CommunityComposeState value, $Res Function(_CommunityComposeState) _then) = __$CommunityComposeStateCopyWithImpl;
@override @useResult
$Res call({
 CommunityPost? initialPost, PageStatus pageStatus, bool processing, bool resolvingLocation, bool searchingMovies, AppFailure? failure, List<XFile> selectedImages, List<String> existingImageUrls, String locationName, String locationFullName, String selectedMovieTitle, String selectedMovieSlug, String selectedMoviePosterUrl, List<HomeMovie> movieSearchResults
});


@override $AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$CommunityComposeStateCopyWithImpl<$Res>
    implements _$CommunityComposeStateCopyWith<$Res> {
  __$CommunityComposeStateCopyWithImpl(this._self, this._then);

  final _CommunityComposeState _self;
  final $Res Function(_CommunityComposeState) _then;

/// Create a copy of CommunityComposeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? initialPost = freezed,Object? pageStatus = null,Object? processing = null,Object? resolvingLocation = null,Object? searchingMovies = null,Object? failure = freezed,Object? selectedImages = null,Object? existingImageUrls = null,Object? locationName = null,Object? locationFullName = null,Object? selectedMovieTitle = null,Object? selectedMovieSlug = null,Object? selectedMoviePosterUrl = null,Object? movieSearchResults = null,}) {
  return _then(_CommunityComposeState(
initialPost: freezed == initialPost ? _self.initialPost : initialPost // ignore: cast_nullable_to_non_nullable
as CommunityPost?,pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,resolvingLocation: null == resolvingLocation ? _self.resolvingLocation : resolvingLocation // ignore: cast_nullable_to_non_nullable
as bool,searchingMovies: null == searchingMovies ? _self.searchingMovies : searchingMovies // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,selectedImages: null == selectedImages ? _self._selectedImages : selectedImages // ignore: cast_nullable_to_non_nullable
as List<XFile>,existingImageUrls: null == existingImageUrls ? _self._existingImageUrls : existingImageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,locationName: null == locationName ? _self.locationName : locationName // ignore: cast_nullable_to_non_nullable
as String,locationFullName: null == locationFullName ? _self.locationFullName : locationFullName // ignore: cast_nullable_to_non_nullable
as String,selectedMovieTitle: null == selectedMovieTitle ? _self.selectedMovieTitle : selectedMovieTitle // ignore: cast_nullable_to_non_nullable
as String,selectedMovieSlug: null == selectedMovieSlug ? _self.selectedMovieSlug : selectedMovieSlug // ignore: cast_nullable_to_non_nullable
as String,selectedMoviePosterUrl: null == selectedMoviePosterUrl ? _self.selectedMoviePosterUrl : selectedMoviePosterUrl // ignore: cast_nullable_to_non_nullable
as String,movieSearchResults: null == movieSearchResults ? _self._movieSearchResults : movieSearchResults // ignore: cast_nullable_to_non_nullable
as List<HomeMovie>,
  ));
}

/// Create a copy of CommunityComposeState
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
