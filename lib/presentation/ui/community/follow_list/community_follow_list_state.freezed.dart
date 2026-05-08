// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_follow_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CommunityFollowListState {

 String get userId; CommunityFollowListType get type; PageStatus get pageStatus; bool get processing; AppFailure? get failure; List<CommunityProfile> get profiles; int get page; int get pageSize; bool get hasMore; bool get loadingMore;
/// Create a copy of CommunityFollowListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityFollowListStateCopyWith<CommunityFollowListState> get copyWith => _$CommunityFollowListStateCopyWithImpl<CommunityFollowListState>(this as CommunityFollowListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityFollowListState&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.type, type) || other.type == type)&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure)&&const DeepCollectionEquality().equals(other.profiles, profiles)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.loadingMore, loadingMore) || other.loadingMore == loadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,userId,type,pageStatus,processing,failure,const DeepCollectionEquality().hash(profiles),page,pageSize,hasMore,loadingMore);

@override
String toString() {
  return 'CommunityFollowListState(userId: $userId, type: $type, pageStatus: $pageStatus, processing: $processing, failure: $failure, profiles: $profiles, page: $page, pageSize: $pageSize, hasMore: $hasMore, loadingMore: $loadingMore)';
}


}

/// @nodoc
abstract mixin class $CommunityFollowListStateCopyWith<$Res>  {
  factory $CommunityFollowListStateCopyWith(CommunityFollowListState value, $Res Function(CommunityFollowListState) _then) = _$CommunityFollowListStateCopyWithImpl;
@useResult
$Res call({
 String userId, CommunityFollowListType type, PageStatus pageStatus, bool processing, AppFailure? failure, List<CommunityProfile> profiles, int page, int pageSize, bool hasMore, bool loadingMore
});


$AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$CommunityFollowListStateCopyWithImpl<$Res>
    implements $CommunityFollowListStateCopyWith<$Res> {
  _$CommunityFollowListStateCopyWithImpl(this._self, this._then);

  final CommunityFollowListState _self;
  final $Res Function(CommunityFollowListState) _then;

/// Create a copy of CommunityFollowListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? type = null,Object? pageStatus = null,Object? processing = null,Object? failure = freezed,Object? profiles = null,Object? page = null,Object? pageSize = null,Object? hasMore = null,Object? loadingMore = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CommunityFollowListType,pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,profiles: null == profiles ? _self.profiles : profiles // ignore: cast_nullable_to_non_nullable
as List<CommunityProfile>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,loadingMore: null == loadingMore ? _self.loadingMore : loadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of CommunityFollowListState
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


/// Adds pattern-matching-related methods to [CommunityFollowListState].
extension CommunityFollowListStatePatterns on CommunityFollowListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityFollowListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityFollowListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityFollowListState value)  $default,){
final _that = this;
switch (_that) {
case _CommunityFollowListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityFollowListState value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityFollowListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  CommunityFollowListType type,  PageStatus pageStatus,  bool processing,  AppFailure? failure,  List<CommunityProfile> profiles,  int page,  int pageSize,  bool hasMore,  bool loadingMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityFollowListState() when $default != null:
return $default(_that.userId,_that.type,_that.pageStatus,_that.processing,_that.failure,_that.profiles,_that.page,_that.pageSize,_that.hasMore,_that.loadingMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  CommunityFollowListType type,  PageStatus pageStatus,  bool processing,  AppFailure? failure,  List<CommunityProfile> profiles,  int page,  int pageSize,  bool hasMore,  bool loadingMore)  $default,) {final _that = this;
switch (_that) {
case _CommunityFollowListState():
return $default(_that.userId,_that.type,_that.pageStatus,_that.processing,_that.failure,_that.profiles,_that.page,_that.pageSize,_that.hasMore,_that.loadingMore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  CommunityFollowListType type,  PageStatus pageStatus,  bool processing,  AppFailure? failure,  List<CommunityProfile> profiles,  int page,  int pageSize,  bool hasMore,  bool loadingMore)?  $default,) {final _that = this;
switch (_that) {
case _CommunityFollowListState() when $default != null:
return $default(_that.userId,_that.type,_that.pageStatus,_that.processing,_that.failure,_that.profiles,_that.page,_that.pageSize,_that.hasMore,_that.loadingMore);case _:
  return null;

}
}

}

/// @nodoc


class _CommunityFollowListState extends CommunityFollowListState {
  const _CommunityFollowListState({required this.userId, required this.type, this.pageStatus = PageStatus.initial, this.processing = false, this.failure, final  List<CommunityProfile> profiles = const <CommunityProfile>[], this.page = 1, this.pageSize = IMovieRefreshConfig.communityPageSize, this.hasMore = true, this.loadingMore = false}): _profiles = profiles,super._();
  

@override final  String userId;
@override final  CommunityFollowListType type;
@override@JsonKey() final  PageStatus pageStatus;
@override@JsonKey() final  bool processing;
@override final  AppFailure? failure;
 final  List<CommunityProfile> _profiles;
@override@JsonKey() List<CommunityProfile> get profiles {
  if (_profiles is EqualUnmodifiableListView) return _profiles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_profiles);
}

@override@JsonKey() final  int page;
@override@JsonKey() final  int pageSize;
@override@JsonKey() final  bool hasMore;
@override@JsonKey() final  bool loadingMore;

/// Create a copy of CommunityFollowListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityFollowListStateCopyWith<_CommunityFollowListState> get copyWith => __$CommunityFollowListStateCopyWithImpl<_CommunityFollowListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityFollowListState&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.type, type) || other.type == type)&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure)&&const DeepCollectionEquality().equals(other._profiles, _profiles)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.loadingMore, loadingMore) || other.loadingMore == loadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,userId,type,pageStatus,processing,failure,const DeepCollectionEquality().hash(_profiles),page,pageSize,hasMore,loadingMore);

@override
String toString() {
  return 'CommunityFollowListState(userId: $userId, type: $type, pageStatus: $pageStatus, processing: $processing, failure: $failure, profiles: $profiles, page: $page, pageSize: $pageSize, hasMore: $hasMore, loadingMore: $loadingMore)';
}


}

/// @nodoc
abstract mixin class _$CommunityFollowListStateCopyWith<$Res> implements $CommunityFollowListStateCopyWith<$Res> {
  factory _$CommunityFollowListStateCopyWith(_CommunityFollowListState value, $Res Function(_CommunityFollowListState) _then) = __$CommunityFollowListStateCopyWithImpl;
@override @useResult
$Res call({
 String userId, CommunityFollowListType type, PageStatus pageStatus, bool processing, AppFailure? failure, List<CommunityProfile> profiles, int page, int pageSize, bool hasMore, bool loadingMore
});


@override $AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$CommunityFollowListStateCopyWithImpl<$Res>
    implements _$CommunityFollowListStateCopyWith<$Res> {
  __$CommunityFollowListStateCopyWithImpl(this._self, this._then);

  final _CommunityFollowListState _self;
  final $Res Function(_CommunityFollowListState) _then;

/// Create a copy of CommunityFollowListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? type = null,Object? pageStatus = null,Object? processing = null,Object? failure = freezed,Object? profiles = null,Object? page = null,Object? pageSize = null,Object? hasMore = null,Object? loadingMore = null,}) {
  return _then(_CommunityFollowListState(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CommunityFollowListType,pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,profiles: null == profiles ? _self._profiles : profiles // ignore: cast_nullable_to_non_nullable
as List<CommunityProfile>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,loadingMore: null == loadingMore ? _self.loadingMore : loadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of CommunityFollowListState
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
