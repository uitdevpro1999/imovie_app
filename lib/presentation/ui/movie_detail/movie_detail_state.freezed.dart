// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MovieDetailState {

 String get slug; PageStatus get pageStatus; bool get processing; AppFailure? get failure; MovieDetail? get detail; List<HomeMovie> get relatedMovies;
/// Create a copy of MovieDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MovieDetailStateCopyWith<MovieDetailState> get copyWith => _$MovieDetailStateCopyWithImpl<MovieDetailState>(this as MovieDetailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MovieDetailState&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.detail, detail) || other.detail == detail)&&const DeepCollectionEquality().equals(other.relatedMovies, relatedMovies));
}


@override
int get hashCode => Object.hash(runtimeType,slug,pageStatus,processing,failure,detail,const DeepCollectionEquality().hash(relatedMovies));

@override
String toString() {
  return 'MovieDetailState(slug: $slug, pageStatus: $pageStatus, processing: $processing, failure: $failure, detail: $detail, relatedMovies: $relatedMovies)';
}


}

/// @nodoc
abstract mixin class $MovieDetailStateCopyWith<$Res>  {
  factory $MovieDetailStateCopyWith(MovieDetailState value, $Res Function(MovieDetailState) _then) = _$MovieDetailStateCopyWithImpl;
@useResult
$Res call({
 String slug, PageStatus pageStatus, bool processing, AppFailure? failure, MovieDetail? detail, List<HomeMovie> relatedMovies
});


$AppFailureCopyWith<$Res>? get failure;$MovieDetailCopyWith<$Res>? get detail;

}
/// @nodoc
class _$MovieDetailStateCopyWithImpl<$Res>
    implements $MovieDetailStateCopyWith<$Res> {
  _$MovieDetailStateCopyWithImpl(this._self, this._then);

  final MovieDetailState _self;
  final $Res Function(MovieDetailState) _then;

/// Create a copy of MovieDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? slug = null,Object? pageStatus = null,Object? processing = null,Object? failure = freezed,Object? detail = freezed,Object? relatedMovies = null,}) {
  return _then(_self.copyWith(
slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as MovieDetail?,relatedMovies: null == relatedMovies ? _self.relatedMovies : relatedMovies // ignore: cast_nullable_to_non_nullable
as List<HomeMovie>,
  ));
}
/// Create a copy of MovieDetailState
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
}/// Create a copy of MovieDetailState
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


/// Adds pattern-matching-related methods to [MovieDetailState].
extension MovieDetailStatePatterns on MovieDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MovieDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MovieDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MovieDetailState value)  $default,){
final _that = this;
switch (_that) {
case _MovieDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MovieDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _MovieDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String slug,  PageStatus pageStatus,  bool processing,  AppFailure? failure,  MovieDetail? detail,  List<HomeMovie> relatedMovies)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MovieDetailState() when $default != null:
return $default(_that.slug,_that.pageStatus,_that.processing,_that.failure,_that.detail,_that.relatedMovies);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String slug,  PageStatus pageStatus,  bool processing,  AppFailure? failure,  MovieDetail? detail,  List<HomeMovie> relatedMovies)  $default,) {final _that = this;
switch (_that) {
case _MovieDetailState():
return $default(_that.slug,_that.pageStatus,_that.processing,_that.failure,_that.detail,_that.relatedMovies);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String slug,  PageStatus pageStatus,  bool processing,  AppFailure? failure,  MovieDetail? detail,  List<HomeMovie> relatedMovies)?  $default,) {final _that = this;
switch (_that) {
case _MovieDetailState() when $default != null:
return $default(_that.slug,_that.pageStatus,_that.processing,_that.failure,_that.detail,_that.relatedMovies);case _:
  return null;

}
}

}

/// @nodoc


class _MovieDetailState extends MovieDetailState {
  const _MovieDetailState({required this.slug, this.pageStatus = PageStatus.initial, this.processing = false, this.failure, this.detail, final  List<HomeMovie> relatedMovies = const <HomeMovie>[]}): _relatedMovies = relatedMovies,super._();
  

@override final  String slug;
@override@JsonKey() final  PageStatus pageStatus;
@override@JsonKey() final  bool processing;
@override final  AppFailure? failure;
@override final  MovieDetail? detail;
 final  List<HomeMovie> _relatedMovies;
@override@JsonKey() List<HomeMovie> get relatedMovies {
  if (_relatedMovies is EqualUnmodifiableListView) return _relatedMovies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_relatedMovies);
}


/// Create a copy of MovieDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MovieDetailStateCopyWith<_MovieDetailState> get copyWith => __$MovieDetailStateCopyWithImpl<_MovieDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MovieDetailState&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.detail, detail) || other.detail == detail)&&const DeepCollectionEquality().equals(other._relatedMovies, _relatedMovies));
}


@override
int get hashCode => Object.hash(runtimeType,slug,pageStatus,processing,failure,detail,const DeepCollectionEquality().hash(_relatedMovies));

@override
String toString() {
  return 'MovieDetailState(slug: $slug, pageStatus: $pageStatus, processing: $processing, failure: $failure, detail: $detail, relatedMovies: $relatedMovies)';
}


}

/// @nodoc
abstract mixin class _$MovieDetailStateCopyWith<$Res> implements $MovieDetailStateCopyWith<$Res> {
  factory _$MovieDetailStateCopyWith(_MovieDetailState value, $Res Function(_MovieDetailState) _then) = __$MovieDetailStateCopyWithImpl;
@override @useResult
$Res call({
 String slug, PageStatus pageStatus, bool processing, AppFailure? failure, MovieDetail? detail, List<HomeMovie> relatedMovies
});


@override $AppFailureCopyWith<$Res>? get failure;@override $MovieDetailCopyWith<$Res>? get detail;

}
/// @nodoc
class __$MovieDetailStateCopyWithImpl<$Res>
    implements _$MovieDetailStateCopyWith<$Res> {
  __$MovieDetailStateCopyWithImpl(this._self, this._then);

  final _MovieDetailState _self;
  final $Res Function(_MovieDetailState) _then;

/// Create a copy of MovieDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? slug = null,Object? pageStatus = null,Object? processing = null,Object? failure = freezed,Object? detail = freezed,Object? relatedMovies = null,}) {
  return _then(_MovieDetailState(
slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as MovieDetail?,relatedMovies: null == relatedMovies ? _self._relatedMovies : relatedMovies // ignore: cast_nullable_to_non_nullable
as List<HomeMovie>,
  ));
}

/// Create a copy of MovieDetailState
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
}/// Create a copy of MovieDetailState
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
