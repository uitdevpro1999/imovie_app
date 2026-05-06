// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'genre_movies_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GenreMoviesState {

 String get slug; String get title; PageStatus get pageStatus; bool get processing; AppFailure? get failure; List<HomeMovie> get movies; List<HomeCountry> get countries; int get page; GenreSortType get sortType; HomeCountry get country; GenreYear get year; int get totalItems; bool get loadingMore;
/// Create a copy of GenreMoviesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GenreMoviesStateCopyWith<GenreMoviesState> get copyWith => _$GenreMoviesStateCopyWithImpl<GenreMoviesState>(this as GenreMoviesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GenreMoviesState&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.title, title) || other.title == title)&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure)&&const DeepCollectionEquality().equals(other.movies, movies)&&const DeepCollectionEquality().equals(other.countries, countries)&&(identical(other.page, page) || other.page == page)&&(identical(other.sortType, sortType) || other.sortType == sortType)&&(identical(other.country, country) || other.country == country)&&(identical(other.year, year) || other.year == year)&&(identical(other.totalItems, totalItems) || other.totalItems == totalItems)&&(identical(other.loadingMore, loadingMore) || other.loadingMore == loadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,slug,title,pageStatus,processing,failure,const DeepCollectionEquality().hash(movies),const DeepCollectionEquality().hash(countries),page,sortType,country,year,totalItems,loadingMore);

@override
String toString() {
  return 'GenreMoviesState(slug: $slug, title: $title, pageStatus: $pageStatus, processing: $processing, failure: $failure, movies: $movies, countries: $countries, page: $page, sortType: $sortType, country: $country, year: $year, totalItems: $totalItems, loadingMore: $loadingMore)';
}


}

