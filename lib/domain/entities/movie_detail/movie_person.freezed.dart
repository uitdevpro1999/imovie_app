// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_person.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MoviePerson {

 String get id; String get name; String get originalName; String get character; String get department; String get profileUrl;
/// Create a copy of MoviePerson
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MoviePersonCopyWith<MoviePerson> get copyWith => _$MoviePersonCopyWithImpl<MoviePerson>(this as MoviePerson, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MoviePerson&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.originalName, originalName) || other.originalName == originalName)&&(identical(other.character, character) || other.character == character)&&(identical(other.department, department) || other.department == department)&&(identical(other.profileUrl, profileUrl) || other.profileUrl == profileUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,originalName,character,department,profileUrl);

@override
String toString() {
  return 'MoviePerson(id: $id, name: $name, originalName: $originalName, character: $character, department: $department, profileUrl: $profileUrl)';
}


}

/// @nodoc
abstract mixin class $MoviePersonCopyWith<$Res>  {
  factory $MoviePersonCopyWith(MoviePerson value, $Res Function(MoviePerson) _then) = _$MoviePersonCopyWithImpl;
@useResult
$Res call({
 String id, String name, String originalName, String character, String department, String profileUrl
});




}
/// @nodoc
class _$MoviePersonCopyWithImpl<$Res>
    implements $MoviePersonCopyWith<$Res> {
  _$MoviePersonCopyWithImpl(this._self, this._then);

  final MoviePerson _self;
  final $Res Function(MoviePerson) _then;

/// Create a copy of MoviePerson
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? originalName = null,Object? character = null,Object? department = null,Object? profileUrl = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,originalName: null == originalName ? _self.originalName : originalName // ignore: cast_nullable_to_non_nullable
as String,character: null == character ? _self.character : character // ignore: cast_nullable_to_non_nullable
as String,department: null == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String,profileUrl: null == profileUrl ? _self.profileUrl : profileUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MoviePerson].
extension MoviePersonPatterns on MoviePerson {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MoviePerson value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MoviePerson() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MoviePerson value)  $default,){
final _that = this;
switch (_that) {
case _MoviePerson():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MoviePerson value)?  $default,){
final _that = this;
switch (_that) {
case _MoviePerson() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String originalName,  String character,  String department,  String profileUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MoviePerson() when $default != null:
return $default(_that.id,_that.name,_that.originalName,_that.character,_that.department,_that.profileUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String originalName,  String character,  String department,  String profileUrl)  $default,) {final _that = this;
switch (_that) {
case _MoviePerson():
return $default(_that.id,_that.name,_that.originalName,_that.character,_that.department,_that.profileUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String originalName,  String character,  String department,  String profileUrl)?  $default,) {final _that = this;
switch (_that) {
case _MoviePerson() when $default != null:
return $default(_that.id,_that.name,_that.originalName,_that.character,_that.department,_that.profileUrl);case _:
  return null;

}
}

}

/// @nodoc


class _MoviePerson extends MoviePerson {
  const _MoviePerson({required this.id, required this.name, required this.originalName, required this.character, required this.department, required this.profileUrl}): super._();
  

@override final  String id;
@override final  String name;
@override final  String originalName;
@override final  String character;
@override final  String department;
@override final  String profileUrl;

/// Create a copy of MoviePerson
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MoviePersonCopyWith<_MoviePerson> get copyWith => __$MoviePersonCopyWithImpl<_MoviePerson>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MoviePerson&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.originalName, originalName) || other.originalName == originalName)&&(identical(other.character, character) || other.character == character)&&(identical(other.department, department) || other.department == department)&&(identical(other.profileUrl, profileUrl) || other.profileUrl == profileUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,originalName,character,department,profileUrl);

@override
String toString() {
  return 'MoviePerson(id: $id, name: $name, originalName: $originalName, character: $character, department: $department, profileUrl: $profileUrl)';
}


}

/// @nodoc
abstract mixin class _$MoviePersonCopyWith<$Res> implements $MoviePersonCopyWith<$Res> {
  factory _$MoviePersonCopyWith(_MoviePerson value, $Res Function(_MoviePerson) _then) = __$MoviePersonCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String originalName, String character, String department, String profileUrl
});




}
/// @nodoc
class __$MoviePersonCopyWithImpl<$Res>
    implements _$MoviePersonCopyWith<$Res> {
  __$MoviePersonCopyWithImpl(this._self, this._then);

  final _MoviePerson _self;
  final $Res Function(_MoviePerson) _then;

/// Create a copy of MoviePerson
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? originalName = null,Object? character = null,Object? department = null,Object? profileUrl = null,}) {
  return _then(_MoviePerson(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,originalName: null == originalName ? _self.originalName : originalName // ignore: cast_nullable_to_non_nullable
as String,character: null == character ? _self.character : character // ignore: cast_nullable_to_non_nullable
as String,department: null == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String,profileUrl: null == profileUrl ? _self.profileUrl : profileUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
