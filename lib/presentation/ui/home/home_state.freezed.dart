// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeState {

 PageStatus get pageStatus; bool get processing; AppFailure? get failure; HomeFeed? get feed; List<HomeGenre> get genres; List<HomeMovie> get tvShowMovies; List<HomeMovie> get upcomingMovies;
/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeStateCopyWith<HomeState> get copyWith => _$HomeStateCopyWithImpl<HomeState>(this as HomeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeState&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.feed, feed) || other.feed == feed)&&const DeepCollectionEquality().equals(other.genres, genres)&&const DeepCollectionEquality().equals(other.tvShowMovies, tvShowMovies)&&const DeepCollectionEquality().equals(other.upcomingMovies, upcomingMovies));
}


@override
int get hashCode => Object.hash(runtimeType,pageStatus,processing,failure,feed,const DeepCollectionEquality().hash(genres),const DeepCollectionEquality().hash(tvShowMovies),const DeepCollectionEquality().hash(upcomingMovies));

@override
String toString() {
  return 'HomeState(pageStatus: $pageStatus, processing: $processing, failure: $failure, feed: $feed, genres: $genres, tvShowMovies: $tvShowMovies, upcomingMovies: $upcomingMovies)';
}


}

/// @nodoc
abstract mixin class $HomeStateCopyWith<$Res>  {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) _then) = _$HomeStateCopyWithImpl;
@useResult
$Res call({
 PageStatus pageStatus, bool processing, AppFailure? failure, HomeFeed? feed, List<HomeGenre> genres, List<HomeMovie> tvShowMovies, List<HomeMovie> upcomingMovies
});


$AppFailureCopyWith<$Res>? get failure;$HomeFeedCopyWith<$Res>? get feed;

}
/// @nodoc
class _$HomeStateCopyWithImpl<$Res>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._self, this._then);

  final HomeState _self;
  final $Res Function(HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pageStatus = null,Object? processing = null,Object? failure = freezed,Object? feed = freezed,Object? genres = null,Object? tvShowMovies = null,Object? upcomingMovies = null,}) {
  return _then(_self.copyWith(
pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,feed: freezed == feed ? _self.feed : feed // ignore: cast_nullable_to_non_nullable
as HomeFeed?,genres: null == genres ? _self.genres : genres // ignore: cast_nullable_to_non_nullable
as List<HomeGenre>,tvShowMovies: null == tvShowMovies ? _self.tvShowMovies : tvShowMovies // ignore: cast_nullable_to_non_nullable
as List<HomeMovie>,upcomingMovies: null == upcomingMovies ? _self.upcomingMovies : upcomingMovies // ignore: cast_nullable_to_non_nullable
as List<HomeMovie>,
  ));
}
/// Create a copy of HomeState
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
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeFeedCopyWith<$Res>? get feed {
    if (_self.feed == null) {
    return null;
  }

  return $HomeFeedCopyWith<$Res>(_self.feed!, (value) {
    return _then(_self.copyWith(feed: value));
  });
}
}


/// Adds pattern-matching-related methods to [HomeState].
extension HomeStatePatterns on HomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeState value)  $default,){
final _that = this;
switch (_that) {
case _HomeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeState value)?  $default,){
final _that = this;
switch (_that) {
case _HomeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PageStatus pageStatus,  bool processing,  AppFailure? failure,  HomeFeed? feed,  List<HomeGenre> genres,  List<HomeMovie> tvShowMovies,  List<HomeMovie> upcomingMovies)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that.pageStatus,_that.processing,_that.failure,_that.feed,_that.genres,_that.tvShowMovies,_that.upcomingMovies);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PageStatus pageStatus,  bool processing,  AppFailure? failure,  HomeFeed? feed,  List<HomeGenre> genres,  List<HomeMovie> tvShowMovies,  List<HomeMovie> upcomingMovies)  $default,) {final _that = this;
switch (_that) {
case _HomeState():
return $default(_that.pageStatus,_that.processing,_that.failure,_that.feed,_that.genres,_that.tvShowMovies,_that.upcomingMovies);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PageStatus pageStatus,  bool processing,  AppFailure? failure,  HomeFeed? feed,  List<HomeGenre> genres,  List<HomeMovie> tvShowMovies,  List<HomeMovie> upcomingMovies)?  $default,) {final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that.pageStatus,_that.processing,_that.failure,_that.feed,_that.genres,_that.tvShowMovies,_that.upcomingMovies);case _:
  return null;

}
}

}

