// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_stream_episode.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MovieStreamEpisode {

 String get name; String get slug; String get fileName; String get embedUrl; String get m3u8Url;
/// Create a copy of MovieStreamEpisode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MovieStreamEpisodeCopyWith<MovieStreamEpisode> get copyWith => _$MovieStreamEpisodeCopyWithImpl<MovieStreamEpisode>(this as MovieStreamEpisode, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MovieStreamEpisode&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.embedUrl, embedUrl) || other.embedUrl == embedUrl)&&(identical(other.m3u8Url, m3u8Url) || other.m3u8Url == m3u8Url));
}


@override
int get hashCode => Object.hash(runtimeType,name,slug,fileName,embedUrl,m3u8Url);

@override
String toString() {
  return 'MovieStreamEpisode(name: $name, slug: $slug, fileName: $fileName, embedUrl: $embedUrl, m3u8Url: $m3u8Url)';
}


}

/// @nodoc
abstract mixin class $MovieStreamEpisodeCopyWith<$Res>  {
  factory $MovieStreamEpisodeCopyWith(MovieStreamEpisode value, $Res Function(MovieStreamEpisode) _then) = _$MovieStreamEpisodeCopyWithImpl;
@useResult
$Res call({
 String name, String slug, String fileName, String embedUrl, String m3u8Url
});




}
/// @nodoc
class _$MovieStreamEpisodeCopyWithImpl<$Res>
    implements $MovieStreamEpisodeCopyWith<$Res> {
  _$MovieStreamEpisodeCopyWithImpl(this._self, this._then);

  final MovieStreamEpisode _self;
  final $Res Function(MovieStreamEpisode) _then;

/// Create a copy of MovieStreamEpisode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? slug = null,Object? fileName = null,Object? embedUrl = null,Object? m3u8Url = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,embedUrl: null == embedUrl ? _self.embedUrl : embedUrl // ignore: cast_nullable_to_non_nullable
as String,m3u8Url: null == m3u8Url ? _self.m3u8Url : m3u8Url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MovieStreamEpisode].
extension MovieStreamEpisodePatterns on MovieStreamEpisode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MovieStreamEpisode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MovieStreamEpisode() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MovieStreamEpisode value)  $default,){
final _that = this;
switch (_that) {
case _MovieStreamEpisode():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MovieStreamEpisode value)?  $default,){
final _that = this;
switch (_that) {
case _MovieStreamEpisode() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String slug,  String fileName,  String embedUrl,  String m3u8Url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MovieStreamEpisode() when $default != null:
return $default(_that.name,_that.slug,_that.fileName,_that.embedUrl,_that.m3u8Url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String slug,  String fileName,  String embedUrl,  String m3u8Url)  $default,) {final _that = this;
switch (_that) {
case _MovieStreamEpisode():
return $default(_that.name,_that.slug,_that.fileName,_that.embedUrl,_that.m3u8Url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String slug,  String fileName,  String embedUrl,  String m3u8Url)?  $default,) {final _that = this;
switch (_that) {
case _MovieStreamEpisode() when $default != null:
return $default(_that.name,_that.slug,_that.fileName,_that.embedUrl,_that.m3u8Url);case _:
  return null;

}
}

}

/// @nodoc


class _MovieStreamEpisode extends MovieStreamEpisode {
  const _MovieStreamEpisode({required this.name, required this.slug, required this.fileName, required this.embedUrl, required this.m3u8Url}): super._();
  

@override final  String name;
@override final  String slug;
@override final  String fileName;
@override final  String embedUrl;
@override final  String m3u8Url;

/// Create a copy of MovieStreamEpisode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MovieStreamEpisodeCopyWith<_MovieStreamEpisode> get copyWith => __$MovieStreamEpisodeCopyWithImpl<_MovieStreamEpisode>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MovieStreamEpisode&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.embedUrl, embedUrl) || other.embedUrl == embedUrl)&&(identical(other.m3u8Url, m3u8Url) || other.m3u8Url == m3u8Url));
}


@override
int get hashCode => Object.hash(runtimeType,name,slug,fileName,embedUrl,m3u8Url);

@override
String toString() {
  return 'MovieStreamEpisode(name: $name, slug: $slug, fileName: $fileName, embedUrl: $embedUrl, m3u8Url: $m3u8Url)';
}


}

/// @nodoc
abstract mixin class _$MovieStreamEpisodeCopyWith<$Res> implements $MovieStreamEpisodeCopyWith<$Res> {
  factory _$MovieStreamEpisodeCopyWith(_MovieStreamEpisode value, $Res Function(_MovieStreamEpisode) _then) = __$MovieStreamEpisodeCopyWithImpl;
@override @useResult
$Res call({
 String name, String slug, String fileName, String embedUrl, String m3u8Url
});




}
/// @nodoc
class __$MovieStreamEpisodeCopyWithImpl<$Res>
    implements _$MovieStreamEpisodeCopyWith<$Res> {
  __$MovieStreamEpisodeCopyWithImpl(this._self, this._then);

  final _MovieStreamEpisode _self;
  final $Res Function(_MovieStreamEpisode) _then;

/// Create a copy of MovieStreamEpisode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? slug = null,Object? fileName = null,Object? embedUrl = null,Object? m3u8Url = null,}) {
  return _then(_MovieStreamEpisode(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,embedUrl: null == embedUrl ? _self.embedUrl : embedUrl // ignore: cast_nullable_to_non_nullable
as String,m3u8Url: null == m3u8Url ? _self.m3u8Url : m3u8Url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
