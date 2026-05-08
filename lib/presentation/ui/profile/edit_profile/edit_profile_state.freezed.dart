// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditProfileState {

 PageStatus get pageStatus; bool get processing; AppFailure? get failure; AppProfile? get profile; bool get isAuthenticated; Uint8List? get pendingAvatarBytes; String get pendingAvatarFileName; String get pendingAvatarContentType; Uint8List? get pendingCoverBytes; String get pendingCoverFileName; String get pendingCoverContentType; String? get actionMessage;
/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditProfileStateCopyWith<EditProfileState> get copyWith => _$EditProfileStateCopyWithImpl<EditProfileState>(this as EditProfileState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditProfileState&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.isAuthenticated, isAuthenticated) || other.isAuthenticated == isAuthenticated)&&const DeepCollectionEquality().equals(other.pendingAvatarBytes, pendingAvatarBytes)&&(identical(other.pendingAvatarFileName, pendingAvatarFileName) || other.pendingAvatarFileName == pendingAvatarFileName)&&(identical(other.pendingAvatarContentType, pendingAvatarContentType) || other.pendingAvatarContentType == pendingAvatarContentType)&&const DeepCollectionEquality().equals(other.pendingCoverBytes, pendingCoverBytes)&&(identical(other.pendingCoverFileName, pendingCoverFileName) || other.pendingCoverFileName == pendingCoverFileName)&&(identical(other.pendingCoverContentType, pendingCoverContentType) || other.pendingCoverContentType == pendingCoverContentType)&&(identical(other.actionMessage, actionMessage) || other.actionMessage == actionMessage));
}


@override
int get hashCode => Object.hash(runtimeType,pageStatus,processing,failure,profile,isAuthenticated,const DeepCollectionEquality().hash(pendingAvatarBytes),pendingAvatarFileName,pendingAvatarContentType,const DeepCollectionEquality().hash(pendingCoverBytes),pendingCoverFileName,pendingCoverContentType,actionMessage);

@override
String toString() {
  return 'EditProfileState(pageStatus: $pageStatus, processing: $processing, failure: $failure, profile: $profile, isAuthenticated: $isAuthenticated, pendingAvatarBytes: $pendingAvatarBytes, pendingAvatarFileName: $pendingAvatarFileName, pendingAvatarContentType: $pendingAvatarContentType, pendingCoverBytes: $pendingCoverBytes, pendingCoverFileName: $pendingCoverFileName, pendingCoverContentType: $pendingCoverContentType, actionMessage: $actionMessage)';
}


}

