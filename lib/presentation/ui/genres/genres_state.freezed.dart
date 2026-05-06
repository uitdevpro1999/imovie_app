// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'genres_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GenresState {

 PageStatus get pageStatus; bool get processing; AppFailure? get failure; List<HomeGenre> get genres;
/// Create a copy of GenresState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GenresStateCopyWith<GenresState> get copyWith => _$GenresStateCopyWithImpl<GenresState>(this as GenresState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GenresState&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure)&&const DeepCollectionEquality().equals(other.genres, genres));
}


@override
int get hashCode => Object.hash(runtimeType,pageStatus,processing,failure,const DeepCollectionEquality().hash(genres));

@override
String toString() {
  return 'GenresState(pageStatus: $pageStatus, processing: $processing, failure: $failure, genres: $genres)';
}


}

/// @nodoc
abstract mixin class $GenresStateCopyWith<$Res>  {
  factory $GenresStateCopyWith(GenresState value, $Res Function(GenresState) _then) = _$GenresStateCopyWithImpl;
@useResult
$Res call({
 PageStatus pageStatus, bool processing, AppFailure? failure, List<HomeGenre> genres
});


$AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$GenresStateCopyWithImpl<$Res>
    implements $GenresStateCopyWith<$Res> {
  _$GenresStateCopyWithImpl(this._self, this._then);

  final GenresState _self;
  final $Res Function(GenresState) _then;

/// Create a copy of GenresState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pageStatus = null,Object? processing = null,Object? failure = freezed,Object? genres = null,}) {
  return _then(_self.copyWith(
pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,genres: null == genres ? _self.genres : genres // ignore: cast_nullable_to_non_nullable
as List<HomeGenre>,
  ));
}
/// Create a copy of GenresState
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


/// Adds pattern-matching-related methods to [GenresState].
extension GenresStatePatterns on GenresState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GenresState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GenresState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GenresState value)  $default,){
final _that = this;
switch (_that) {
case _GenresState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GenresState value)?  $default,){
final _that = this;
switch (_that) {
case _GenresState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PageStatus pageStatus,  bool processing,  AppFailure? failure,  List<HomeGenre> genres)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GenresState() when $default != null:
return $default(_that.pageStatus,_that.processing,_that.failure,_that.genres);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PageStatus pageStatus,  bool processing,  AppFailure? failure,  List<HomeGenre> genres)  $default,) {final _that = this;
switch (_that) {
case _GenresState():
return $default(_that.pageStatus,_that.processing,_that.failure,_that.genres);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PageStatus pageStatus,  bool processing,  AppFailure? failure,  List<HomeGenre> genres)?  $default,) {final _that = this;
switch (_that) {
case _GenresState() when $default != null:
return $default(_that.pageStatus,_that.processing,_that.failure,_that.genres);case _:
  return null;

}
}

}

/// @nodoc


class _GenresState extends GenresState {
  const _GenresState({this.pageStatus = PageStatus.loaded, this.processing = false, this.failure, final  List<HomeGenre> genres = const <HomeGenre>[]}): _genres = genres,super._();
  

@override@JsonKey() final  PageStatus pageStatus;
@override@JsonKey() final  bool processing;
@override final  AppFailure? failure;
 final  List<HomeGenre> _genres;
@override@JsonKey() List<HomeGenre> get genres {
  if (_genres is EqualUnmodifiableListView) return _genres;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_genres);
}


/// Create a copy of GenresState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GenresStateCopyWith<_GenresState> get copyWith => __$GenresStateCopyWithImpl<_GenresState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GenresState&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure)&&const DeepCollectionEquality().equals(other._genres, _genres));
}


@override
int get hashCode => Object.hash(runtimeType,pageStatus,processing,failure,const DeepCollectionEquality().hash(_genres));

@override
String toString() {
  return 'GenresState(pageStatus: $pageStatus, processing: $processing, failure: $failure, genres: $genres)';
}


}

/// @nodoc
abstract mixin class _$GenresStateCopyWith<$Res> implements $GenresStateCopyWith<$Res> {
  factory _$GenresStateCopyWith(_GenresState value, $Res Function(_GenresState) _then) = __$GenresStateCopyWithImpl;
@override @useResult
$Res call({
 PageStatus pageStatus, bool processing, AppFailure? failure, List<HomeGenre> genres
});


@override $AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$GenresStateCopyWithImpl<$Res>
    implements _$GenresStateCopyWith<$Res> {
  __$GenresStateCopyWithImpl(this._self, this._then);

  final _GenresState _self;
  final $Res Function(_GenresState) _then;

/// Create a copy of GenresState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pageStatus = null,Object? processing = null,Object? failure = freezed,Object? genres = null,}) {
  return _then(_GenresState(
pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,genres: null == genres ? _self._genres : genres // ignore: cast_nullable_to_non_nullable
as List<HomeGenre>,
  ));
}

/// Create a copy of GenresState
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
