// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_movie.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeMovie {

 String get id; String get title; String get originalTitle; String get slug; String get posterUrl; String get durationLabel; String get episodeLabel; String get qualityLabel; String get languageLabel; int get year; String get type; List<String> get categories; List<String> get countries; double get rating; DateTime? get modifiedAt;
/// Create a copy of HomeMovie
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeMovieCopyWith<HomeMovie> get copyWith => _$HomeMovieCopyWithImpl<HomeMovie>(this as HomeMovie, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeMovie&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.originalTitle, originalTitle) || other.originalTitle == originalTitle)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.posterUrl, posterUrl) || other.posterUrl == posterUrl)&&(identical(other.durationLabel, durationLabel) || other.durationLabel == durationLabel)&&(identical(other.episodeLabel, episodeLabel) || other.episodeLabel == episodeLabel)&&(identical(other.qualityLabel, qualityLabel) || other.qualityLabel == qualityLabel)&&(identical(other.languageLabel, languageLabel) || other.languageLabel == languageLabel)&&(identical(other.year, year) || other.year == year)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.categories, categories)&&const DeepCollectionEquality().equals(other.countries, countries)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.modifiedAt, modifiedAt) || other.modifiedAt == modifiedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,originalTitle,slug,posterUrl,durationLabel,episodeLabel,qualityLabel,languageLabel,year,type,const DeepCollectionEquality().hash(categories),const DeepCollectionEquality().hash(countries),rating,modifiedAt);

@override
String toString() {
  return 'HomeMovie(id: $id, title: $title, originalTitle: $originalTitle, slug: $slug, posterUrl: $posterUrl, durationLabel: $durationLabel, episodeLabel: $episodeLabel, qualityLabel: $qualityLabel, languageLabel: $languageLabel, year: $year, type: $type, categories: $categories, countries: $countries, rating: $rating, modifiedAt: $modifiedAt)';
}


}

/// @nodoc
abstract mixin class $HomeMovieCopyWith<$Res>  {
  factory $HomeMovieCopyWith(HomeMovie value, $Res Function(HomeMovie) _then) = _$HomeMovieCopyWithImpl;
@useResult
$Res call({
 String id, String title, String originalTitle, String slug, String posterUrl, String durationLabel, String episodeLabel, String qualityLabel, String languageLabel, int year, String type, List<String> categories, List<String> countries, double rating, DateTime? modifiedAt
});




}
/// @nodoc
class _$HomeMovieCopyWithImpl<$Res>
    implements $HomeMovieCopyWith<$Res> {
  _$HomeMovieCopyWithImpl(this._self, this._then);

  final HomeMovie _self;
  final $Res Function(HomeMovie) _then;

/// Create a copy of HomeMovie
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? originalTitle = null,Object? slug = null,Object? posterUrl = null,Object? durationLabel = null,Object? episodeLabel = null,Object? qualityLabel = null,Object? languageLabel = null,Object? year = null,Object? type = null,Object? categories = null,Object? countries = null,Object? rating = null,Object? modifiedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,originalTitle: null == originalTitle ? _self.originalTitle : originalTitle // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,posterUrl: null == posterUrl ? _self.posterUrl : posterUrl // ignore: cast_nullable_to_non_nullable
as String,durationLabel: null == durationLabel ? _self.durationLabel : durationLabel // ignore: cast_nullable_to_non_nullable
as String,episodeLabel: null == episodeLabel ? _self.episodeLabel : episodeLabel // ignore: cast_nullable_to_non_nullable
as String,qualityLabel: null == qualityLabel ? _self.qualityLabel : qualityLabel // ignore: cast_nullable_to_non_nullable
as String,languageLabel: null == languageLabel ? _self.languageLabel : languageLabel // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,countries: null == countries ? _self.countries : countries // ignore: cast_nullable_to_non_nullable
as List<String>,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,modifiedAt: freezed == modifiedAt ? _self.modifiedAt : modifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeMovie].
extension HomeMoviePatterns on HomeMovie {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeMovie value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeMovie() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeMovie value)  $default,){
final _that = this;
switch (_that) {
case _HomeMovie():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeMovie value)?  $default,){
final _that = this;
switch (_that) {
case _HomeMovie() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String originalTitle,  String slug,  String posterUrl,  String durationLabel,  String episodeLabel,  String qualityLabel,  String languageLabel,  int year,  String type,  List<String> categories,  List<String> countries,  double rating,  DateTime? modifiedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeMovie() when $default != null:
return $default(_that.id,_that.title,_that.originalTitle,_that.slug,_that.posterUrl,_that.durationLabel,_that.episodeLabel,_that.qualityLabel,_that.languageLabel,_that.year,_that.type,_that.categories,_that.countries,_that.rating,_that.modifiedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String originalTitle,  String slug,  String posterUrl,  String durationLabel,  String episodeLabel,  String qualityLabel,  String languageLabel,  int year,  String type,  List<String> categories,  List<String> countries,  double rating,  DateTime? modifiedAt)  $default,) {final _that = this;
switch (_that) {
case _HomeMovie():
return $default(_that.id,_that.title,_that.originalTitle,_that.slug,_that.posterUrl,_that.durationLabel,_that.episodeLabel,_that.qualityLabel,_that.languageLabel,_that.year,_that.type,_that.categories,_that.countries,_that.rating,_that.modifiedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String originalTitle,  String slug,  String posterUrl,  String durationLabel,  String episodeLabel,  String qualityLabel,  String languageLabel,  int year,  String type,  List<String> categories,  List<String> countries,  double rating,  DateTime? modifiedAt)?  $default,) {final _that = this;
switch (_that) {
case _HomeMovie() when $default != null:
return $default(_that.id,_that.title,_that.originalTitle,_that.slug,_that.posterUrl,_that.durationLabel,_that.episodeLabel,_that.qualityLabel,_that.languageLabel,_that.year,_that.type,_that.categories,_that.countries,_that.rating,_that.modifiedAt);case _:
  return null;

}
}

}

/// @nodoc


class _HomeMovie extends HomeMovie {
  const _HomeMovie({required this.id, required this.title, required this.originalTitle, required this.slug, required this.posterUrl, required this.durationLabel, required this.episodeLabel, required this.qualityLabel, required this.languageLabel, required this.year, required this.type, required final  List<String> categories, required final  List<String> countries, required this.rating, required this.modifiedAt}): _categories = categories,_countries = countries,super._();
  

@override final  String id;
@override final  String title;
@override final  String originalTitle;
@override final  String slug;
@override final  String posterUrl;
@override final  String durationLabel;
@override final  String episodeLabel;
@override final  String qualityLabel;
@override final  String languageLabel;
@override final  int year;
@override final  String type;
 final  List<String> _categories;
@override List<String> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  List<String> _countries;
@override List<String> get countries {
  if (_countries is EqualUnmodifiableListView) return _countries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_countries);
}

@override final  double rating;
@override final  DateTime? modifiedAt;

/// Create a copy of HomeMovie
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeMovieCopyWith<_HomeMovie> get copyWith => __$HomeMovieCopyWithImpl<_HomeMovie>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeMovie&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.originalTitle, originalTitle) || other.originalTitle == originalTitle)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.posterUrl, posterUrl) || other.posterUrl == posterUrl)&&(identical(other.durationLabel, durationLabel) || other.durationLabel == durationLabel)&&(identical(other.episodeLabel, episodeLabel) || other.episodeLabel == episodeLabel)&&(identical(other.qualityLabel, qualityLabel) || other.qualityLabel == qualityLabel)&&(identical(other.languageLabel, languageLabel) || other.languageLabel == languageLabel)&&(identical(other.year, year) || other.year == year)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._categories, _categories)&&const DeepCollectionEquality().equals(other._countries, _countries)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.modifiedAt, modifiedAt) || other.modifiedAt == modifiedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,originalTitle,slug,posterUrl,durationLabel,episodeLabel,qualityLabel,languageLabel,year,type,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_countries),rating,modifiedAt);

