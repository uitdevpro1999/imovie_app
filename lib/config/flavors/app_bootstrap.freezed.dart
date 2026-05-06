// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_bootstrap.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppBootstrap {

 AppEnvironment get environment; AppFailure? get initializationFailure;
/// Create a copy of AppBootstrap
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppBootstrapCopyWith<AppBootstrap> get copyWith => _$AppBootstrapCopyWithImpl<AppBootstrap>(this as AppBootstrap, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppBootstrap&&(identical(other.environment, environment) || other.environment == environment)&&(identical(other.initializationFailure, initializationFailure) || other.initializationFailure == initializationFailure));
}


@override
int get hashCode => Object.hash(runtimeType,environment,initializationFailure);

@override
String toString() {
  return 'AppBootstrap(environment: $environment, initializationFailure: $initializationFailure)';
}


}

/// @nodoc
abstract mixin class $AppBootstrapCopyWith<$Res>  {
  factory $AppBootstrapCopyWith(AppBootstrap value, $Res Function(AppBootstrap) _then) = _$AppBootstrapCopyWithImpl;
@useResult
$Res call({
 AppEnvironment environment, AppFailure? initializationFailure
});


$AppEnvironmentCopyWith<$Res> get environment;$AppFailureCopyWith<$Res>? get initializationFailure;

}
/// @nodoc
class _$AppBootstrapCopyWithImpl<$Res>
    implements $AppBootstrapCopyWith<$Res> {
  _$AppBootstrapCopyWithImpl(this._self, this._then);

  final AppBootstrap _self;
  final $Res Function(AppBootstrap) _then;

/// Create a copy of AppBootstrap
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? environment = null,Object? initializationFailure = freezed,}) {
  return _then(_self.copyWith(
environment: null == environment ? _self.environment : environment // ignore: cast_nullable_to_non_nullable
as AppEnvironment,initializationFailure: freezed == initializationFailure ? _self.initializationFailure : initializationFailure // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}
/// Create a copy of AppBootstrap
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppEnvironmentCopyWith<$Res> get environment {
  
  return $AppEnvironmentCopyWith<$Res>(_self.environment, (value) {
    return _then(_self.copyWith(environment: value));
  });
}/// Create a copy of AppBootstrap
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppFailureCopyWith<$Res>? get initializationFailure {
    if (_self.initializationFailure == null) {
    return null;
  }

  return $AppFailureCopyWith<$Res>(_self.initializationFailure!, (value) {
    return _then(_self.copyWith(initializationFailure: value));
  });
}
}


/// Adds pattern-matching-related methods to [AppBootstrap].
extension AppBootstrapPatterns on AppBootstrap {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppBootstrap value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppBootstrap() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppBootstrap value)  $default,){
final _that = this;
switch (_that) {
case _AppBootstrap():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppBootstrap value)?  $default,){
final _that = this;
switch (_that) {
case _AppBootstrap() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AppEnvironment environment,  AppFailure? initializationFailure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppBootstrap() when $default != null:
return $default(_that.environment,_that.initializationFailure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AppEnvironment environment,  AppFailure? initializationFailure)  $default,) {final _that = this;
switch (_that) {
case _AppBootstrap():
return $default(_that.environment,_that.initializationFailure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AppEnvironment environment,  AppFailure? initializationFailure)?  $default,) {final _that = this;
switch (_that) {
case _AppBootstrap() when $default != null:
return $default(_that.environment,_that.initializationFailure);case _:
  return null;

}
}

}

/// @nodoc


class _AppBootstrap extends AppBootstrap {
  const _AppBootstrap({required this.environment, this.initializationFailure}): super._();
  

@override final  AppEnvironment environment;
@override final  AppFailure? initializationFailure;

/// Create a copy of AppBootstrap
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppBootstrapCopyWith<_AppBootstrap> get copyWith => __$AppBootstrapCopyWithImpl<_AppBootstrap>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppBootstrap&&(identical(other.environment, environment) || other.environment == environment)&&(identical(other.initializationFailure, initializationFailure) || other.initializationFailure == initializationFailure));
}


@override
int get hashCode => Object.hash(runtimeType,environment,initializationFailure);

@override
String toString() {
  return 'AppBootstrap(environment: $environment, initializationFailure: $initializationFailure)';
}


}

/// @nodoc
abstract mixin class _$AppBootstrapCopyWith<$Res> implements $AppBootstrapCopyWith<$Res> {
  factory _$AppBootstrapCopyWith(_AppBootstrap value, $Res Function(_AppBootstrap) _then) = __$AppBootstrapCopyWithImpl;
@override @useResult
$Res call({
 AppEnvironment environment, AppFailure? initializationFailure
});


@override $AppEnvironmentCopyWith<$Res> get environment;@override $AppFailureCopyWith<$Res>? get initializationFailure;

}
/// @nodoc
class __$AppBootstrapCopyWithImpl<$Res>
    implements _$AppBootstrapCopyWith<$Res> {
  __$AppBootstrapCopyWithImpl(this._self, this._then);

  final _AppBootstrap _self;
  final $Res Function(_AppBootstrap) _then;

/// Create a copy of AppBootstrap
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? environment = null,Object? initializationFailure = freezed,}) {
  return _then(_AppBootstrap(
environment: null == environment ? _self.environment : environment // ignore: cast_nullable_to_non_nullable
as AppEnvironment,initializationFailure: freezed == initializationFailure ? _self.initializationFailure : initializationFailure // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}

/// Create a copy of AppBootstrap
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppEnvironmentCopyWith<$Res> get environment {
  
  return $AppEnvironmentCopyWith<$Res>(_self.environment, (value) {
    return _then(_self.copyWith(environment: value));
  });
}/// Create a copy of AppBootstrap
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppFailureCopyWith<$Res>? get initializationFailure {
    if (_self.initializationFailure == null) {
    return null;
  }

  return $AppFailureCopyWith<$Res>(_self.initializationFailure!, (value) {
    return _then(_self.copyWith(initializationFailure: value));
  });
}
}

// dart format on
