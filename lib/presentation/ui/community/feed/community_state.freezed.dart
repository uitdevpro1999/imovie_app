// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CommunityState {

 bool get mineOnly; PageStatus get pageStatus; bool get processing; AppFailure? get failure; List<CommunityStory> get stories; Set<String> get followedUserIds; List<CommunityPost> get posts; int get page; int get pageSize; bool get hasMore; bool get loadingMore; Map<String, List<CommunityComment>> get commentsByPost; Set<String> get loadingCommentPostIds;
/// Create a copy of CommunityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityStateCopyWith<CommunityState> get copyWith => _$CommunityStateCopyWithImpl<CommunityState>(this as CommunityState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityState&&(identical(other.mineOnly, mineOnly) || other.mineOnly == mineOnly)&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure)&&const DeepCollectionEquality().equals(other.stories, stories)&&const DeepCollectionEquality().equals(other.followedUserIds, followedUserIds)&&const DeepCollectionEquality().equals(other.posts, posts)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.loadingMore, loadingMore) || other.loadingMore == loadingMore)&&const DeepCollectionEquality().equals(other.commentsByPost, commentsByPost)&&const DeepCollectionEquality().equals(other.loadingCommentPostIds, loadingCommentPostIds));
}


@override
int get hashCode => Object.hash(runtimeType,mineOnly,pageStatus,processing,failure,const DeepCollectionEquality().hash(stories),const DeepCollectionEquality().hash(followedUserIds),const DeepCollectionEquality().hash(posts),page,pageSize,hasMore,loadingMore,const DeepCollectionEquality().hash(commentsByPost),const DeepCollectionEquality().hash(loadingCommentPostIds));

@override
String toString() {
  return 'CommunityState(mineOnly: $mineOnly, pageStatus: $pageStatus, processing: $processing, failure: $failure, stories: $stories, followedUserIds: $followedUserIds, posts: $posts, page: $page, pageSize: $pageSize, hasMore: $hasMore, loadingMore: $loadingMore, commentsByPost: $commentsByPost, loadingCommentPostIds: $loadingCommentPostIds)';
}


}

