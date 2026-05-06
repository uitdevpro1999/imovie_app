// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MovieDetail {

 String get id; String get imdbId; String get tmdbId; String get tmdbType; String get slug; String get title; String get originalTitle; String get posterUrl; String get backdropUrl; String get description; String get status; String get type; String get quality; String get language; String get runtime; String get currentEpisode; String get totalEpisodes; int get year; double get rating; int get ratingCount; List<String> get genres; List<String> get countries; List<MoviePerson> get actors; List<String> get directors; String get trailerUrl; List<MovieStreamServer> get servers;
/// Create a copy of MovieDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MovieDetailCopyWith<MovieDetail> get copyWith => _$MovieDetailCopyWithImpl<MovieDetail>(this as MovieDetail, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MovieDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.imdbId, imdbId) || other.imdbId == imdbId)&&(identical(other.tmdbId, tmdbId) || other.tmdbId == tmdbId)&&(identical(other.tmdbType, tmdbType) || other.tmdbType == tmdbType)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.title, title) || other.title == title)&&(identical(other.originalTitle, originalTitle) || other.originalTitle == originalTitle)&&(identical(other.posterUrl, posterUrl) || other.posterUrl == posterUrl)&&(identical(other.backdropUrl, backdropUrl) || other.backdropUrl == backdropUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.type, type) || other.type == type)&&(identical(other.quality, quality) || other.quality == quality)&&(identical(other.language, language) || other.language == language)&&(identical(other.runtime, runtime) || other.runtime == runtime)&&(identical(other.currentEpisode, currentEpisode) || other.currentEpisode == currentEpisode)&&(identical(other.totalEpisodes, totalEpisodes) || other.totalEpisodes == totalEpisodes)&&(identical(other.year, year) || other.year == year)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.ratingCount, ratingCount) || other.ratingCount == ratingCount)&&const DeepCollectionEquality().equals(other.genres, genres)&&const DeepCollectionEquality().equals(other.countries, countries)&&const DeepCollectionEquality().equals(other.actors, actors)&&const DeepCollectionEquality().equals(other.directors, directors)&&(identical(other.trailerUrl, trailerUrl) || other.trailerUrl == trailerUrl)&&const DeepCollectionEquality().equals(other.servers, servers));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,imdbId,tmdbId,tmdbType,slug,title,originalTitle,posterUrl,backdropUrl,description,status,type,quality,language,runtime,currentEpisode,totalEpisodes,year,rating,ratingCount,const DeepCollectionEquality().hash(genres),const DeepCollectionEquality().hash(countries),const DeepCollectionEquality().hash(actors),const DeepCollectionEquality().hash(directors),trailerUrl,const DeepCollectionEquality().hash(servers)]);

@override
String toString() {
  return 'MovieDetail(id: $id, imdbId: $imdbId, tmdbId: $tmdbId, tmdbType: $tmdbType, slug: $slug, title: $title, originalTitle: $originalTitle, posterUrl: $posterUrl, backdropUrl: $backdropUrl, description: $description, status: $status, type: $type, quality: $quality, language: $language, runtime: $runtime, currentEpisode: $currentEpisode, totalEpisodes: $totalEpisodes, year: $year, rating: $rating, ratingCount: $ratingCount, genres: $genres, countries: $countries, actors: $actors, directors: $directors, trailerUrl: $trailerUrl, servers: $servers)';
}


}

