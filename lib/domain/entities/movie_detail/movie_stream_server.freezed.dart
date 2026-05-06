// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_stream_server.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MovieStreamServer {

 String get name; bool get isAi; List<MovieStreamEpisode> get episodes;
/// Create a copy of MovieStreamServer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MovieStreamServerCopyWith<MovieStreamServer> get copyWith => _$MovieStreamServerCopyWithImpl<MovieStreamServer>(this as MovieStreamServer, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MovieStreamServer&&(identical(other.name, name) || other.name == name)&&(identical(other.isAi, isAi) || other.isAi == isAi)&&const DeepCollectionEquality().equals(other.episodes, episodes));
}


@override
int get hashCode => Object.hash(runtimeType,name,isAi,const DeepCollectionEquality().hash(episodes));

@override
String toString() {
  return 'MovieStreamServer(name: $name, isAi: $isAi, episodes: $episodes)';
}


}

/// @nodoc
abstract mixin class $MovieStreamServerCopyWith<$Res>  {
  factory $MovieStreamServerCopyWith(MovieStreamServer value, $Res Function(MovieStreamServer) _then) = _$MovieStreamServerCopyWithImpl;
@useResult
$Res call({
 String name, bool isAi, List<MovieStreamEpisode> episodes
});




}
/// @nodoc
class _$MovieStreamServerCopyWithImpl<$Res>
    implements $MovieStreamServerCopyWith<$Res> {
  _$MovieStreamServerCopyWithImpl(this._self, this._then);

  final MovieStreamServer _self;
  final $Res Function(MovieStreamServer) _then;

/// Create a copy of MovieStreamServer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? isAi = null,Object? episodes = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isAi: null == isAi ? _self.isAi : isAi // ignore: cast_nullable_to_non_nullable
as bool,episodes: null == episodes ? _self.episodes : episodes // ignore: cast_nullable_to_non_nullable
as List<MovieStreamEpisode>,
  ));
}

}


/// Adds pattern-matching-related methods to [MovieStreamServer].
extension MovieStreamServerPatterns on MovieStreamServer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MovieStreamServer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MovieStreamServer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MovieStreamServer value)  $default,){
final _that = this;
switch (_that) {
case _MovieStreamServer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MovieStreamServer value)?  $default,){
final _that = this;
switch (_that) {
case _MovieStreamServer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  bool isAi,  List<MovieStreamEpisode> episodes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MovieStreamServer() when $default != null:
return $default(_that.name,_that.isAi,_that.episodes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  bool isAi,  List<MovieStreamEpisode> episodes)  $default,) {final _that = this;
switch (_that) {
case _MovieStreamServer():
return $default(_that.name,_that.isAi,_that.episodes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  bool isAi,  List<MovieStreamEpisode> episodes)?  $default,) {final _that = this;
switch (_that) {
case _MovieStreamServer() when $default != null:
return $default(_that.name,_that.isAi,_that.episodes);case _:
  return null;

}
}

}

/// @nodoc


class _MovieStreamServer extends MovieStreamServer {
  const _MovieStreamServer({required this.name, required this.isAi, required final  List<MovieStreamEpisode> episodes}): _episodes = episodes,super._();
  

@override final  String name;
@override final  bool isAi;
 final  List<MovieStreamEpisode> _episodes;
@override List<MovieStreamEpisode> get episodes {
  if (_episodes is EqualUnmodifiableListView) return _episodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_episodes);
}


/// Create a copy of MovieStreamServer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MovieStreamServerCopyWith<_MovieStreamServer> get copyWith => __$MovieStreamServerCopyWithImpl<_MovieStreamServer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MovieStreamServer&&(identical(other.name, name) || other.name == name)&&(identical(other.isAi, isAi) || other.isAi == isAi)&&const DeepCollectionEquality().equals(other._episodes, _episodes));
}


@override
int get hashCode => Object.hash(runtimeType,name,isAi,const DeepCollectionEquality().hash(_episodes));

@override
String toString() {
  return 'MovieStreamServer(name: $name, isAi: $isAi, episodes: $episodes)';
}


}

/// @nodoc
abstract mixin class _$MovieStreamServerCopyWith<$Res> implements $MovieStreamServerCopyWith<$Res> {
  factory _$MovieStreamServerCopyWith(_MovieStreamServer value, $Res Function(_MovieStreamServer) _then) = __$MovieStreamServerCopyWithImpl;
@override @useResult
$Res call({
 String name, bool isAi, List<MovieStreamEpisode> episodes
});




}
/// @nodoc
class __$MovieStreamServerCopyWithImpl<$Res>
    implements _$MovieStreamServerCopyWith<$Res> {
  __$MovieStreamServerCopyWithImpl(this._self, this._then);

  final _MovieStreamServer _self;
  final $Res Function(_MovieStreamServer) _then;

/// Create a copy of MovieStreamServer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? isAi = null,Object? episodes = null,}) {
  return _then(_MovieStreamServer(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isAi: null == isAi ? _self.isAi : isAi // ignore: cast_nullable_to_non_nullable
as bool,episodes: null == episodes ? _self._episodes : episodes // ignore: cast_nullable_to_non_nullable
as List<MovieStreamEpisode>,
  ));
}


}

// dart format on