/// @nodoc
abstract mixin class $CommunityStateCopyWith<$Res>  {
  factory $CommunityStateCopyWith(CommunityState value, $Res Function(CommunityState) _then) = _$CommunityStateCopyWithImpl;
@useResult
$Res call({
 bool mineOnly, PageStatus pageStatus, bool processing, AppFailure? failure, List<CommunityStory> stories, Set<String> followedUserIds, List<CommunityPost> posts, int page, int pageSize, bool hasMore, bool loadingMore, Map<String, List<CommunityComment>> commentsByPost, Set<String> loadingCommentPostIds
});


$AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$CommunityStateCopyWithImpl<$Res>
    implements $CommunityStateCopyWith<$Res> {
  _$CommunityStateCopyWithImpl(this._self, this._then);

  final CommunityState _self;
  final $Res Function(CommunityState) _then;

/// Create a copy of CommunityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mineOnly = null,Object? pageStatus = null,Object? processing = null,Object? failure = freezed,Object? stories = null,Object? followedUserIds = null,Object? posts = null,Object? page = null,Object? pageSize = null,Object? hasMore = null,Object? loadingMore = null,Object? commentsByPost = null,Object? loadingCommentPostIds = null,}) {
  return _then(_self.copyWith(
mineOnly: null == mineOnly ? _self.mineOnly : mineOnly // ignore: cast_nullable_to_non_nullable
as bool,pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,stories: null == stories ? _self.stories : stories // ignore: cast_nullable_to_non_nullable
as List<CommunityStory>,followedUserIds: null == followedUserIds ? _self.followedUserIds : followedUserIds // ignore: cast_nullable_to_non_nullable
as Set<String>,posts: null == posts ? _self.posts : posts // ignore: cast_nullable_to_non_nullable
as List<CommunityPost>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,loadingMore: null == loadingMore ? _self.loadingMore : loadingMore // ignore: cast_nullable_to_non_nullable
as bool,commentsByPost: null == commentsByPost ? _self.commentsByPost : commentsByPost // ignore: cast_nullable_to_non_nullable
as Map<String, List<CommunityComment>>,loadingCommentPostIds: null == loadingCommentPostIds ? _self.loadingCommentPostIds : loadingCommentPostIds // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}
/// Create a copy of CommunityState
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


/// Adds pattern-matching-related methods to [CommunityState].
extension CommunityStatePatterns on CommunityState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityState value)  $default,){
final _that = this;
switch (_that) {
case _CommunityState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityState value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool mineOnly,  PageStatus pageStatus,  bool processing,  AppFailure? failure,  List<CommunityStory> stories,  Set<String> followedUserIds,  List<CommunityPost> posts,  int page,  int pageSize,  bool hasMore,  bool loadingMore,  Map<String, List<CommunityComment>> commentsByPost,  Set<String> loadingCommentPostIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityState() when $default != null:
return $default(_that.mineOnly,_that.pageStatus,_that.processing,_that.failure,_that.stories,_that.followedUserIds,_that.posts,_that.page,_that.pageSize,_that.hasMore,_that.loadingMore,_that.commentsByPost,_that.loadingCommentPostIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool mineOnly,  PageStatus pageStatus,  bool processing,  AppFailure? failure,  List<CommunityStory> stories,  Set<String> followedUserIds,  List<CommunityPost> posts,  int page,  int pageSize,  bool hasMore,  bool loadingMore,  Map<String, List<CommunityComment>> commentsByPost,  Set<String> loadingCommentPostIds)  $default,) {final _that = this;
switch (_that) {
case _CommunityState():
return $default(_that.mineOnly,_that.pageStatus,_that.processing,_that.failure,_that.stories,_that.followedUserIds,_that.posts,_that.page,_that.pageSize,_that.hasMore,_that.loadingMore,_that.commentsByPost,_that.loadingCommentPostIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool mineOnly,  PageStatus pageStatus,  bool processing,  AppFailure? failure,  List<CommunityStory> stories,  Set<String> followedUserIds,  List<CommunityPost> posts,  int page,  int pageSize,  bool hasMore,  bool loadingMore,  Map<String, List<CommunityComment>> commentsByPost,  Set<String> loadingCommentPostIds)?  $default,) {final _that = this;
switch (_that) {
case _CommunityState() when $default != null:
return $default(_that.mineOnly,_that.pageStatus,_that.processing,_that.failure,_that.stories,_that.followedUserIds,_that.posts,_that.page,_that.pageSize,_that.hasMore,_that.loadingMore,_that.commentsByPost,_that.loadingCommentPostIds);case _:
  return null;

}
}

}

/// @nodoc


class _CommunityState extends CommunityState {
  const _CommunityState({this.mineOnly = false, this.pageStatus = PageStatus.initial, this.processing = false, this.failure, final  List<CommunityStory> stories = const <CommunityStory>[], final  Set<String> followedUserIds = const <String>{}, final  List<CommunityPost> posts = const <CommunityPost>[], this.page = 1, this.pageSize = IMovieRefreshConfig.communityPageSize, this.hasMore = true, this.loadingMore = false, final  Map<String, List<CommunityComment>> commentsByPost = const <String, List<CommunityComment>>{}, final  Set<String> loadingCommentPostIds = const <String>{}}): _stories = stories,_followedUserIds = followedUserIds,_posts = posts,_commentsByPost = commentsByPost,_loadingCommentPostIds = loadingCommentPostIds,super._();
  

@override@JsonKey() final  bool mineOnly;
@override@JsonKey() final  PageStatus pageStatus;
@override@JsonKey() final  bool processing;
@override final  AppFailure? failure;
 final  List<CommunityStory> _stories;
@override@JsonKey() List<CommunityStory> get stories {
  if (_stories is EqualUnmodifiableListView) return _stories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stories);
}

 final  Set<String> _followedUserIds;
@override@JsonKey() Set<String> get followedUserIds {
  if (_followedUserIds is EqualUnmodifiableSetView) return _followedUserIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_followedUserIds);
}

 final  List<CommunityPost> _posts;
@override@JsonKey() List<CommunityPost> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}

@override@JsonKey() final  int page;
@override@JsonKey() final  int pageSize;
@override@JsonKey() final  bool hasMore;
@override@JsonKey() final  bool loadingMore;
 final  Map<String, List<CommunityComment>> _commentsByPost;
@override@JsonKey() Map<String, List<CommunityComment>> get commentsByPost {
  if (_commentsByPost is EqualUnmodifiableMapView) return _commentsByPost;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_commentsByPost);
}

 final  Set<String> _loadingCommentPostIds;