/// @nodoc
abstract mixin class $MovieDetailCopyWith<$Res>  {
  factory $MovieDetailCopyWith(MovieDetail value, $Res Function(MovieDetail) _then) = _$MovieDetailCopyWithImpl;
@useResult
$Res call({
 String id, String imdbId, String tmdbId, String tmdbType, String slug, String title, String originalTitle, String posterUrl, String backdropUrl, String description, String status, String type, String quality, String language, String runtime, String currentEpisode, String totalEpisodes, int year, double rating, int ratingCount, List<String> genres, List<String> countries, List<MoviePerson> actors, List<String> directors, String trailerUrl, List<MovieStreamServer> servers
});




}
/// @nodoc
class _$MovieDetailCopyWithImpl<$Res>
    implements $MovieDetailCopyWith<$Res> {
  _$MovieDetailCopyWithImpl(this._self, this._then);

  final MovieDetail _self;
  final $Res Function(MovieDetail) _then;

/// Create a copy of MovieDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? imdbId = null,Object? tmdbId = null,Object? tmdbType = null,Object? slug = null,Object? title = null,Object? originalTitle = null,Object? posterUrl = null,Object? backdropUrl = null,Object? description = null,Object? status = null,Object? type = null,Object? quality = null,Object? language = null,Object? runtime = null,Object? currentEpisode = null,Object? totalEpisodes = null,Object? year = null,Object? rating = null,Object? ratingCount = null,Object? genres = null,Object? countries = null,Object? actors = null,Object? directors = null,Object? trailerUrl = null,Object? servers = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,imdbId: null == imdbId ? _self.imdbId : imdbId // ignore: cast_nullable_to_non_nullable
as String,tmdbId: null == tmdbId ? _self.tmdbId : tmdbId // ignore: cast_nullable_to_non_nullable
as String,tmdbType: null == tmdbType ? _self.tmdbType : tmdbType // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,originalTitle: null == originalTitle ? _self.originalTitle : originalTitle // ignore: cast_nullable_to_non_nullable
as String,posterUrl: null == posterUrl ? _self.posterUrl : posterUrl // ignore: cast_nullable_to_non_nullable
as String,backdropUrl: null == backdropUrl ? _self.backdropUrl : backdropUrl // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,quality: null == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,runtime: null == runtime ? _self.runtime : runtime // ignore: cast_nullable_to_non_nullable
as String,currentEpisode: null == currentEpisode ? _self.currentEpisode : currentEpisode // ignore: cast_nullable_to_non_nullable
as String,totalEpisodes: null == totalEpisodes ? _self.totalEpisodes : totalEpisodes // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,ratingCount: null == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int,genres: null == genres ? _self.genres : genres // ignore: cast_nullable_to_non_nullable
as List<String>,countries: null == countries ? _self.countries : countries // ignore: cast_nullable_to_non_nullable
as List<String>,actors: null == actors ? _self.actors : actors // ignore: cast_nullable_to_non_nullable
as List<MoviePerson>,directors: null == directors ? _self.directors : directors // ignore: cast_nullable_to_non_nullable
as List<String>,trailerUrl: null == trailerUrl ? _self.trailerUrl : trailerUrl // ignore: cast_nullable_to_non_nullable
as String,servers: null == servers ? _self.servers : servers // ignore: cast_nullable_to_non_nullable
as List<MovieStreamServer>,
  ));
}

}


/// Adds pattern-matching-related methods to [MovieDetail].
extension MovieDetailPatterns on MovieDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MovieDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MovieDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MovieDetail value)  $default,){
final _that = this;
switch (_that) {
case _MovieDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MovieDetail value)?  $default,){
final _that = this;
switch (_that) {
case _MovieDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String imdbId,  String tmdbId,  String tmdbType,  String slug,  String title,  String originalTitle,  String posterUrl,  String backdropUrl,  String description,  String status,  String type,  String quality,  String language,  String runtime,  String currentEpisode,  String totalEpisodes,  int year,  double rating,  int ratingCount,  List<String> genres,  List<String> countries,  List<MoviePerson> actors,  List<String> directors,  String trailerUrl,  List<MovieStreamServer> servers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MovieDetail() when $default != null:
return $default(_that.id,_that.imdbId,_that.tmdbId,_that.tmdbType,_that.slug,_that.title,_that.originalTitle,_that.posterUrl,_that.backdropUrl,_that.description,_that.status,_that.type,_that.quality,_that.language,_that.runtime,_that.currentEpisode,_that.totalEpisodes,_that.year,_that.rating,_that.ratingCount,_that.genres,_that.countries,_that.actors,_that.directors,_that.trailerUrl,_that.servers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String imdbId,  String tmdbId,  String tmdbType,  String slug,  String title,  String originalTitle,  String posterUrl,  String backdropUrl,  String description,  String status,  String type,  String quality,  String language,  String runtime,  String currentEpisode,  String totalEpisodes,  int year,  double rating,  int ratingCount,  List<String> genres,  List<String> countries,  List<MoviePerson> actors,  List<String> directors,  String trailerUrl,  List<MovieStreamServer> servers)  $default,) {final _that = this;
switch (_that) {
case _MovieDetail():
return $default(_that.id,_that.imdbId,_that.tmdbId,_that.tmdbType,_that.slug,_that.title,_that.originalTitle,_that.posterUrl,_that.backdropUrl,_that.description,_that.status,_that.type,_that.quality,_that.language,_that.runtime,_that.currentEpisode,_that.totalEpisodes,_that.year,_that.rating,_that.ratingCount,_that.genres,_that.countries,_that.actors,_that.directors,_that.trailerUrl,_that.servers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String imdbId,  String tmdbId,  String tmdbType,  String slug,  String title,  String originalTitle,  String posterUrl,  String backdropUrl,  String description,  String status,  String type,  String quality,  String language,  String runtime,  String currentEpisode,  String totalEpisodes,  int year,  double rating,  int ratingCount,  List<String> genres,  List<String> countries,  List<MoviePerson> actors,  List<String> directors,  String trailerUrl,  List<MovieStreamServer> servers)?  $default,) {final _that = this;
switch (_that) {
case _MovieDetail() when $default != null:
return $default(_that.id,_that.imdbId,_that.tmdbId,_that.tmdbType,_that.slug,_that.title,_that.originalTitle,_that.posterUrl,_that.backdropUrl,_that.description,_that.status,_that.type,_that.quality,_that.language,_that.runtime,_that.currentEpisode,_that.totalEpisodes,_that.year,_that.rating,_that.ratingCount,_that.genres,_that.countries,_that.actors,_that.directors,_that.trailerUrl,_that.servers);case _:
  return null;

}
}

}

/// @nodoc


class _MovieDetail extends MovieDetail {
  const _MovieDetail({required this.id, this.imdbId = '', this.tmdbId = '', this.tmdbType = '', required this.slug, required this.title, required this.originalTitle, required this.posterUrl, required this.backdropUrl, required this.description, required this.status, required this.type, required this.quality, required this.language, required this.runtime, required this.currentEpisode, required this.totalEpisodes, required this.year, required this.rating, required this.ratingCount, required final  List<String> genres, required final  List<String> countries, required final  List<MoviePerson> actors, required final  List<String> directors, required this.trailerUrl, required final  List<MovieStreamServer> servers}): _genres = genres,_countries = countries,_actors = actors,_directors = directors,_servers = servers,super._();
  

@override final  String id;
@override@JsonKey() final  String imdbId;
@override@JsonKey() final  String tmdbId;
@override@JsonKey() final  String tmdbType;
@override final  String slug;
@override final  String title;
@override final  String originalTitle;
@override final  String posterUrl;
@override final  String backdropUrl;
@override final  String description;
@override final  String status;
@override final  String type;
@override final  String quality;
@override final  String language;
@override final  String runtime;
@override final  String currentEpisode;
@override final  String totalEpisodes;
@override final  int year;
@override final  double rating;
@override final  int ratingCount;
 final  List<String> _genres;
@override List<String> get genres {
  if (_genres is EqualUnmodifiableListView) return _genres;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_genres);
}

 final  List<String> _countries;
@override List<String> get countries {
  if (_countries is EqualUnmodifiableListView) return _countries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_countries);
}

 final  List<MoviePerson> _actors;
