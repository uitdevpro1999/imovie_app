// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_center_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationCenterState {

 PageStatus get pageStatus; bool get processing; AppFailure? get failure; int get unreadCount;
/// Create a copy of NotificationCenterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationCenterStateCopyWith<NotificationCenterState> get copyWith => _$NotificationCenterStateCopyWithImpl<NotificationCenterState>(this as NotificationCenterState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationCenterState&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount));
}


@override
int get hashCode => Object.hash(runtimeType,pageStatus,processing,failure,unreadCount);

@override
String toString() {
  return 'NotificationCenterState(pageStatus: $pageStatus, processing: $processing, failure: $failure, unreadCount: $unreadCount)';
}


}

/// @nodoc
abstract mixin class $NotificationCenterStateCopyWith<$Res>  {
  factory $NotificationCenterStateCopyWith(NotificationCenterState value, $Res Function(NotificationCenterState) _then) = _$NotificationCenterStateCopyWithImpl;
@useResult
$Res call({
 PageStatus pageStatus, bool processing, AppFailure? failure, int unreadCount
});


$AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$NotificationCenterStateCopyWithImpl<$Res>
    implements $NotificationCenterStateCopyWith<$Res> {
  _$NotificationCenterStateCopyWithImpl(this._self, this._then);

  final NotificationCenterState _self;
  final $Res Function(NotificationCenterState) _then;

/// Create a copy of NotificationCenterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pageStatus = null,Object? processing = null,Object? failure = freezed,Object? unreadCount = null,}) {
  return _then(_self.copyWith(
pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of NotificationCenterState
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


/// Adds pattern-matching-related methods to [NotificationCenterState].
extension NotificationCenterStatePatterns on NotificationCenterState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationCenterState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationCenterState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationCenterState value)  $default,){
final _that = this;
switch (_that) {
case _NotificationCenterState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationCenterState value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationCenterState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PageStatus pageStatus,  bool processing,  AppFailure? failure,  int unreadCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationCenterState() when $default != null:
return $default(_that.pageStatus,_that.processing,_that.failure,_that.unreadCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PageStatus pageStatus,  bool processing,  AppFailure? failure,  int unreadCount)  $default,) {final _that = this;
switch (_that) {
case _NotificationCenterState():
return $default(_that.pageStatus,_that.processing,_that.failure,_that.unreadCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PageStatus pageStatus,  bool processing,  AppFailure? failure,  int unreadCount)?  $default,) {final _that = this;
switch (_that) {
case _NotificationCenterState() when $default != null:
return $default(_that.pageStatus,_that.processing,_that.failure,_that.unreadCount);case _:
  return null;

}
}

}

/// @nodoc


class _NotificationCenterState extends NotificationCenterState {
  const _NotificationCenterState({this.pageStatus = PageStatus.initial, this.processing = false, this.failure, this.unreadCount = 0}): super._();
  

@override@JsonKey() final  PageStatus pageStatus;
@override@JsonKey() final  bool processing;
@override final  AppFailure? failure;
@override@JsonKey() final  int unreadCount;

/// Create a copy of NotificationCenterState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationCenterStateCopyWith<_NotificationCenterState> get copyWith => __$NotificationCenterStateCopyWithImpl<_NotificationCenterState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationCenterState&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount));
}


@override
int get hashCode => Object.hash(runtimeType,pageStatus,processing,failure,unreadCount);

@override
String toString() {
  return 'NotificationCenterState(pageStatus: $pageStatus, processing: $processing, failure: $failure, unreadCount: $unreadCount)';
}


}

/// @nodoc
abstract mixin class _$NotificationCenterStateCopyWith<$Res> implements $NotificationCenterStateCopyWith<$Res> {
  factory _$NotificationCenterStateCopyWith(_NotificationCenterState value, $Res Function(_NotificationCenterState) _then) = __$NotificationCenterStateCopyWithImpl;
@override @useResult
$Res call({
 PageStatus pageStatus, bool processing, AppFailure? failure, int unreadCount
});


@override $AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$NotificationCenterStateCopyWithImpl<$Res>
    implements _$NotificationCenterStateCopyWith<$Res> {
  __$NotificationCenterStateCopyWithImpl(this._self, this._then);

  final _NotificationCenterState _self;
  final $Res Function(_NotificationCenterState) _then;

/// Create a copy of NotificationCenterState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pageStatus = null,Object? processing = null,Object? failure = freezed,Object? unreadCount = null,}) {
  return _then(_NotificationCenterState(
pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of NotificationCenterState
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