/// @nodoc
abstract mixin class $GenreMoviesStateCopyWith<$Res>  {
  factory $GenreMoviesStateCopyWith(GenreMoviesState value, $Res Function(GenreMoviesState) _then) = _$GenreMoviesStateCopyWithImpl;
@useResult
$Res call({
 String slug, String title, PageStatus pageStatus, bool processing, AppFailure? failure, List<HomeMovie> movies, List<HomeCountry> countries, int page, GenreSortType sortType, HomeCountry country, GenreYear year, int totalItems, bool loadingMore
});


$AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$GenreMoviesStateCopyWithImpl<$Res>
    implements $GenreMoviesStateCopyWith<$Res> {
  _$GenreMoviesStateCopyWithImpl(this._self, this._then);

  final GenreMoviesState _self;
  final $Res Function(GenreMoviesState) _then;

/// Create a copy of GenreMoviesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? slug = null,Object? title = null,Object? pageStatus = null,Object? processing = null,Object? failure = freezed,Object? movies = null,Object? countries = null,Object? page = null,Object? sortType = null,Object? country = null,Object? year = null,Object? totalItems = null,Object? loadingMore = null,}) {
  return _then(_self.copyWith(
slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,movies: null == movies ? _self.movies : movies // ignore: cast_nullable_to_non_nullable
as List<HomeMovie>,countries: null == countries ? _self.countries : countries // ignore: cast_nullable_to_non_nullable
as List<HomeCountry>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,sortType: null == sortType ? _self.sortType : sortType // ignore: cast_nullable_to_non_nullable
as GenreSortType,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as HomeCountry,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as GenreYear,totalItems: null == totalItems ? _self.totalItems : totalItems // ignore: cast_nullable_to_non_nullable
as int,loadingMore: null == loadingMore ? _self.loadingMore : loadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of GenreMoviesState
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


/// Adds pattern-matching-related methods to [GenreMoviesState].
extension GenreMoviesStatePatterns on GenreMoviesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GenreMoviesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GenreMoviesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GenreMoviesState value)  $default,){
final _that = this;
switch (_that) {
case _GenreMoviesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GenreMoviesState value)?  $default,){
final _that = this;
switch (_that) {
case _GenreMoviesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String slug,  String title,  PageStatus pageStatus,  bool processing,  AppFailure? failure,  List<HomeMovie> movies,  List<HomeCountry> countries,  int page,  GenreSortType sortType,  HomeCountry country,  GenreYear year,  int totalItems,  bool loadingMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GenreMoviesState() when $default != null:
return $default(_that.slug,_that.title,_that.pageStatus,_that.processing,_that.failure,_that.movies,_that.countries,_that.page,_that.sortType,_that.country,_that.year,_that.totalItems,_that.loadingMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String slug,  String title,  PageStatus pageStatus,  bool processing,  AppFailure? failure,  List<HomeMovie> movies,  List<HomeCountry> countries,  int page,  GenreSortType sortType,  HomeCountry country,  GenreYear year,  int totalItems,  bool loadingMore)  $default,) {final _that = this;
switch (_that) {
case _GenreMoviesState():
return $default(_that.slug,_that.title,_that.pageStatus,_that.processing,_that.failure,_that.movies,_that.countries,_that.page,_that.sortType,_that.country,_that.year,_that.totalItems,_that.loadingMore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String slug,  String title,  PageStatus pageStatus,  bool processing,  AppFailure? failure,  List<HomeMovie> movies,  List<HomeCountry> countries,  int page,  GenreSortType sortType,  HomeCountry country,  GenreYear year,  int totalItems,  bool loadingMore)?  $default,) {final _that = this;
switch (_that) {
case _GenreMoviesState() when $default != null:
return $default(_that.slug,_that.title,_that.pageStatus,_that.processing,_that.failure,_that.movies,_that.countries,_that.page,_that.sortType,_that.country,_that.year,_that.totalItems,_that.loadingMore);case _:
  return null;

}
}

}

/// @nodoc


class _GenreMoviesState extends GenreMoviesState {
  const _GenreMoviesState({required this.slug, required this.title, this.pageStatus = PageStatus.initial, this.processing = false, this.failure, final  List<HomeMovie> movies = const <HomeMovie>[], final  List<HomeCountry> countries = const <HomeCountry>[HomeCountry.all], this.page = 1, this.sortType = GenreSortType.desc, this.country = HomeCountry.all, this.year = GenreYear.all, this.totalItems = 0, this.loadingMore = false}): _movies = movies,_countries = countries,super._();
  

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

 final  List<HomeCountry> _countries;
@override@JsonKey() List<HomeCountry> get countries {
  if (_countries is EqualUnmodifiableListView) return _countries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_countries);
}

@override@JsonKey() final  int page;
@override@JsonKey() final  GenreSortType sortType;
@override@JsonKey() final  HomeCountry country;
@override@JsonKey() final  GenreYear year;
@override@JsonKey() final  int totalItems;
@override@JsonKey() final  bool loadingMore;

/// Create a copy of GenreMoviesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GenreMoviesStateCopyWith<_GenreMoviesState> get copyWith => __$GenreMoviesStateCopyWithImpl<_GenreMoviesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GenreMoviesState&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.title, title) || other.title == title)&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure)&&const DeepCollectionEquality().equals(other._movies, _movies)&&const DeepCollectionEquality().equals(other._countries, _countries)&&(identical(other.page, page) || other.page == page)&&(identical(other.sortType, sortType) || other.sortType == sortType)&&(identical(other.country, country) || other.country == country)&&(identical(other.year, year) || other.year == year)&&(identical(other.totalItems, totalItems) || other.totalItems == totalItems)&&(identical(other.loadingMore, loadingMore) || other.loadingMore == loadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,slug,title,pageStatus,processing,failure,const DeepCollectionEquality().hash(_movies),const DeepCollectionEquality().hash(_countries),page,sortType,country,year,totalItems,loadingMore);

@override
String toString() {
  return 'GenreMoviesState(slug: $slug, title: $title, pageStatus: $pageStatus, processing: $processing, failure: $failure, movies: $movies, countries: $countries, page: $page, sortType: $sortType, country: $country, year: $year, totalItems: $totalItems, loadingMore: $loadingMore)';
}


}

/// @nodoc
abstract mixin class _$GenreMoviesStateCopyWith<$Res> implements $GenreMoviesStateCopyWith<$Res> {
  factory _$GenreMoviesStateCopyWith(_GenreMoviesState value, $Res Function(_GenreMoviesState) _then) = __$GenreMoviesStateCopyWithImpl;
@override @useResult
$Res call({
 String slug, String title, PageStatus pageStatus, bool processing, AppFailure? failure, List<HomeMovie> movies, List<HomeCountry> countries, int page, GenreSortType sortType, HomeCountry country, GenreYear year, int totalItems, bool loadingMore
});


@override $AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$GenreMoviesStateCopyWithImpl<$Res>
    implements _$GenreMoviesStateCopyWith<$Res> {
  __$GenreMoviesStateCopyWithImpl(this._self, this._then);

  final _GenreMoviesState _self;
  final $Res Function(_GenreMoviesState) _then;

/// Create a copy of GenreMoviesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? slug = null,Object? title = null,Object? pageStatus = null,Object? processing = null,Object? failure = freezed,Object? movies = null,Object? countries = null,Object? page = null,Object? sortType = null,Object? country = null,Object? year = null,Object? totalItems = null,Object? loadingMore = null,}) {
  return _then(_GenreMoviesState(
slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,movies: null == movies ? _self._movies : movies // ignore: cast_nullable_to_non_nullable
as List<HomeMovie>,countries: null == countries ? _self._countries : countries // ignore: cast_nullable_to_non_nullable
as List<HomeCountry>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,sortType: null == sortType ? _self.sortType : sortType // ignore: cast_nullable_to_non_nullable
as GenreSortType,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as HomeCountry,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as GenreYear,totalItems: null == totalItems ? _self.totalItems : totalItems // ignore: cast_nullable_to_non_nullable
as int,loadingMore: null == loadingMore ? _self.loadingMore : loadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of GenreMoviesState
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
