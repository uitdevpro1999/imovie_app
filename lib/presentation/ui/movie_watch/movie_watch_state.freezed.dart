// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_watch_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MovieWatchState {

 String get slug; PageStatus get pageStatus; bool get processing; AppFailure? get failure; MovieDetail? get detail; int get selectedServerIndex; int get selectedEpisodeIndex;
/// Create a copy of MovieWatchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MovieWatchStateCopyWith<MovieWatchState> get copyWith => _$MovieWatchStateCopyWithImpl<MovieWatchState>(this as MovieWatchState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MovieWatchState&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.selectedServerIndex, selectedServerIndex) || other.selectedServerIndex == selectedServerIndex)&&(identical(other.selectedEpisodeIndex, selectedEpisodeIndex) || other.selectedEpisodeIndex == selectedEpisodeIndex));
}


@override
int get hashCode => Object.hash(runtimeType,slug,pageStatus,processing,failure,detail,selectedServerIndex,selectedEpisodeIndex);

@override
String toString() {
  return 'MovieWatchState(slug: $slug, pageStatus: $pageStatus, processing: $processing, failure: $failure, detail: $detail, selectedServerIndex: $selectedServerIndex, selectedEpisodeIndex: $selectedEpisodeIndex)';
}


}

/// @nodoc
abstract mixin class $MovieWatchStateCopyWith<$Res>  {
  factory $MovieWatchStateCopyWith(MovieWatchState value, $Res Function(MovieWatchState) _then) = _$MovieWatchStateCopyWithImpl;
@useResult
$Res call({
 String slug, PageStatus pageStatus, bool processing, AppFailure? failure, MovieDetail? detail, int selectedServerIndex, int selectedEpisodeIndex
});


$AppFailureCopyWith<$Res>? get failure;$MovieDetailCopyWith<$Res>? get detail;

}
/// @nodoc
class _$MovieWatchStateCopyWithImpl<$Res>
    implements $MovieWatchStateCopyWith<$Res> {
  _$MovieWatchStateCopyWithImpl(this._self, this._then);

  final MovieWatchState _self;
  final $Res Function(MovieWatchState) _then;

/// Create a copy of MovieWatchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? slug = null,Object? pageStatus = null,Object? processing = null,Object? failure = freezed,Object? detail = freezed,Object? selectedServerIndex = null,Object? selectedEpisodeIndex = null,}) {
  return _then(_self.copyWith(
slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as MovieDetail?,selectedServerIndex: null == selectedServerIndex ? _self.selectedServerIndex : selectedServerIndex // ignore: cast_nullable_to_non_nullable
as int,selectedEpisodeIndex: null == selectedEpisodeIndex ? _self.selectedEpisodeIndex : selectedEpisodeIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of MovieWatchState
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
}/// Create a copy of MovieWatchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MovieDetailCopyWith<$Res>? get detail {
    if (_self.detail == null) {
    return null;
  }

  return $MovieDetailCopyWith<$Res>(_self.detail!, (value) {
    return _then(_self.copyWith(detail: value));
  });
}
}