@override List<MoviePerson> get actors {
  if (_actors is EqualUnmodifiableListView) return _actors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_actors);
}

 final  List<String> _directors;
@override List<String> get directors {
  if (_directors is EqualUnmodifiableListView) return _directors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_directors);
}

@override final  String trailerUrl;
 final  List<MovieStreamServer> _servers;
@override List<MovieStreamServer> get servers {
  if (_servers is EqualUnmodifiableListView) return _servers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_servers);
}


/// Create a copy of MovieDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MovieDetailCopyWith<_MovieDetail> get copyWith => __$MovieDetailCopyWithImpl<_MovieDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MovieDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.imdbId, imdbId) || other.imdbId == imdbId)&&(identical(other.tmdbId, tmdbId) || other.tmdbId == tmdbId)&&(identical(other.tmdbType, tmdbType) || other.tmdbType == tmdbType)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.title, title) || other.title == title)&&(identical(other.originalTitle, originalTitle) || other.originalTitle == originalTitle)&&(identical(other.posterUrl, posterUrl) || other.posterUrl == posterUrl)&&(identical(other.backdropUrl, backdropUrl) || other.backdropUrl == backdropUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.type, type) || other.type == type)&&(identical(other.quality, quality) || other.quality == quality)&&(identical(other.language, language) || other.language == language)&&(identical(other.runtime, runtime) || other.runtime == runtime)&&(identical(other.currentEpisode, currentEpisode) || other.currentEpisode == currentEpisode)&&(identical(other.totalEpisodes, totalEpisodes) || other.totalEpisodes == totalEpisodes)&&(identical(other.year, year) || other.year == year)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.ratingCount, ratingCount) || other.ratingCount == ratingCount)&&const DeepCollectionEquality().equals(other._genres, _genres)&&const DeepCollectionEquality().equals(other._countries, _countries)&&const DeepCollectionEquality().equals(other._actors, _actors)&&const DeepCollectionEquality().equals(other._directors, _directors)&&(identical(other.trailerUrl, trailerUrl) || other.trailerUrl == trailerUrl)&&const DeepCollectionEquality().equals(other._servers, _servers));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,imdbId,tmdbId,tmdbType,slug,title,originalTitle,posterUrl,backdropUrl,description,status,type,quality,language,runtime,currentEpisode,totalEpisodes,year,rating,ratingCount,const DeepCollectionEquality().hash(_genres),const DeepCollectionEquality().hash(_countries),const DeepCollectionEquality().hash(_actors),const DeepCollectionEquality().hash(_directors),trailerUrl,const DeepCollectionEquality().hash(_servers)]);