@override
String toString() {
  return 'HomeMovie(id: $id, title: $title, originalTitle: $originalTitle, slug: $slug, posterUrl: $posterUrl, durationLabel: $durationLabel, episodeLabel: $episodeLabel, qualityLabel: $qualityLabel, languageLabel: $languageLabel, year: $year, type: $type, categories: $categories, countries: $countries, rating: $rating, modifiedAt: $modifiedAt)';
}


}

/// @nodoc
abstract mixin class _$HomeMovieCopyWith<$Res> implements $HomeMovieCopyWith<$Res> {
  factory _$HomeMovieCopyWith(_HomeMovie value, $Res Function(_HomeMovie) _then) = __$HomeMovieCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String originalTitle, String slug, String posterUrl, String durationLabel, String episodeLabel, String qualityLabel, String languageLabel, int year, String type, List<String> categories, List<String> countries, double rating, DateTime? modifiedAt
});




}
/// @nodoc
class __$HomeMovieCopyWithImpl<$Res>
    implements _$HomeMovieCopyWith<$Res> {
  __$HomeMovieCopyWithImpl(this._self, this._then);

  final _HomeMovie _self;
  final $Res Function(_HomeMovie) _then;

/// Create a copy of HomeMovie
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? originalTitle = null,Object? slug = null,Object? posterUrl = null,Object? durationLabel = null,Object? episodeLabel = null,Object? qualityLabel = null,Object? languageLabel = null,Object? year = null,Object? type = null,Object? categories = null,Object? countries = null,Object? rating = null,Object? modifiedAt = freezed,}) {
  return _then(_HomeMovie(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,originalTitle: null == originalTitle ? _self.originalTitle : originalTitle // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,posterUrl: null == posterUrl ? _self.posterUrl : posterUrl // ignore: cast_nullable_to_non_nullable
as String,durationLabel: null == durationLabel ? _self.durationLabel : durationLabel // ignore: cast_nullable_to_non_nullable
as String,episodeLabel: null == episodeLabel ? _self.episodeLabel : episodeLabel // ignore: cast_nullable_to_non_nullable
as String,qualityLabel: null == qualityLabel ? _self.qualityLabel : qualityLabel // ignore: cast_nullable_to_non_nullable
as String,languageLabel: null == languageLabel ? _self.languageLabel : languageLabel // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,countries: null == countries ? _self._countries : countries // ignore: cast_nullable_to_non_nullable
as List<String>,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,modifiedAt: freezed == modifiedAt ? _self.modifiedAt : modifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