/// Adds pattern-matching-related methods to [MovieWatchState].
extension MovieWatchStatePatterns on MovieWatchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MovieWatchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MovieWatchState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MovieWatchState value)  $default,){
final _that = this;
switch (_that) {
case _MovieWatchState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MovieWatchState value)?  $default,){
final _that = this;
switch (_that) {
case _MovieWatchState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String slug,  PageStatus pageStatus,  bool processing,  AppFailure? failure,  MovieDetail? detail,  int selectedServerIndex,  int selectedEpisodeIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MovieWatchState() when $default != null:
return $default(_that.slug,_that.pageStatus,_that.processing,_that.failure,_that.detail,_that.selectedServerIndex,_that.selectedEpisodeIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String slug,  PageStatus pageStatus,  bool processing,  AppFailure? failure,  MovieDetail? detail,  int selectedServerIndex,  int selectedEpisodeIndex)  $default,) {final _that = this;
switch (_that) {
case _MovieWatchState():
return $default(_that.slug,_that.pageStatus,_that.processing,_that.failure,_that.detail,_that.selectedServerIndex,_that.selectedEpisodeIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String slug,  PageStatus pageStatus,  bool processing,  AppFailure? failure,  MovieDetail? detail,  int selectedServerIndex,  int selectedEpisodeIndex)?  $default,) {final _that = this;
switch (_that) {
case _MovieWatchState() when $default != null:
return $default(_that.slug,_that.pageStatus,_that.processing,_that.failure,_that.detail,_that.selectedServerIndex,_that.selectedEpisodeIndex);case _:
  return null;

}
}

}

/// @nodoc


class _MovieWatchState extends MovieWatchState {
  const _MovieWatchState({required this.slug, this.pageStatus = PageStatus.initial, this.processing = false, this.failure, this.detail, this.selectedServerIndex = 0, this.selectedEpisodeIndex = 0}): super._();
  

@override final  String slug;
@override@JsonKey() final  PageStatus pageStatus;
@override@JsonKey() final  bool processing;
@override final  AppFailure? failure;
@override final  MovieDetail? detail;
@override@JsonKey() final  int selectedServerIndex;
@override@JsonKey() final  int selectedEpisodeIndex;

/// Create a copy of MovieWatchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MovieWatchStateCopyWith<_MovieWatchState> get copyWith => __$MovieWatchStateCopyWithImpl<_MovieWatchState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MovieWatchState&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.selectedServerIndex, selectedServerIndex) || other.selectedServerIndex == selectedServerIndex)&&(identical(other.selectedEpisodeIndex, selectedEpisodeIndex) || other.selectedEpisodeIndex == selectedEpisodeIndex));
}


@override
int get hashCode => Object.hash(runtimeType,slug,pageStatus,processing,failure,detail,selectedServerIndex,selectedEpisodeIndex);

@override
String toString() {
  return 'MovieWatchState(slug: $slug, pageStatus: $pageStatus, processing: $processing, failure: $failure, detail: $detail, selectedServerIndex: $selectedServerIndex, selectedEpisodeIndex: $selectedEpisodeIndex)';
}


}

/// @nodoc
abstract mixin class _$MovieWatchStateCopyWith<$Res> implements $MovieWatchStateCopyWith<$Res> {
  factory _$MovieWatchStateCopyWith(_MovieWatchState value, $Res Function(_MovieWatchState) _then) = __$MovieWatchStateCopyWithImpl;
@override @useResult
$Res call({
 String slug, PageStatus pageStatus, bool processing, AppFailure? failure, MovieDetail? detail, int selectedServerIndex, int selectedEpisodeIndex
});


@override $AppFailureCopyWith<$Res>? get failure;@override $MovieDetailCopyWith<$Res>? get detail;

}
/// @nodoc
class __$MovieWatchStateCopyWithImpl<$Res>
    implements _$MovieWatchStateCopyWith<$Res> {
  __$MovieWatchStateCopyWithImpl(this._self, this._then);

  final _MovieWatchState _self;
  final $Res Function(_MovieWatchState) _then;

/// Create a copy of MovieWatchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? slug = null,Object? pageStatus = null,Object? processing = null,Object? failure = freezed,Object? detail = freezed,Object? selectedServerIndex = null,Object? selectedEpisodeIndex = null,}) {
  return _then(_MovieWatchState(
slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as MovieDetail?,selectedServerIndex: null == selectedServerIndex ? _self.selectedServerIndex : selectedServerIndex // ignore: cast_nullable_to_non_nullable
as int,selectedEpisodeIndex: null == selectedEpisodeIndex ? _self.selectedEpisodeIndex : selectedEpisodeIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of MovieWatchState
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
}/// Create a copy of MovieWatchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MovieDetailCopyWith<$Res>? get detail {
    if (_self.detail == null) {
    return null;
  }

  return $MovieDetailCopyWith<$Res>(_self.detail!, (value) {
    return _then(_self.copyWith(detail: value));
  });
}
}

// dart format on
