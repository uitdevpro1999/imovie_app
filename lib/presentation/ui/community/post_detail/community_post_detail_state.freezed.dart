// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_post_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CommunityPostDetailState {

 String get postId; PageStatus get pageStatus; bool get processing; AppFailure? get failure; CommunityPost? get post; List<CommunityComment> get comments; bool get loadingComments;
/// Create a copy of CommunityPostDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityPostDetailStateCopyWith<CommunityPostDetailState> get copyWith => _$CommunityPostDetailStateCopyWithImpl<CommunityPostDetailState>(this as CommunityPostDetailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityPostDetailState&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.post, post) || other.post == post)&&const DeepCollectionEquality().equals(other.comments, comments)&&(identical(other.loadingComments, loadingComments) || other.loadingComments == loadingComments));
}


@override
int get hashCode => Object.hash(runtimeType,postId,pageStatus,processing,failure,post,const DeepCollectionEquality().hash(comments),loadingComments);

@override
String toString() {
  return 'CommunityPostDetailState(postId: $postId, pageStatus: $pageStatus, processing: $processing, failure: $failure, post: $post, comments: $comments, loadingComments: $loadingComments)';
}


}

/// @nodoc
abstract mixin class $CommunityPostDetailStateCopyWith<$Res>  {
  factory $CommunityPostDetailStateCopyWith(CommunityPostDetailState value, $Res Function(CommunityPostDetailState) _then) = _$CommunityPostDetailStateCopyWithImpl;
@useResult
$Res call({
 String postId, PageStatus pageStatus, bool processing, AppFailure? failure, CommunityPost? post, List<CommunityComment> comments, bool loadingComments
});


$AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$CommunityPostDetailStateCopyWithImpl<$Res>
    implements $CommunityPostDetailStateCopyWith<$Res> {
  _$CommunityPostDetailStateCopyWithImpl(this._self, this._then);

  final CommunityPostDetailState _self;
  final $Res Function(CommunityPostDetailState) _then;

/// Create a copy of CommunityPostDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? postId = null,Object? pageStatus = null,Object? processing = null,Object? failure = freezed,Object? post = freezed,Object? comments = null,Object? loadingComments = null,}) {
  return _then(_self.copyWith(
postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String,pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,post: freezed == post ? _self.post : post // ignore: cast_nullable_to_non_nullable
as CommunityPost?,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as List<CommunityComment>,loadingComments: null == loadingComments ? _self.loadingComments : loadingComments // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of CommunityPostDetailState
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


/// Adds pattern-matching-related methods to [CommunityPostDetailState].
extension CommunityPostDetailStatePatterns on CommunityPostDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityPostDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityPostDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityPostDetailState value)  $default,){
final _that = this;
switch (_that) {
case _CommunityPostDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityPostDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityPostDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String postId,  PageStatus pageStatus,  bool processing,  AppFailure? failure,  CommunityPost? post,  List<CommunityComment> comments,  bool loadingComments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityPostDetailState() when $default != null:
return $default(_that.postId,_that.pageStatus,_that.processing,_that.failure,_that.post,_that.comments,_that.loadingComments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String postId,  PageStatus pageStatus,  bool processing,  AppFailure? failure,  CommunityPost? post,  List<CommunityComment> comments,  bool loadingComments)  $default,) {final _that = this;
switch (_that) {
case _CommunityPostDetailState():
return $default(_that.postId,_that.pageStatus,_that.processing,_that.failure,_that.post,_that.comments,_that.loadingComments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String postId,  PageStatus pageStatus,  bool processing,  AppFailure? failure,  CommunityPost? post,  List<CommunityComment> comments,  bool loadingComments)?  $default,) {final _that = this;
switch (_that) {
case _CommunityPostDetailState() when $default != null:
return $default(_that.postId,_that.pageStatus,_that.processing,_that.failure,_that.post,_that.comments,_that.loadingComments);case _:
  return null;

}
}

}

/// @nodoc


class _CommunityPostDetailState extends CommunityPostDetailState {
  const _CommunityPostDetailState({required this.postId, this.pageStatus = PageStatus.initial, this.processing = false, this.failure, this.post, final  List<CommunityComment> comments = const <CommunityComment>[], this.loadingComments = false}): _comments = comments,super._();
  

@override final  String postId;
@override@JsonKey() final  PageStatus pageStatus;
@override@JsonKey() final  bool processing;
@override final  AppFailure? failure;
@override final  CommunityPost? post;
 final  List<CommunityComment> _comments;
@override@JsonKey() List<CommunityComment> get comments {
  if (_comments is EqualUnmodifiableListView) return _comments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comments);
}

@override@JsonKey() final  bool loadingComments;

/// Create a copy of CommunityPostDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityPostDetailStateCopyWith<_CommunityPostDetailState> get copyWith => __$CommunityPostDetailStateCopyWithImpl<_CommunityPostDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityPostDetailState&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.post, post) || other.post == post)&&const DeepCollectionEquality().equals(other._comments, _comments)&&(identical(other.loadingComments, loadingComments) || other.loadingComments == loadingComments));
}


@override
int get hashCode => Object.hash(runtimeType,postId,pageStatus,processing,failure,post,const DeepCollectionEquality().hash(_comments),loadingComments);

@override
String toString() {
  return 'CommunityPostDetailState(postId: $postId, pageStatus: $pageStatus, processing: $processing, failure: $failure, post: $post, comments: $comments, loadingComments: $loadingComments)';
}


}

/// @nodoc
abstract mixin class _$CommunityPostDetailStateCopyWith<$Res> implements $CommunityPostDetailStateCopyWith<$Res> {
  factory _$CommunityPostDetailStateCopyWith(_CommunityPostDetailState value, $Res Function(_CommunityPostDetailState) _then) = __$CommunityPostDetailStateCopyWithImpl;
@override @useResult
$Res call({
 String postId, PageStatus pageStatus, bool processing, AppFailure? failure, CommunityPost? post, List<CommunityComment> comments, bool loadingComments
});


@override $AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$CommunityPostDetailStateCopyWithImpl<$Res>
    implements _$CommunityPostDetailStateCopyWith<$Res> {
  __$CommunityPostDetailStateCopyWithImpl(this._self, this._then);

  final _CommunityPostDetailState _self;
  final $Res Function(_CommunityPostDetailState) _then;

/// Create a copy of CommunityPostDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? postId = null,Object? pageStatus = null,Object? processing = null,Object? failure = freezed,Object? post = freezed,Object? comments = null,Object? loadingComments = null,}) {
  return _then(_CommunityPostDetailState(
postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String,pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,post: freezed == post ? _self.post : post // ignore: cast_nullable_to_non_nullable
as CommunityPost?,comments: null == comments ? _self._comments : comments // ignore: cast_nullable_to_non_nullable
as List<CommunityComment>,loadingComments: null == loadingComments ? _self.loadingComments : loadingComments // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of CommunityPostDetailState
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
