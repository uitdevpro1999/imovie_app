// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MovieListState {

 String get slug; String get title; PageStatus get pageStatus; bool get processing; AppFailure? get failure; List<HomeMovie> get movies; int get page; int get pageSize; int get totalItems; bool get loadingMore;
/// Create a copy of MovieListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MovieListStateCopyWith<MovieListState> get copyWith => _$MovieListStateCopyWithImpl<MovieListState>(this as MovieListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MovieListState&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.title, title) || other.title == title)&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure)&&const DeepCollectionEquality().equals(other.movies, movies)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.totalItems, totalItems) || other.totalItems == totalItems)&&(identical(other.loadingMore, loadingMore) || other.loadingMore == loadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,slug,title,pageStatus,processing,failure,const DeepCollectionEquality().hash(movies),page,pageSize,totalItems,loadingMore);

@override
String toString() {
  return 'MovieListState(slug: $slug, title: $title, pageStatus: $pageStatus, processing: $processing, failure: $failure, movies: $movies, page: $page, pageSize: $pageSize, totalItems: $totalItems, loadingMore: $loadingMore)';
}


}

/// @nodoc
abstract mixin class $MovieListStateCopyWith<$Res>  {
  factory $MovieListStateCopyWith(MovieListState value, $Res Function(MovieListState) _then) = _$MovieListStateCopyWithImpl;
@useResult
$Res call({
 String slug, String title, PageStatus pageStatus, bool processing, AppFailure? failure, List<HomeMovie> movies, int page, int pageSize, int totalItems, bool loadingMore
});


$AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$MovieListStateCopyWithImpl<$Res>
    implements $MovieListStateCopyWith<$Res> {
  _$MovieListStateCopyWithImpl(this._self, this._then);

  final MovieListState _self;
  final $Res Function(MovieListState) _then;

/// Create a copy of MovieListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? slug = null,Object? title = null,Object? pageStatus = null,Object? processing = null,Object? failure = freezed,Object? movies = null,Object? page = null,Object? pageSize = null,Object? totalItems = null,Object? loadingMore = null,}) {
  return _then(_self.copyWith(
slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,movies: null == movies ? _self.movies : movies // ignore: cast_nullable_to_non_nullable
as List<HomeMovie>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,totalItems: null == totalItems ? _self.totalItems : totalItems // ignore: cast_nullable_to_non_nullable
as int,loadingMore: null == loadingMore ? _self.loadingMore : loadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of MovieListState
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


/// Adds pattern-matching-related methods to [MovieListState].
extension MovieListStatePatterns on MovieListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MovieListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MovieListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MovieListState value)  $default,){
final _that = this;
switch (_that) {
case _MovieListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MovieListState value)?  $default,){
final _that = this;
switch (_that) {
case _MovieListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String slug,  String title,  PageStatus pageStatus,  bool processing,  AppFailure? failure,  List<HomeMovie> movies,  int page,  int pageSize,  int totalItems,  bool loadingMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MovieListState() when $default != null:
return $default(_that.slug,_that.title,_that.pageStatus,_that.processing,_that.failure,_that.movies,_that.page,_that.pageSize,_that.totalItems,_that.loadingMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String slug,  String title,  PageStatus pageStatus,  bool processing,  AppFailure? failure,  List<HomeMovie> movies,  int page,  int pageSize,  int totalItems,  bool loadingMore)  $default,) {final _that = this;
switch (_that) {
case _MovieListState():
return $default(_that.slug,_that.title,_that.pageStatus,_that.processing,_that.failure,_that.movies,_that.page,_that.pageSize,_that.totalItems,_that.loadingMore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String slug,  String title,  PageStatus pageStatus,  bool processing,  AppFailure? failure,  List<HomeMovie> movies,  int page,  int pageSize,  int totalItems,  bool loadingMore)?  $default,) {final _that = this;
switch (_that) {
case _MovieListState() when $default != null:
return $default(_that.slug,_that.title,_that.pageStatus,_that.processing,_that.failure,_that.movies,_that.page,_that.pageSize,_that.totalItems,_that.loadingMore);case _:
  return null;

}
}

}

/// @nodoc


class _MovieListState extends MovieListState {
  const _MovieListState({required this.slug, required this.title, this.pageStatus = PageStatus.initial, this.processing = false, this.failure, final  List<HomeMovie> movies = const <HomeMovie>[], this.page = 1, this.pageSize = IMovieRefreshConfig.pageSize, this.totalItems = 0, this.loadingMore = false}): _movies = movies,super._();
  

@override final  String slug;
@override final  String title;
@override@JsonKey() final  PageStatus pageStatus;
@override@JsonKey() final  bool processing;
@override final  AppFailure? failure;
 final  List<HomeMovie> _movies;
@override@JsonKey() List<HomeMovie> get movies {
  if (_movies is EqualUnmodifiableListView) return _movies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_movies);
}

@override@JsonKey() final  int page;
@override@JsonKey() final  int pageSize;
@override@JsonKey() final  int totalItems;
@override@JsonKey() final  bool loadingMore;

/// Create a copy of MovieListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MovieListStateCopyWith<_MovieListState> get copyWith => __$MovieListStateCopyWithImpl<_MovieListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MovieListState&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.title, title) || other.title == title)&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure)&&const DeepCollectionEquality().equals(other._movies, _movies)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.totalItems, totalItems) || other.totalItems == totalItems)&&(identical(other.loadingMore, loadingMore) || other.loadingMore == loadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,slug,title,pageStatus,processing,failure,const DeepCollectionEquality().hash(_movies),page,pageSize,totalItems,loadingMore);

@override
String toString() {
  return 'MovieListState(slug: $slug, title: $title, pageStatus: $pageStatus, processing: $processing, failure: $failure, movies: $movies, page: $page, pageSize: $pageSize, totalItems: $totalItems, loadingMore: $loadingMore)';
}


}

/// @nodoc
abstract mixin class _$MovieListStateCopyWith<$Res> implements $MovieListStateCopyWith<$Res> {
  factory _$MovieListStateCopyWith(_MovieListState value, $Res Function(_MovieListState) _then) = __$MovieListStateCopyWithImpl;
@override @useResult
$Res call({
 String slug, String title, PageStatus pageStatus, bool processing, AppFailure? failure, List<HomeMovie> movies, int page, int pageSize, int totalItems, bool loadingMore
});


@override $AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$MovieListStateCopyWithImpl<$Res>
    implements _$MovieListStateCopyWith<$Res> {
  __$MovieListStateCopyWithImpl(this._self, this._then);

  final _MovieListState _self;
  final $Res Function(_MovieListState) _then;

/// Create a copy of MovieListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? slug = null,Object? title = null,Object? pageStatus = null,Object? processing = null,Object? failure = freezed,Object? movies = null,Object? page = null,Object? pageSize = null,Object? totalItems = null,Object? loadingMore = null,}) {
  return _then(_MovieListState(
slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,movies: null == movies ? _self._movies : movies // ignore: cast_nullable_to_non_nullable
as List<HomeMovie>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,totalItems: null == totalItems ? _self.totalItems : totalItems // ignore: cast_nullable_to_non_nullable
as int,loadingMore: null == loadingMore ? _self.loadingMore : loadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of MovieListState
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