@override
String toString() {
  return 'MovieDetail(id: $id, imdbId: $imdbId, tmdbId: $tmdbId, tmdbType: $tmdbType, slug: $slug, title: $title, originalTitle: $originalTitle, posterUrl: $posterUrl, backdropUrl: $backdropUrl, description: $description, status: $status, type: $type, quality: $quality, language: $language, runtime: $runtime, currentEpisode: $currentEpisode, totalEpisodes: $totalEpisodes, year: $year, rating: $rating, ratingCount: $ratingCount, genres: $genres, countries: $countries, actors: $actors, directors: $directors, trailerUrl: $trailerUrl, servers: $servers)';
}


}

/// @nodoc
abstract mixin class _$MovieDetailCopyWith<$Res> implements $MovieDetailCopyWith<$Res> {
  factory _$MovieDetailCopyWith(_MovieDetail value, $Res Function(_MovieDetail) _then) = __$MovieDetailCopyWithImpl;
@override @useResult
$Res call({
 String id, String imdbId, String tmdbId, String tmdbType, String slug, String title, String originalTitle, String posterUrl, String backdropUrl, String description, String status, String type, String quality, String language, String runtime, String currentEpisode, String totalEpisodes, int year, double rating, int ratingCount, List<String> genres, List<String> countries, List<MoviePerson> actors, List<String> directors, String trailerUrl, List<MovieStreamServer> servers
});




}
/// @nodoc
class __$MovieDetailCopyWithImpl<$Res>
    implements _$MovieDetailCopyWith<$Res> {
  __$MovieDetailCopyWithImpl(this._self, this._then);

  final _MovieDetail _self;
  final $Res Function(_MovieDetail) _then;

/// Create a copy of MovieDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? imdbId = null,Object? tmdbId = null,Object? tmdbType = null,Object? slug = null,Object? title = null,Object? originalTitle = null,Object? posterUrl = null,Object? backdropUrl = null,Object? description = null,Object? status = null,Object? type = null,Object? quality = null,Object? language = null,Object? runtime = null,Object? currentEpisode = null,Object? totalEpisodes = null,Object? year = null,Object? rating = null,Object? ratingCount = null,Object? genres = null,Object? countries = null,Object? actors = null,Object? directors = null,Object? trailerUrl = null,Object? servers = null,}) {
  return _then(_MovieDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,imdbId: null == imdbId ? _self.imdbId : imdbId // ignore: cast_nullable_to_non_nullable
as String,tmdbId: null == tmdbId ? _self.tmdbId : tmdbId // ignore: cast_nullable_to_non_nullable
as String,tmdbType: null == tmdbType ? _self.tmdbType : tmdbType // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,originalTitle: null == originalTitle ? _self.originalTitle : originalTitle // ignore: cast_nullable_to_non_nullable
as String,posterUrl: null == posterUrl ? _self.posterUrl : posterUrl // ignore: cast_nullable_to_non_nullable
as String,backdropUrl: null == backdropUrl ? _self.backdropUrl : backdropUrl // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,quality: null == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,runtime: null == runtime ? _self.runtime : runtime // ignore: cast_nullable_to_non_nullable
as String,currentEpisode: null == currentEpisode ? _self.currentEpisode : currentEpisode // ignore: cast_nullable_to_non_nullable
as String,totalEpisodes: null == totalEpisodes ? _self.totalEpisodes : totalEpisodes // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,ratingCount: null == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int,genres: null == genres ? _self._genres : genres // ignore: cast_nullable_to_non_nullable
as List<String>,countries: null == countries ? _self._countries : countries // ignore: cast_nullable_to_non_nullable
as List<String>,actors: null == actors ? _self._actors : actors // ignore: cast_nullable_to_non_nullable
as List<MoviePerson>,directors: null == directors ? _self._directors : directors // ignore: cast_nullable_to_non_nullable
as List<String>,trailerUrl: null == trailerUrl ? _self.trailerUrl : trailerUrl // ignore: cast_nullable_to_non_nullable
as String,servers: null == servers ? _self._servers : servers // ignore: cast_nullable_to_non_nullable
as List<MovieStreamServer>,
  ));
}


}

// dart format on