/// @nodoc


class _HomeState extends HomeState {
  const _HomeState({this.pageStatus = PageStatus.initial, this.processing = false, this.failure, this.feed, final  List<HomeGenre> genres = const <HomeGenre>[], final  List<HomeMovie> tvShowMovies = const <HomeMovie>[], final  List<HomeMovie> upcomingMovies = const <HomeMovie>[]}): _genres = genres,_tvShowMovies = tvShowMovies,_upcomingMovies = upcomingMovies,super._();
  

@override@JsonKey() final  PageStatus pageStatus;
@override@JsonKey() final  bool processing;
@override final  AppFailure? failure;
@override final  HomeFeed? feed;
 final  List<HomeGenre> _genres;
@override@JsonKey() List<HomeGenre> get genres {
  if (_genres is EqualUnmodifiableListView) return _genres;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_genres);
}

 final  List<HomeMovie> _tvShowMovies;
@override@JsonKey() List<HomeMovie> get tvShowMovies {
  if (_tvShowMovies is EqualUnmodifiableListView) return _tvShowMovies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tvShowMovies);
}

 final  List<HomeMovie> _upcomingMovies;
@override@JsonKey() List<HomeMovie> get upcomingMovies {
  if (_upcomingMovies is EqualUnmodifiableListView) return _upcomingMovies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_upcomingMovies);
}


/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeStateCopyWith<_HomeState> get copyWith => __$HomeStateCopyWithImpl<_HomeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeState&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.feed, feed) || other.feed == feed)&&const DeepCollectionEquality().equals(other._genres, _genres)&&const DeepCollectionEquality().equals(other._tvShowMovies, _tvShowMovies)&&const DeepCollectionEquality().equals(other._upcomingMovies, _upcomingMovies));
}


@override
int get hashCode => Object.hash(runtimeType,pageStatus,processing,failure,feed,const DeepCollectionEquality().hash(_genres),const DeepCollectionEquality().hash(_tvShowMovies),const DeepCollectionEquality().hash(_upcomingMovies));

@override
String toString() {
  return 'HomeState(pageStatus: $pageStatus, processing: $processing, failure: $failure, feed: $feed, genres: $genres, tvShowMovies: $tvShowMovies, upcomingMovies: $upcomingMovies)';
}


}

/// @nodoc
abstract mixin class _$HomeStateCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$HomeStateCopyWith(_HomeState value, $Res Function(_HomeState) _then) = __$HomeStateCopyWithImpl;
@override @useResult
$Res call({
 PageStatus pageStatus, bool processing, AppFailure? failure, HomeFeed? feed, List<HomeGenre> genres, List<HomeMovie> tvShowMovies, List<HomeMovie> upcomingMovies
});


@override $AppFailureCopyWith<$Res>? get failure;@override $HomeFeedCopyWith<$Res>? get feed;

}
/// @nodoc
class __$HomeStateCopyWithImpl<$Res>
    implements _$HomeStateCopyWith<$Res> {
  __$HomeStateCopyWithImpl(this._self, this._then);

  final _HomeState _self;
  final $Res Function(_HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pageStatus = null,Object? processing = null,Object? failure = freezed,Object? feed = freezed,Object? genres = null,Object? tvShowMovies = null,Object? upcomingMovies = null,}) {
  return _then(_HomeState(
pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,feed: freezed == feed ? _self.feed : feed // ignore: cast_nullable_to_non_nullable
as HomeFeed?,genres: null == genres ? _self._genres : genres // ignore: cast_nullable_to_non_nullable
as List<HomeGenre>,tvShowMovies: null == tvShowMovies ? _self._tvShowMovies : tvShowMovies // ignore: cast_nullable_to_non_nullable
as List<HomeMovie>,upcomingMovies: null == upcomingMovies ? _self._upcomingMovies : upcomingMovies // ignore: cast_nullable_to_non_nullable
as List<HomeMovie>,
  ));
}

/// Create a copy of HomeState
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
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeFeedCopyWith<$Res>? get feed {
    if (_self.feed == null) {
    return null;
  }

  return $HomeFeedCopyWith<$Res>(_self.feed!, (value) {
    return _then(_self.copyWith(feed: value));
  });
}
}

// dart format on