/// @nodoc
abstract mixin class $EditProfileStateCopyWith<$Res>  {
  factory $EditProfileStateCopyWith(EditProfileState value, $Res Function(EditProfileState) _then) = _$EditProfileStateCopyWithImpl;
@useResult
$Res call({
 PageStatus pageStatus, bool processing, AppFailure? failure, AppProfile? profile, bool isAuthenticated, Uint8List? pendingAvatarBytes, String pendingAvatarFileName, String pendingAvatarContentType, Uint8List? pendingCoverBytes, String pendingCoverFileName, String pendingCoverContentType, String? actionMessage
});


$AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$EditProfileStateCopyWithImpl<$Res>
    implements $EditProfileStateCopyWith<$Res> {
  _$EditProfileStateCopyWithImpl(this._self, this._then);

  final EditProfileState _self;
  final $Res Function(EditProfileState) _then;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pageStatus = null,Object? processing = null,Object? failure = freezed,Object? profile = freezed,Object? isAuthenticated = null,Object? pendingAvatarBytes = freezed,Object? pendingAvatarFileName = null,Object? pendingAvatarContentType = null,Object? pendingCoverBytes = freezed,Object? pendingCoverFileName = null,Object? pendingCoverContentType = null,Object? actionMessage = freezed,}) {
  return _then(_self.copyWith(
pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as AppProfile?,isAuthenticated: null == isAuthenticated ? _self.isAuthenticated : isAuthenticated // ignore: cast_nullable_to_non_nullable
as bool,pendingAvatarBytes: freezed == pendingAvatarBytes ? _self.pendingAvatarBytes : pendingAvatarBytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,pendingAvatarFileName: null == pendingAvatarFileName ? _self.pendingAvatarFileName : pendingAvatarFileName // ignore: cast_nullable_to_non_nullable
as String,pendingAvatarContentType: null == pendingAvatarContentType ? _self.pendingAvatarContentType : pendingAvatarContentType // ignore: cast_nullable_to_non_nullable
as String,pendingCoverBytes: freezed == pendingCoverBytes ? _self.pendingCoverBytes : pendingCoverBytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,pendingCoverFileName: null == pendingCoverFileName ? _self.pendingCoverFileName : pendingCoverFileName // ignore: cast_nullable_to_non_nullable
as String,pendingCoverContentType: null == pendingCoverContentType ? _self.pendingCoverContentType : pendingCoverContentType // ignore: cast_nullable_to_non_nullable
as String,actionMessage: freezed == actionMessage ? _self.actionMessage : actionMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of EditProfileState
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


/// Adds pattern-matching-related methods to [EditProfileState].
extension EditProfileStatePatterns on EditProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EditProfileState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EditProfileState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EditProfileState value)  $default,){
final _that = this;
switch (_that) {
case _EditProfileState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EditProfileState value)?  $default,){
final _that = this;
switch (_that) {
case _EditProfileState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PageStatus pageStatus,  bool processing,  AppFailure? failure,  AppProfile? profile,  bool isAuthenticated,  Uint8List? pendingAvatarBytes,  String pendingAvatarFileName,  String pendingAvatarContentType,  Uint8List? pendingCoverBytes,  String pendingCoverFileName,  String pendingCoverContentType,  String? actionMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EditProfileState() when $default != null:
return $default(_that.pageStatus,_that.processing,_that.failure,_that.profile,_that.isAuthenticated,_that.pendingAvatarBytes,_that.pendingAvatarFileName,_that.pendingAvatarContentType,_that.pendingCoverBytes,_that.pendingCoverFileName,_that.pendingCoverContentType,_that.actionMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PageStatus pageStatus,  bool processing,  AppFailure? failure,  AppProfile? profile,  bool isAuthenticated,  Uint8List? pendingAvatarBytes,  String pendingAvatarFileName,  String pendingAvatarContentType,  Uint8List? pendingCoverBytes,  String pendingCoverFileName,  String pendingCoverContentType,  String? actionMessage)  $default,) {final _that = this;
switch (_that) {
case _EditProfileState():
return $default(_that.pageStatus,_that.processing,_that.failure,_that.profile,_that.isAuthenticated,_that.pendingAvatarBytes,_that.pendingAvatarFileName,_that.pendingAvatarContentType,_that.pendingCoverBytes,_that.pendingCoverFileName,_that.pendingCoverContentType,_that.actionMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PageStatus pageStatus,  bool processing,  AppFailure? failure,  AppProfile? profile,  bool isAuthenticated,  Uint8List? pendingAvatarBytes,  String pendingAvatarFileName,  String pendingAvatarContentType,  Uint8List? pendingCoverBytes,  String pendingCoverFileName,  String pendingCoverContentType,  String? actionMessage)?  $default,) {final _that = this;
switch (_that) {
case _EditProfileState() when $default != null:
return $default(_that.pageStatus,_that.processing,_that.failure,_that.profile,_that.isAuthenticated,_that.pendingAvatarBytes,_that.pendingAvatarFileName,_that.pendingAvatarContentType,_that.pendingCoverBytes,_that.pendingCoverFileName,_that.pendingCoverContentType,_that.actionMessage);case _:
  return null;

}
}

}

/// @nodoc


class _EditProfileState extends EditProfileState {
  const _EditProfileState({this.pageStatus = PageStatus.initial, this.processing = false, this.failure, this.profile, this.isAuthenticated = false, this.pendingAvatarBytes, this.pendingAvatarFileName = '', this.pendingAvatarContentType = '', this.pendingCoverBytes, this.pendingCoverFileName = '', this.pendingCoverContentType = '', this.actionMessage}): super._();
  

@override@JsonKey() final  PageStatus pageStatus;
@override@JsonKey() final  bool processing;
@override final  AppFailure? failure;
@override final  AppProfile? profile;
@override@JsonKey() final  bool isAuthenticated;
@override final  Uint8List? pendingAvatarBytes;
@override@JsonKey() final  String pendingAvatarFileName;
@override@JsonKey() final  String pendingAvatarContentType;
@override final  Uint8List? pendingCoverBytes;
@override@JsonKey() final  String pendingCoverFileName;
@override@JsonKey() final  String pendingCoverContentType;
@override final  String? actionMessage;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditProfileStateCopyWith<_EditProfileState> get copyWith => __$EditProfileStateCopyWithImpl<_EditProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditProfileState&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.isAuthenticated, isAuthenticated) || other.isAuthenticated == isAuthenticated)&&const DeepCollectionEquality().equals(other.pendingAvatarBytes, pendingAvatarBytes)&&(identical(other.pendingAvatarFileName, pendingAvatarFileName) || other.pendingAvatarFileName == pendingAvatarFileName)&&(identical(other.pendingAvatarContentType, pendingAvatarContentType) || other.pendingAvatarContentType == pendingAvatarContentType)&&const DeepCollectionEquality().equals(other.pendingCoverBytes, pendingCoverBytes)&&(identical(other.pendingCoverFileName, pendingCoverFileName) || other.pendingCoverFileName == pendingCoverFileName)&&(identical(other.pendingCoverContentType, pendingCoverContentType) || other.pendingCoverContentType == pendingCoverContentType)&&(identical(other.actionMessage, actionMessage) || other.actionMessage == actionMessage));
}


