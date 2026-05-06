// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_feed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeFeed {

 String get seoTitle; List<HomeMovie> get movies; HomeMovie? get featuredMovie; int get totalItems; int get currentPage; int get itemsPerPage;
/// Create a copy of HomeFeed
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeFeedCopyWith<HomeFeed> get copyWith => _$HomeFeedCopyWithImpl<HomeFeed>(this as HomeFeed, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeFeed&&(identical(other.seoTitle, seoTitle) || other.seoTitle == seoTitle)&&const DeepCollectionEquality().equals(other.movies, movies)&&(identical(other.featuredMovie, featuredMovie) || other.featuredMovie == featuredMovie)&&(identical(other.totalItems, totalItems) || other.totalItems == totalItems)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.itemsPerPage, itemsPerPage) || other.itemsPerPage == itemsPerPage));
}


@override
int get hashCode => Object.hash(runtimeType,seoTitle,const DeepCollectionEquality().hash(movies),featuredMovie,totalItems,currentPage,itemsPerPage);

@override
String toString() {
  return 'HomeFeed(seoTitle: $seoTitle, movies: $movies, featuredMovie: $featuredMovie, totalItems: $totalItems, currentPage: $currentPage, itemsPerPage: $itemsPerPage)';
}


}

/// @nodoc
abstract mixin class $HomeFeedCopyWith<$Res>  {
  factory $HomeFeedCopyWith(HomeFeed value, $Res Function(HomeFeed) _then) = _$HomeFeedCopyWithImpl;
@useResult
$Res call({
 String seoTitle, List<HomeMovie> movies, HomeMovie? featuredMovie, int totalItems, int currentPage, int itemsPerPage
});


$HomeMovieCopyWith<$Res>? get featuredMovie;

}
/// @nodoc
class _$HomeFeedCopyWithImpl<$Res>
    implements $HomeFeedCopyWith<$Res> {
  _$HomeFeedCopyWithImpl(this._self, this._then);

  final HomeFeed _self;
  final $Res Function(HomeFeed) _then;

/// Create a copy of HomeFeed
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? seoTitle = null,Object? movies = null,Object? featuredMovie = freezed,Object? totalItems = null,Object? currentPage = null,Object? itemsPerPage = null,}) {
  return _then(_self.copyWith(
seoTitle: null == seoTitle ? _self.seoTitle : seoTitle // ignore: cast_nullable_to_non_nullable
as String,movies: null == movies ? _self.movies : movies // ignore: cast_nullable_to_non_nullable
as List<HomeMovie>,featuredMovie: freezed == featuredMovie ? _self.featuredMovie : featuredMovie // ignore: cast_nullable_to_non_nullable
as HomeMovie?,totalItems: null == totalItems ? _self.totalItems : totalItems // ignore: cast_nullable_to_non_nullable
as int,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,itemsPerPage: null == itemsPerPage ? _self.itemsPerPage : itemsPerPage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of HomeFeed
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeMovieCopyWith<$Res>? get featuredMovie {
    if (_self.featuredMovie == null) {
    return null;
  }

  return $HomeMovieCopyWith<$Res>(_self.featuredMovie!, (value) {
    return _then(_self.copyWith(featuredMovie: value));
  });
}
}


/// Adds pattern-matching-related methods to [HomeFeed].
extension HomeFeedPatterns on HomeFeed {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeFeed value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeFeed() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeFeed value)  $default,){
final _that = this;
switch (_that) {
case _HomeFeed():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeFeed value)?  $default,){
final _that = this;
switch (_that) {
case _HomeFeed() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String seoTitle,  List<HomeMovie> movies,  HomeMovie? featuredMovie,  int totalItems,  int currentPage,  int itemsPerPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeFeed() when $default != null:
return $default(_that.seoTitle,_that.movies,_that.featuredMovie,_that.totalItems,_that.currentPage,_that.itemsPerPage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String seoTitle,  List<HomeMovie> movies,  HomeMovie? featuredMovie,  int totalItems,  int currentPage,  int itemsPerPage)  $default,) {final _that = this;
switch (_that) {
case _HomeFeed():
return $default(_that.seoTitle,_that.movies,_that.featuredMovie,_that.totalItems,_that.currentPage,_that.itemsPerPage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String seoTitle,  List<HomeMovie> movies,  HomeMovie? featuredMovie,  int totalItems,  int currentPage,  int itemsPerPage)?  $default,) {final _that = this;
switch (_that) {
case _HomeFeed() when $default != null:
return $default(_that.seoTitle,_that.movies,_that.featuredMovie,_that.totalItems,_that.currentPage,_that.itemsPerPage);case _:
  return null;

}
}

}

/// @nodoc


class _HomeFeed extends HomeFeed {
  const _HomeFeed({required this.seoTitle, required final  List<HomeMovie> movies, this.featuredMovie, this.totalItems = 0, this.currentPage = 1, this.itemsPerPage = 24}): _movies = movies,super._();
  

@override final  String seoTitle;
 final  List<HomeMovie> _movies;
@override List<HomeMovie> get movies {
  if (_movies is EqualUnmodifiableListView) return _movies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_movies);
}

@override final  HomeMovie? featuredMovie;
@override@JsonKey() final  int totalItems;
@override@JsonKey() final  int currentPage;
@override@JsonKey() final  int itemsPerPage;

/// Create a copy of HomeFeed
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeFeedCopyWith<_HomeFeed> get copyWith => __$HomeFeedCopyWithImpl<_HomeFeed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeFeed&&(identical(other.seoTitle, seoTitle) || other.seoTitle == seoTitle)&&const DeepCollectionEquality().equals(other._movies, _movies)&&(identical(other.featuredMovie, featuredMovie) || other.featuredMovie == featuredMovie)&&(identical(other.totalItems, totalItems) || other.totalItems == totalItems)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.itemsPerPage, itemsPerPage) || other.itemsPerPage == itemsPerPage));
}


