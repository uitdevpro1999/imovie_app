// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthState {

 AuthMode get mode; PageStatus get pageStatus; bool get processing; AppFailure? get failure; bool get rememberMe; bool get acceptedTerms; bool get passwordVisible; String? get successMessage;
/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthStateCopyWith<AuthState> get copyWith => _$AuthStateCopyWithImpl<AuthState>(this as AuthState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.rememberMe, rememberMe) || other.rememberMe == rememberMe)&&(identical(other.acceptedTerms, acceptedTerms) || other.acceptedTerms == acceptedTerms)&&(identical(other.passwordVisible, passwordVisible) || other.passwordVisible == passwordVisible)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,mode,pageStatus,processing,failure,rememberMe,acceptedTerms,passwordVisible,successMessage);

@override
String toString() {
  return 'AuthState(mode: $mode, pageStatus: $pageStatus, processing: $processing, failure: $failure, rememberMe: $rememberMe, acceptedTerms: $acceptedTerms, passwordVisible: $passwordVisible, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class $AuthStateCopyWith<$Res>  {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) _then) = _$AuthStateCopyWithImpl;
@useResult
$Res call({
 AuthMode mode, PageStatus pageStatus, bool processing, AppFailure? failure, bool rememberMe, bool acceptedTerms, bool passwordVisible, String? successMessage
});


$AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$AuthStateCopyWithImpl<$Res>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._self, this._then);

  final AuthState _self;
  final $Res Function(AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mode = null,Object? pageStatus = null,Object? processing = null,Object? failure = freezed,Object? rememberMe = null,Object? acceptedTerms = null,Object? passwordVisible = null,Object? successMessage = freezed,}) {
  return _then(_self.copyWith(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as AuthMode,pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,rememberMe: null == rememberMe ? _self.rememberMe : rememberMe // ignore: cast_nullable_to_non_nullable
as bool,acceptedTerms: null == acceptedTerms ? _self.acceptedTerms : acceptedTerms // ignore: cast_nullable_to_non_nullable
as bool,passwordVisible: null == passwordVisible ? _self.passwordVisible : passwordVisible // ignore: cast_nullable_to_non_nullable
as bool,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of AuthState
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


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthState value)  $default,){
final _that = this;
switch (_that) {
case _AuthState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthState value)?  $default,){
final _that = this;
switch (_that) {
case _AuthState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AuthMode mode,  PageStatus pageStatus,  bool processing,  AppFailure? failure,  bool rememberMe,  bool acceptedTerms,  bool passwordVisible,  String? successMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that.mode,_that.pageStatus,_that.processing,_that.failure,_that.rememberMe,_that.acceptedTerms,_that.passwordVisible,_that.successMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AuthMode mode,  PageStatus pageStatus,  bool processing,  AppFailure? failure,  bool rememberMe,  bool acceptedTerms,  bool passwordVisible,  String? successMessage)  $default,) {final _that = this;
switch (_that) {
case _AuthState():
return $default(_that.mode,_that.pageStatus,_that.processing,_that.failure,_that.rememberMe,_that.acceptedTerms,_that.passwordVisible,_that.successMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AuthMode mode,  PageStatus pageStatus,  bool processing,  AppFailure? failure,  bool rememberMe,  bool acceptedTerms,  bool passwordVisible,  String? successMessage)?  $default,) {final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that.mode,_that.pageStatus,_that.processing,_that.failure,_that.rememberMe,_that.acceptedTerms,_that.passwordVisible,_that.successMessage);case _:
  return null;

}
}

}

/// @nodoc


class _AuthState extends AuthState {
  const _AuthState({required this.mode, this.pageStatus = PageStatus.loaded, this.processing = false, this.failure, this.rememberMe = true, this.acceptedTerms = true, this.passwordVisible = false, this.successMessage}): super._();
  

@override final  AuthMode mode;
@override@JsonKey() final  PageStatus pageStatus;
@override@JsonKey() final  bool processing;
@override final  AppFailure? failure;
@override@JsonKey() final  bool rememberMe;
@override@JsonKey() final  bool acceptedTerms;
@override@JsonKey() final  bool passwordVisible;
@override final  String? successMessage;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthStateCopyWith<_AuthState> get copyWith => __$AuthStateCopyWithImpl<_AuthState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthState&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.rememberMe, rememberMe) || other.rememberMe == rememberMe)&&(identical(other.acceptedTerms, acceptedTerms) || other.acceptedTerms == acceptedTerms)&&(identical(other.passwordVisible, passwordVisible) || other.passwordVisible == passwordVisible)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,mode,pageStatus,processing,failure,rememberMe,acceptedTerms,passwordVisible,successMessage);

@override
String toString() {
  return 'AuthState(mode: $mode, pageStatus: $pageStatus, processing: $processing, failure: $failure, rememberMe: $rememberMe, acceptedTerms: $acceptedTerms, passwordVisible: $passwordVisible, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class _$AuthStateCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthStateCopyWith(_AuthState value, $Res Function(_AuthState) _then) = __$AuthStateCopyWithImpl;
@override @useResult
$Res call({
 AuthMode mode, PageStatus pageStatus, bool processing, AppFailure? failure, bool rememberMe, bool acceptedTerms, bool passwordVisible, String? successMessage
});


@override $AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$AuthStateCopyWithImpl<$Res>
    implements _$AuthStateCopyWith<$Res> {
  __$AuthStateCopyWithImpl(this._self, this._then);

  final _AuthState _self;
  final $Res Function(_AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mode = null,Object? pageStatus = null,Object? processing = null,Object? failure = freezed,Object? rememberMe = null,Object? acceptedTerms = null,Object? passwordVisible = null,Object? successMessage = freezed,}) {
  return _then(_AuthState(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as AuthMode,pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,rememberMe: null == rememberMe ? _self.rememberMe : rememberMe // ignore: cast_nullable_to_non_nullable
as bool,acceptedTerms: null == acceptedTerms ? _self.acceptedTerms : acceptedTerms // ignore: cast_nullable_to_non_nullable
as bool,passwordVisible: null == passwordVisible ? _self.passwordVisible : passwordVisible // ignore: cast_nullable_to_non_nullable
as bool,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AuthState
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
