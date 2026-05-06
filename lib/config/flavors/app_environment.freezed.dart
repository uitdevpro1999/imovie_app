// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_environment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppEnvironment {

 String get supabaseUrl; String get supabaseAnonKey; String get ophimApiBaseUrl;
/// Create a copy of AppEnvironment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppEnvironmentCopyWith<AppEnvironment> get copyWith => _$AppEnvironmentCopyWithImpl<AppEnvironment>(this as AppEnvironment, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppEnvironment&&(identical(other.supabaseUrl, supabaseUrl) || other.supabaseUrl == supabaseUrl)&&(identical(other.supabaseAnonKey, supabaseAnonKey) || other.supabaseAnonKey == supabaseAnonKey)&&(identical(other.ophimApiBaseUrl, ophimApiBaseUrl) || other.ophimApiBaseUrl == ophimApiBaseUrl));
}


@override
int get hashCode => Object.hash(runtimeType,supabaseUrl,supabaseAnonKey,ophimApiBaseUrl);

@override
String toString() {
  return 'AppEnvironment(supabaseUrl: $supabaseUrl, supabaseAnonKey: $supabaseAnonKey, ophimApiBaseUrl: $ophimApiBaseUrl)';
}


}

/// @nodoc
abstract mixin class $AppEnvironmentCopyWith<$Res>  {
  factory $AppEnvironmentCopyWith(AppEnvironment value, $Res Function(AppEnvironment) _then) = _$AppEnvironmentCopyWithImpl;
@useResult
$Res call({
 String supabaseUrl, String supabaseAnonKey, String ophimApiBaseUrl
});




}
/// @nodoc
class _$AppEnvironmentCopyWithImpl<$Res>
    implements $AppEnvironmentCopyWith<$Res> {
  _$AppEnvironmentCopyWithImpl(this._self, this._then);

  final AppEnvironment _self;
  final $Res Function(AppEnvironment) _then;

/// Create a copy of AppEnvironment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? supabaseUrl = null,Object? supabaseAnonKey = null,Object? ophimApiBaseUrl = null,}) {
  return _then(_self.copyWith(
supabaseUrl: null == supabaseUrl ? _self.supabaseUrl : supabaseUrl // ignore: cast_nullable_to_non_nullable
as String,supabaseAnonKey: null == supabaseAnonKey ? _self.supabaseAnonKey : supabaseAnonKey // ignore: cast_nullable_to_non_nullable
as String,ophimApiBaseUrl: null == ophimApiBaseUrl ? _self.ophimApiBaseUrl : ophimApiBaseUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AppEnvironment].
extension AppEnvironmentPatterns on AppEnvironment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppEnvironment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppEnvironment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppEnvironment value)  $default,){
final _that = this;
switch (_that) {
case _AppEnvironment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppEnvironment value)?  $default,){
final _that = this;
switch (_that) {
case _AppEnvironment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String supabaseUrl,  String supabaseAnonKey,  String ophimApiBaseUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppEnvironment() when $default != null:
return $default(_that.supabaseUrl,_that.supabaseAnonKey,_that.ophimApiBaseUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String supabaseUrl,  String supabaseAnonKey,  String ophimApiBaseUrl)  $default,) {final _that = this;
switch (_that) {
case _AppEnvironment():
return $default(_that.supabaseUrl,_that.supabaseAnonKey,_that.ophimApiBaseUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String supabaseUrl,  String supabaseAnonKey,  String ophimApiBaseUrl)?  $default,) {final _that = this;
switch (_that) {
case _AppEnvironment() when $default != null:
return $default(_that.supabaseUrl,_that.supabaseAnonKey,_that.ophimApiBaseUrl);case _:
  return null;

}
}

}

/// @nodoc


class _AppEnvironment extends AppEnvironment {
  const _AppEnvironment({required this.supabaseUrl, required this.supabaseAnonKey, required this.ophimApiBaseUrl}): super._();
  

@override final  String supabaseUrl;
@override final  String supabaseAnonKey;
@override final  String ophimApiBaseUrl;

/// Create a copy of AppEnvironment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppEnvironmentCopyWith<_AppEnvironment> get copyWith => __$AppEnvironmentCopyWithImpl<_AppEnvironment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppEnvironment&&(identical(other.supabaseUrl, supabaseUrl) || other.supabaseUrl == supabaseUrl)&&(identical(other.supabaseAnonKey, supabaseAnonKey) || other.supabaseAnonKey == supabaseAnonKey)&&(identical(other.ophimApiBaseUrl, ophimApiBaseUrl) || other.ophimApiBaseUrl == ophimApiBaseUrl));
}


@override
int get hashCode => Object.hash(runtimeType,supabaseUrl,supabaseAnonKey,ophimApiBaseUrl);

@override
String toString() {
  return 'AppEnvironment(supabaseUrl: $supabaseUrl, supabaseAnonKey: $supabaseAnonKey, ophimApiBaseUrl: $ophimApiBaseUrl)';
}


}

/// @nodoc
abstract mixin class _$AppEnvironmentCopyWith<$Res> implements $AppEnvironmentCopyWith<$Res> {
  factory _$AppEnvironmentCopyWith(_AppEnvironment value, $Res Function(_AppEnvironment) _then) = __$AppEnvironmentCopyWithImpl;
@override @useResult
$Res call({
 String supabaseUrl, String supabaseAnonKey, String ophimApiBaseUrl
});




}
/// @nodoc
class __$AppEnvironmentCopyWithImpl<$Res>
    implements _$AppEnvironmentCopyWith<$Res> {
  __$AppEnvironmentCopyWithImpl(this._self, this._then);

  final _AppEnvironment _self;
  final $Res Function(_AppEnvironment) _then;

/// Create a copy of AppEnvironment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? supabaseUrl = null,Object? supabaseAnonKey = null,Object? ophimApiBaseUrl = null,}) {
  return _then(_AppEnvironment(
supabaseUrl: null == supabaseUrl ? _self.supabaseUrl : supabaseUrl // ignore: cast_nullable_to_non_nullable
as String,supabaseAnonKey: null == supabaseAnonKey ? _self.supabaseAnonKey : supabaseAnonKey // ignore: cast_nullable_to_non_nullable
as String,ophimApiBaseUrl: null == ophimApiBaseUrl ? _self.ophimApiBaseUrl : ophimApiBaseUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
