// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppFailure {

 FailureType get type; String get message; String? get details;
/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppFailureCopyWith<AppFailure> get copyWith => _$AppFailureCopyWithImpl<AppFailure>(this as AppFailure, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppFailure&&(identical(other.type, type) || other.type == type)&&(identical(other.message, message) || other.message == message)&&(identical(other.details, details) || other.details == details));
}


@override
int get hashCode => Object.hash(runtimeType,type,message,details);

@override
String toString() {
  return 'AppFailure(type: $type, message: $message, details: $details)';
}


}

/// @nodoc
abstract mixin class $AppFailureCopyWith<$Res>  {
  factory $AppFailureCopyWith(AppFailure value, $Res Function(AppFailure) _then) = _$AppFailureCopyWithImpl;
@useResult
$Res call({
 FailureType type, String message, String? details
});




}
/// @nodoc
class _$AppFailureCopyWithImpl<$Res>
    implements $AppFailureCopyWith<$Res> {
  _$AppFailureCopyWithImpl(this._self, this._then);

  final AppFailure _self;
  final $Res Function(AppFailure) _then;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? message = null,Object? details = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FailureType,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppFailure].
extension AppFailurePatterns on AppFailure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppFailure value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppFailure() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppFailure value)  $default,){
final _that = this;
switch (_that) {
case _AppFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppFailure value)?  $default,){
final _that = this;
switch (_that) {
case _AppFailure() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FailureType type,  String message,  String? details)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppFailure() when $default != null:
return $default(_that.type,_that.message,_that.details);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FailureType type,  String message,  String? details)  $default,) {final _that = this;
switch (_that) {
case _AppFailure():
return $default(_that.type,_that.message,_that.details);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FailureType type,  String message,  String? details)?  $default,) {final _that = this;
switch (_that) {
case _AppFailure() when $default != null:
return $default(_that.type,_that.message,_that.details);case _:
  return null;

}
}

}

/// @nodoc


class _AppFailure extends AppFailure {
  const _AppFailure({required this.type, required this.message, this.details}): super._();
  

@override final  FailureType type;
@override final  String message;
@override final  String? details;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppFailureCopyWith<_AppFailure> get copyWith => __$AppFailureCopyWithImpl<_AppFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppFailure&&(identical(other.type, type) || other.type == type)&&(identical(other.message, message) || other.message == message)&&(identical(other.details, details) || other.details == details));
}


@override
int get hashCode => Object.hash(runtimeType,type,message,details);

@override
String toString() {
  return 'AppFailure(type: $type, message: $message, details: $details)';
}


}

/// @nodoc
abstract mixin class _$AppFailureCopyWith<$Res> implements $AppFailureCopyWith<$Res> {
  factory _$AppFailureCopyWith(_AppFailure value, $Res Function(_AppFailure) _then) = __$AppFailureCopyWithImpl;
@override @useResult
$Res call({
 FailureType type, String message, String? details
});




}
/// @nodoc
class __$AppFailureCopyWithImpl<$Res>
    implements _$AppFailureCopyWith<$Res> {
  __$AppFailureCopyWithImpl(this._self, this._then);

  final _AppFailure _self;
  final $Res Function(_AppFailure) _then;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? message = null,Object? details = freezed,}) {
  return _then(_AppFailure(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FailureType,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