@override@JsonKey() Set<String> get loadingCommentPostIds {
  if (_loadingCommentPostIds is EqualUnmodifiableSetView) return _loadingCommentPostIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_loadingCommentPostIds);
}


/// Create a copy of CommunityState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityStateCopyWith<_CommunityState> get copyWith => __$CommunityStateCopyWithImpl<_CommunityState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityState&&(identical(other.mineOnly, mineOnly) || other.mineOnly == mineOnly)&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure)&&const DeepCollectionEquality().equals(other._stories, _stories)&&const DeepCollectionEquality().equals(other._followedUserIds, _followedUserIds)&&const DeepCollectionEquality().equals(other._posts, _posts)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.loadingMore, loadingMore) || other.loadingMore == loadingMore)&&const DeepCollectionEquality().equals(other._commentsByPost, _commentsByPost)&&const DeepCollectionEquality().equals(other._loadingCommentPostIds, _loadingCommentPostIds));
}


@override
int get hashCode => Object.hash(runtimeType,mineOnly,pageStatus,processing,failure,const DeepCollectionEquality().hash(_stories),const DeepCollectionEquality().hash(_followedUserIds),const DeepCollectionEquality().hash(_posts),page,pageSize,hasMore,loadingMore,const DeepCollectionEquality().hash(_commentsByPost),const DeepCollectionEquality().hash(_loadingCommentPostIds));

@override
String toString() {
  return 'CommunityState(mineOnly: $mineOnly, pageStatus: $pageStatus, processing: $processing, failure: $failure, stories: $stories, followedUserIds: $followedUserIds, posts: $posts, page: $page, pageSize: $pageSize, hasMore: $hasMore, loadingMore: $loadingMore, commentsByPost: $commentsByPost, loadingCommentPostIds: $loadingCommentPostIds)';
}


}

/// @nodoc
abstract mixin class _$CommunityStateCopyWith<$Res> implements $CommunityStateCopyWith<$Res> {
  factory _$CommunityStateCopyWith(_CommunityState value, $Res Function(_CommunityState) _then) = __$CommunityStateCopyWithImpl;
@override @useResult
$Res call({
 bool mineOnly, PageStatus pageStatus, bool processing, AppFailure? failure, List<CommunityStory> stories, Set<String> followedUserIds, List<CommunityPost> posts, int page, int pageSize, bool hasMore, bool loadingMore, Map<String, List<CommunityComment>> commentsByPost, Set<String> loadingCommentPostIds
});


@override $AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$CommunityStateCopyWithImpl<$Res>
    implements _$CommunityStateCopyWith<$Res> {
  __$CommunityStateCopyWithImpl(this._self, this._then);

  final _CommunityState _self;
  final $Res Function(_CommunityState) _then;

/// Create a copy of CommunityState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mineOnly = null,Object? pageStatus = null,Object? processing = null,Object? failure = freezed,Object? stories = null,Object? followedUserIds = null,Object? posts = null,Object? page = null,Object? pageSize = null,Object? hasMore = null,Object? loadingMore = null,Object? commentsByPost = null,Object? loadingCommentPostIds = null,}) {
  return _then(_CommunityState(
mineOnly: null == mineOnly ? _self.mineOnly : mineOnly // ignore: cast_nullable_to_non_nullable
as bool,pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,stories: null == stories ? _self._stories : stories // ignore: cast_nullable_to_non_nullable
as List<CommunityStory>,followedUserIds: null == followedUserIds ? _self._followedUserIds : followedUserIds // ignore: cast_nullable_to_non_nullable
as Set<String>,posts: null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<CommunityPost>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,loadingMore: null == loadingMore ? _self.loadingMore : loadingMore // ignore: cast_nullable_to_non_nullable
as bool,commentsByPost: null == commentsByPost ? _self._commentsByPost : commentsByPost // ignore: cast_nullable_to_non_nullable
as Map<String, List<CommunityComment>>,loadingCommentPostIds: null == loadingCommentPostIds ? _self._loadingCommentPostIds : loadingCommentPostIds // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}

/// Create a copy of CommunityState
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
