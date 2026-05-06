// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_trailer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MovieTrailerState {

 String get title; String get trailerUrl; String get videoId; PageStatus get pageStatus; bool get processing; AppFailure? get failure;
/// Create a copy of MovieTrailerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MovieTrailerStateCopyWith<MovieTrailerState> get copyWith => _$MovieTrailerStateCopyWithImpl<MovieTrailerState>(this as MovieTrailerState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MovieTrailerState&&(identical(other.title, title) || other.title == title)&&(identical(other.trailerUrl, trailerUrl) || other.trailerUrl == trailerUrl)&&(identical(other.videoId, videoId) || other.videoId == videoId)&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,title,trailerUrl,videoId,pageStatus,processing,failure);

@override
String toString() {
  return 'MovieTrailerState(title: $title, trailerUrl: $trailerUrl, videoId: $videoId, pageStatus: $pageStatus, processing: $processing, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $MovieTrailerStateCopyWith<$Res>  {
  factory $MovieTrailerStateCopyWith(MovieTrailerState value, $Res Function(MovieTrailerState) _then) = _$MovieTrailerStateCopyWithImpl;
@useResult
$Res call({
 String title, String trailerUrl, String videoId, PageStatus pageStatus, bool processing, AppFailure? failure
});


$AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$MovieTrailerStateCopyWithImpl<$Res>
    implements $MovieTrailerStateCopyWith<$Res> {
  _$MovieTrailerStateCopyWithImpl(this._self, this._then);

  final MovieTrailerState _self;
  final $Res Function(MovieTrailerState) _then;

/// Create a copy of MovieTrailerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? trailerUrl = null,Object? videoId = null,Object? pageStatus = null,Object? processing = null,Object? failure = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,trailerUrl: null == trailerUrl ? _self.trailerUrl : trailerUrl // ignore: cast_nullable_to_non_nullable
as String,videoId: null == videoId ? _self.videoId : videoId // ignore: cast_nullable_to_non_nullable
as String,pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}
/// Create a copy of MovieTrailerState
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


/// Adds pattern-matching-related methods to [MovieTrailerState].
extension MovieTrailerStatePatterns on MovieTrailerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MovieTrailerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MovieTrailerState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MovieTrailerState value)  $default,){
final _that = this;
switch (_that) {
case _MovieTrailerState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MovieTrailerState value)?  $default,){
final _that = this;
switch (_that) {
case _MovieTrailerState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String trailerUrl,  String videoId,  PageStatus pageStatus,  bool processing,  AppFailure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MovieTrailerState() when $default != null:
return $default(_that.title,_that.trailerUrl,_that.videoId,_that.pageStatus,_that.processing,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String trailerUrl,  String videoId,  PageStatus pageStatus,  bool processing,  AppFailure? failure)  $default,) {final _that = this;
switch (_that) {
case _MovieTrailerState():
return $default(_that.title,_that.trailerUrl,_that.videoId,_that.pageStatus,_that.processing,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String trailerUrl,  String videoId,  PageStatus pageStatus,  bool processing,  AppFailure? failure)?  $default,) {final _that = this;
switch (_that) {
case _MovieTrailerState() when $default != null:
return $default(_that.title,_that.trailerUrl,_that.videoId,_that.pageStatus,_that.processing,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _MovieTrailerState extends MovieTrailerState {
  const _MovieTrailerState({required this.title, required this.trailerUrl, this.videoId = '', this.pageStatus = PageStatus.initial, this.processing = false, this.failure}): super._();
  

@override final  String title;
@override final  String trailerUrl;
@override@JsonKey() final  String videoId;
@override@JsonKey() final  PageStatus pageStatus;
@override@JsonKey() final  bool processing;
@override final  AppFailure? failure;

/// Create a copy of MovieTrailerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MovieTrailerStateCopyWith<_MovieTrailerState> get copyWith => __$MovieTrailerStateCopyWithImpl<_MovieTrailerState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MovieTrailerState&&(identical(other.title, title) || other.title == title)&&(identical(other.trailerUrl, trailerUrl) || other.trailerUrl == trailerUrl)&&(identical(other.videoId, videoId) || other.videoId == videoId)&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,title,trailerUrl,videoId,pageStatus,processing,failure);

@override
String toString() {
  return 'MovieTrailerState(title: $title, trailerUrl: $trailerUrl, videoId: $videoId, pageStatus: $pageStatus, processing: $processing, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$MovieTrailerStateCopyWith<$Res> implements $MovieTrailerStateCopyWith<$Res> {
  factory _$MovieTrailerStateCopyWith(_MovieTrailerState value, $Res Function(_MovieTrailerState) _then) = __$MovieTrailerStateCopyWithImpl;
@override @useResult
$Res call({
 String title, String trailerUrl, String videoId, PageStatus pageStatus, bool processing, AppFailure? failure
});


@override $AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$MovieTrailerStateCopyWithImpl<$Res>
    implements _$MovieTrailerStateCopyWith<$Res> {
  __$MovieTrailerStateCopyWithImpl(this._self, this._then);

  final _MovieTrailerState _self;
  final $Res Function(_MovieTrailerState) _then;

/// Create a copy of MovieTrailerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? trailerUrl = null,Object? videoId = null,Object? pageStatus = null,Object? processing = null,Object? failure = freezed,}) {
  return _then(_MovieTrailerState(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,trailerUrl: null == trailerUrl ? _self.trailerUrl : trailerUrl // ignore: cast_nullable_to_non_nullable
as String,videoId: null == videoId ? _self.videoId : videoId // ignore: cast_nullable_to_non_nullable
as String,pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}

/// Create a copy of MovieTrailerState
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