@override
int get hashCode => Object.hash(runtimeType,pageStatus,processing,failure,profile,isAuthenticated,const DeepCollectionEquality().hash(pendingAvatarBytes),pendingAvatarFileName,pendingAvatarContentType,const DeepCollectionEquality().hash(pendingCoverBytes),pendingCoverFileName,pendingCoverContentType,actionMessage);

@override
String toString() {
  return 'EditProfileState(pageStatus: $pageStatus, processing: $processing, failure: $failure, profile: $profile, isAuthenticated: $isAuthenticated, pendingAvatarBytes: $pendingAvatarBytes, pendingAvatarFileName: $pendingAvatarFileName, pendingAvatarContentType: $pendingAvatarContentType, pendingCoverBytes: $pendingCoverBytes, pendingCoverFileName: $pendingCoverFileName, pendingCoverContentType: $pendingCoverContentType, actionMessage: $actionMessage)';
}


}

/// @nodoc
abstract mixin class _$EditProfileStateCopyWith<$Res> implements $EditProfileStateCopyWith<$Res> {
  factory _$EditProfileStateCopyWith(_EditProfileState value, $Res Function(_EditProfileState) _then) = __$EditProfileStateCopyWithImpl;
@override @useResult
$Res call({
 PageStatus pageStatus, bool processing, AppFailure? failure, AppProfile? profile, bool isAuthenticated, Uint8List? pendingAvatarBytes, String pendingAvatarFileName, String pendingAvatarContentType, Uint8List? pendingCoverBytes, String pendingCoverFileName, String pendingCoverContentType, String? actionMessage
});


@override $AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$EditProfileStateCopyWithImpl<$Res>
    implements _$EditProfileStateCopyWith<$Res> {
  __$EditProfileStateCopyWithImpl(this._self, this._then);

  final _EditProfileState _self;
  final $Res Function(_EditProfileState) _then;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pageStatus = null,Object? processing = null,Object? failure = freezed,Object? profile = freezed,Object? isAuthenticated = null,Object? pendingAvatarBytes = freezed,Object? pendingAvatarFileName = null,Object? pendingAvatarContentType = null,Object? pendingCoverBytes = freezed,Object? pendingCoverFileName = null,Object? pendingCoverContentType = null,Object? actionMessage = freezed,}) {
  return _then(_EditProfileState(
pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as AppProfile?,isAuthenticated: null == isAuthenticated ? _self.isAuthenticated : isAuthenticated // ignore: cast_nullable_to_non_nullable
as bool,pendingAvatarBytes: freezed == pendingAvatarBytes ? _self.pendingAvatarBytes : pendingAvatarBytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,pendingAvatarFileName: null == pendingAvatarFileName ? _self.pendingAvatarFileName : pendingAvatarFileName // ignore: cast_nullable_to_non_nullable
as String,pendingAvatarContentType: null == pendingAvatarContentType ? _self.pendingAvatarContentType : pendingAvatarContentType // ignore: cast_nullable_to_non_nullable
as String,pendingCoverBytes: freezed == pendingCoverBytes ? _self.pendingCoverBytes : pendingCoverBytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,pendingCoverFileName: null == pendingCoverFileName ? _self.pendingCoverFileName : pendingCoverFileName // ignore: cast_nullable_to_non_nullable
as String,pendingCoverContentType: null == pendingCoverContentType ? _self.pendingCoverContentType : pendingCoverContentType // ignore: cast_nullable_to_non_nullable
as String,actionMessage: freezed == actionMessage ? _self.actionMessage : actionMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of EditProfileState
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
