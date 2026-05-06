// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'change_password_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChangePasswordState {

 PageStatus get pageStatus; bool get processing; AppFailure? get failure; bool get currentPasswordVisible; bool get newPasswordVisible; bool get confirmPasswordVisible; String? get successMessage;
/// Create a copy of ChangePasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangePasswordStateCopyWith<ChangePasswordState> get copyWith => _$ChangePasswordStateCopyWithImpl<ChangePasswordState>(this as ChangePasswordState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangePasswordState&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.currentPasswordVisible, currentPasswordVisible) || other.currentPasswordVisible == currentPasswordVisible)&&(identical(other.newPasswordVisible, newPasswordVisible) || other.newPasswordVisible == newPasswordVisible)&&(identical(other.confirmPasswordVisible, confirmPasswordVisible) || other.confirmPasswordVisible == confirmPasswordVisible)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,pageStatus,processing,failure,currentPasswordVisible,newPasswordVisible,confirmPasswordVisible,successMessage);

@override
String toString() {
  return 'ChangePasswordState(pageStatus: $pageStatus, processing: $processing, failure: $failure, currentPasswordVisible: $currentPasswordVisible, newPasswordVisible: $newPasswordVisible, confirmPasswordVisible: $confirmPasswordVisible, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class $ChangePasswordStateCopyWith<$Res>  {
  factory $ChangePasswordStateCopyWith(ChangePasswordState value, $Res Function(ChangePasswordState) _then) = _$ChangePasswordStateCopyWithImpl;
@useResult
$Res call({
 PageStatus pageStatus, bool processing, AppFailure? failure, bool currentPasswordVisible, bool newPasswordVisible, bool confirmPasswordVisible, String? successMessage
});


$AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$ChangePasswordStateCopyWithImpl<$Res>
    implements $ChangePasswordStateCopyWith<$Res> {
  _$ChangePasswordStateCopyWithImpl(this._self, this._then);

  final ChangePasswordState _self;
  final $Res Function(ChangePasswordState) _then;

/// Create a copy of ChangePasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pageStatus = null,Object? processing = null,Object? failure = freezed,Object? currentPasswordVisible = null,Object? newPasswordVisible = null,Object? confirmPasswordVisible = null,Object? successMessage = freezed,}) {
  return _then(_self.copyWith(
pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,currentPasswordVisible: null == currentPasswordVisible ? _self.currentPasswordVisible : currentPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,newPasswordVisible: null == newPasswordVisible ? _self.newPasswordVisible : newPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,confirmPasswordVisible: null == confirmPasswordVisible ? _self.confirmPasswordVisible : confirmPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ChangePasswordState
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


/// Adds pattern-matching-related methods to [ChangePasswordState].
extension ChangePasswordStatePatterns on ChangePasswordState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChangePasswordState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChangePasswordState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChangePasswordState value)  $default,){
final _that = this;
switch (_that) {
case _ChangePasswordState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChangePasswordState value)?  $default,){
final _that = this;
switch (_that) {
case _ChangePasswordState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PageStatus pageStatus,  bool processing,  AppFailure? failure,  bool currentPasswordVisible,  bool newPasswordVisible,  bool confirmPasswordVisible,  String? successMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChangePasswordState() when $default != null:
return $default(_that.pageStatus,_that.processing,_that.failure,_that.currentPasswordVisible,_that.newPasswordVisible,_that.confirmPasswordVisible,_that.successMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PageStatus pageStatus,  bool processing,  AppFailure? failure,  bool currentPasswordVisible,  bool newPasswordVisible,  bool confirmPasswordVisible,  String? successMessage)  $default,) {final _that = this;
switch (_that) {
case _ChangePasswordState():
return $default(_that.pageStatus,_that.processing,_that.failure,_that.currentPasswordVisible,_that.newPasswordVisible,_that.confirmPasswordVisible,_that.successMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PageStatus pageStatus,  bool processing,  AppFailure? failure,  bool currentPasswordVisible,  bool newPasswordVisible,  bool confirmPasswordVisible,  String? successMessage)?  $default,) {final _that = this;
switch (_that) {
case _ChangePasswordState() when $default != null:
return $default(_that.pageStatus,_that.processing,_that.failure,_that.currentPasswordVisible,_that.newPasswordVisible,_that.confirmPasswordVisible,_that.successMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ChangePasswordState extends ChangePasswordState {
  const _ChangePasswordState({this.pageStatus = PageStatus.loaded, this.processing = false, this.failure, this.currentPasswordVisible = false, this.newPasswordVisible = false, this.confirmPasswordVisible = false, this.successMessage}): super._();
  

@override@JsonKey() final  PageStatus pageStatus;
@override@JsonKey() final  bool processing;
@override final  AppFailure? failure;
@override@JsonKey() final  bool currentPasswordVisible;
@override@JsonKey() final  bool newPasswordVisible;
@override@JsonKey() final  bool confirmPasswordVisible;
@override final  String? successMessage;

/// Create a copy of ChangePasswordState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangePasswordStateCopyWith<_ChangePasswordState> get copyWith => __$ChangePasswordStateCopyWithImpl<_ChangePasswordState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangePasswordState&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.currentPasswordVisible, currentPasswordVisible) || other.currentPasswordVisible == currentPasswordVisible)&&(identical(other.newPasswordVisible, newPasswordVisible) || other.newPasswordVisible == newPasswordVisible)&&(identical(other.confirmPasswordVisible, confirmPasswordVisible) || other.confirmPasswordVisible == confirmPasswordVisible)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,pageStatus,processing,failure,currentPasswordVisible,newPasswordVisible,confirmPasswordVisible,successMessage);

@override
String toString() {
  return 'ChangePasswordState(pageStatus: $pageStatus, processing: $processing, failure: $failure, currentPasswordVisible: $currentPasswordVisible, newPasswordVisible: $newPasswordVisible, confirmPasswordVisible: $confirmPasswordVisible, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class _$ChangePasswordStateCopyWith<$Res> implements $ChangePasswordStateCopyWith<$Res> {
  factory _$ChangePasswordStateCopyWith(_ChangePasswordState value, $Res Function(_ChangePasswordState) _then) = __$ChangePasswordStateCopyWithImpl;
@override @useResult
$Res call({
 PageStatus pageStatus, bool processing, AppFailure? failure, bool currentPasswordVisible, bool newPasswordVisible, bool confirmPasswordVisible, String? successMessage
});


@override $AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$ChangePasswordStateCopyWithImpl<$Res>
    implements _$ChangePasswordStateCopyWith<$Res> {
  __$ChangePasswordStateCopyWithImpl(this._self, this._then);

  final _ChangePasswordState _self;
  final $Res Function(_ChangePasswordState) _then;

/// Create a copy of ChangePasswordState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pageStatus = null,Object? processing = null,Object? failure = freezed,Object? currentPasswordVisible = null,Object? newPasswordVisible = null,Object? confirmPasswordVisible = null,Object? successMessage = freezed,}) {
  return _then(_ChangePasswordState(
pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,currentPasswordVisible: null == currentPasswordVisible ? _self.currentPasswordVisible : currentPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,newPasswordVisible: null == newPasswordVisible ? _self.newPasswordVisible : newPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,confirmPasswordVisible: null == confirmPasswordVisible ? _self.confirmPasswordVisible : confirmPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ChangePasswordState
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