@override
int get hashCode => Object.hash(runtimeType,seoTitle,const DeepCollectionEquality().hash(_movies),featuredMovie,totalItems,currentPage,itemsPerPage);

@override
String toString() {
  return 'HomeFeed(seoTitle: $seoTitle, movies: $movies, featuredMovie: $featuredMovie, totalItems: $totalItems, currentPage: $currentPage, itemsPerPage: $itemsPerPage)';
}


}

/// @nodoc
abstract mixin class _$HomeFeedCopyWith<$Res> implements $HomeFeedCopyWith<$Res> {
  factory _$HomeFeedCopyWith(_HomeFeed value, $Res Function(_HomeFeed) _then) = __$HomeFeedCopyWithImpl;
@override @useResult
$Res call({
 String seoTitle, List<HomeMovie> movies, HomeMovie? featuredMovie, int totalItems, int currentPage, int itemsPerPage
});


@override $HomeMovieCopyWith<$Res>? get featuredMovie;

}
/// @nodoc
class __$HomeFeedCopyWithImpl<$Res>
    implements _$HomeFeedCopyWith<$Res> {
  __$HomeFeedCopyWithImpl(this._self, this._then);

  final _HomeFeed _self;
  final $Res Function(_HomeFeed) _then;

/// Create a copy of HomeFeed
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? seoTitle = null,Object? movies = null,Object? featuredMovie = freezed,Object? totalItems = null,Object? currentPage = null,Object? itemsPerPage = null,}) {
  return _then(_HomeFeed(
seoTitle: null == seoTitle ? _self.seoTitle : seoTitle // ignore: cast_nullable_to_non_nullable
as String,movies: null == movies ? _self._movies : movies // ignore: cast_nullable_to_non_nullable
as List<HomeMovie>,featuredMovie: freezed == featuredMovie ? _self.featuredMovie : featuredMovie // ignore: cast_nullable_to_non_nullable
as HomeMovie?,totalItems: null == totalItems ? _self.totalItems : totalItems // ignore: cast_nullable_to_non_nullable
as int,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,itemsPerPage: null == itemsPerPage ? _self.itemsPerPage : itemsPerPage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of HomeFeed
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeMovieCopyWith<$Res>? get featuredMovie {
    if (_self.featuredMovie == null) {
    return null;
  }

  return $HomeMovieCopyWith<$Res>(_self.featuredMovie!, (value) {
    return _then(_self.copyWith(featuredMovie: value));
  });
}
}

// dart format on
