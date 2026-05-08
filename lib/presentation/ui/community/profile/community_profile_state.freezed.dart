// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CommunityProfileState {

 String get userId; PageStatus get pageStatus; bool get processing; AppFailure? get failure; CommunityProfile? get profile; List<CommunityStory> get stories; List<CommunityPost> get posts; int get page; int get pageSize; bool get hasMore; bool get loadingMore; bool get followProcessing; Map<String, List<CommunityComment>> get commentsByPost; Set<String> get loadingCommentPostIds;
/// Create a copy of CommunityProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityProfileStateCopyWith<CommunityProfileState> get copyWith => _$CommunityProfileStateCopyWithImpl<CommunityProfileState>(this as CommunityProfileState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityProfileState&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.profile, profile) || other.profile == profile)&&const DeepCollectionEquality().equals(other.stories, stories)&&const DeepCollectionEquality().equals(other.posts, posts)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.loadingMore, loadingMore) || other.loadingMore == loadingMore)&&(identical(other.followProcessing, followProcessing) || other.followProcessing == followProcessing)&&const DeepCollectionEquality().equals(other.commentsByPost, commentsByPost)&&const DeepCollectionEquality().equals(other.loadingCommentPostIds, loadingCommentPostIds));
}


@override
int get hashCode => Object.hash(runtimeType,userId,pageStatus,processing,failure,profile,const DeepCollectionEquality().hash(stories),const DeepCollectionEquality().hash(posts),page,pageSize,hasMore,loadingMore,followProcessing,const DeepCollectionEquality().hash(commentsByPost),const DeepCollectionEquality().hash(loadingCommentPostIds));

@override
String toString() {
  return 'CommunityProfileState(userId: $userId, pageStatus: $pageStatus, processing: $processing, failure: $failure, profile: $profile, stories: $stories, posts: $posts, page: $page, pageSize: $pageSize, hasMore: $hasMore, loadingMore: $loadingMore, followProcessing: $followProcessing, commentsByPost: $commentsByPost, loadingCommentPostIds: $loadingCommentPostIds)';
}


}

/// @nodoc
abstract mixin class $CommunityProfileStateCopyWith<$Res>  {
  factory $CommunityProfileStateCopyWith(CommunityProfileState value, $Res Function(CommunityProfileState) _then) = _$CommunityProfileStateCopyWithImpl;
@useResult
$Res call({
 String userId, PageStatus pageStatus, bool processing, AppFailure? failure, CommunityProfile? profile, List<CommunityStory> stories, List<CommunityPost> posts, int page, int pageSize, bool hasMore, bool loadingMore, bool followProcessing, Map<String, List<CommunityComment>> commentsByPost, Set<String> loadingCommentPostIds
});


$AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$CommunityProfileStateCopyWithImpl<$Res>
    implements $CommunityProfileStateCopyWith<$Res> {
  _$CommunityProfileStateCopyWithImpl(this._self, this._then);

  final CommunityProfileState _self;
  final $Res Function(CommunityProfileState) _then;

/// Create a copy of CommunityProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? pageStatus = null,Object? processing = null,Object? failure = freezed,Object? profile = freezed,Object? stories = null,Object? posts = null,Object? page = null,Object? pageSize = null,Object? hasMore = null,Object? loadingMore = null,Object? followProcessing = null,Object? commentsByPost = null,Object? loadingCommentPostIds = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as CommunityProfile?,stories: null == stories ? _self.stories : stories // ignore: cast_nullable_to_non_nullable
as List<CommunityStory>,posts: null == posts ? _self.posts : posts // ignore: cast_nullable_to_non_nullable
as List<CommunityPost>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,loadingMore: null == loadingMore ? _self.loadingMore : loadingMore // ignore: cast_nullable_to_non_nullable
as bool,followProcessing: null == followProcessing ? _self.followProcessing : followProcessing // ignore: cast_nullable_to_non_nullable
as bool,commentsByPost: null == commentsByPost ? _self.commentsByPost : commentsByPost // ignore: cast_nullable_to_non_nullable
as Map<String, List<CommunityComment>>,loadingCommentPostIds: null == loadingCommentPostIds ? _self.loadingCommentPostIds : loadingCommentPostIds // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}
/// Create a copy of CommunityProfileState
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


/// Adds pattern-matching-related methods to [CommunityProfileState].
extension CommunityProfileStatePatterns on CommunityProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityProfileState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityProfileState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityProfileState value)  $default,){
final _that = this;
switch (_that) {
case _CommunityProfileState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityProfileState value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityProfileState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  PageStatus pageStatus,  bool processing,  AppFailure? failure,  CommunityProfile? profile,  List<CommunityStory> stories,  List<CommunityPost> posts,  int page,  int pageSize,  bool hasMore,  bool loadingMore,  bool followProcessing,  Map<String, List<CommunityComment>> commentsByPost,  Set<String> loadingCommentPostIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityProfileState() when $default != null:
return $default(_that.userId,_that.pageStatus,_that.processing,_that.failure,_that.profile,_that.stories,_that.posts,_that.page,_that.pageSize,_that.hasMore,_that.loadingMore,_that.followProcessing,_that.commentsByPost,_that.loadingCommentPostIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  PageStatus pageStatus,  bool processing,  AppFailure? failure,  CommunityProfile? profile,  List<CommunityStory> stories,  List<CommunityPost> posts,  int page,  int pageSize,  bool hasMore,  bool loadingMore,  bool followProcessing,  Map<String, List<CommunityComment>> commentsByPost,  Set<String> loadingCommentPostIds)  $default,) {final _that = this;
switch (_that) {
case _CommunityProfileState():
return $default(_that.userId,_that.pageStatus,_that.processing,_that.failure,_that.profile,_that.stories,_that.posts,_that.page,_that.pageSize,_that.hasMore,_that.loadingMore,_that.followProcessing,_that.commentsByPost,_that.loadingCommentPostIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  PageStatus pageStatus,  bool processing,  AppFailure? failure,  CommunityProfile? profile,  List<CommunityStory> stories,  List<CommunityPost> posts,  int page,  int pageSize,  bool hasMore,  bool loadingMore,  bool followProcessing,  Map<String, List<CommunityComment>> commentsByPost,  Set<String> loadingCommentPostIds)?  $default,) {final _that = this;
switch (_that) {
case _CommunityProfileState() when $default != null:
return $default(_that.userId,_that.pageStatus,_that.processing,_that.failure,_that.profile,_that.stories,_that.posts,_that.page,_that.pageSize,_that.hasMore,_that.loadingMore,_that.followProcessing,_that.commentsByPost,_that.loadingCommentPostIds);case _:
  return null;

}
}

}

/// @nodoc


class _CommunityProfileState extends CommunityProfileState {
  const _CommunityProfileState({required this.userId, this.pageStatus = PageStatus.initial, this.processing = false, this.failure, this.profile, final  List<CommunityStory> stories = const <CommunityStory>[], final  List<CommunityPost> posts = const <CommunityPost>[], this.page = 1, this.pageSize = IMovieRefreshConfig.communityPageSize, this.hasMore = true, this.loadingMore = false, this.followProcessing = false, final  Map<String, List<CommunityComment>> commentsByPost = const <String, List<CommunityComment>>{}, final  Set<String> loadingCommentPostIds = const <String>{}}): _stories = stories,_posts = posts,_commentsByPost = commentsByPost,_loadingCommentPostIds = loadingCommentPostIds,super._();
  

@override final  String userId;
@override@JsonKey() final  PageStatus pageStatus;
@override@JsonKey() final  bool processing;
@override final  AppFailure? failure;
@override final  CommunityProfile? profile;
 final  List<CommunityStory> _stories;
@override@JsonKey() List<CommunityStory> get stories {
  if (_stories is EqualUnmodifiableListView) return _stories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stories);
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
@override@JsonKey() final  bool followProcessing;
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


/// Create a copy of CommunityProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityProfileStateCopyWith<_CommunityProfileState> get copyWith => __$CommunityProfileStateCopyWithImpl<_CommunityProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityProfileState&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.profile, profile) || other.profile == profile)&&const DeepCollectionEquality().equals(other._stories, _stories)&&const DeepCollectionEquality().equals(other._posts, _posts)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.loadingMore, loadingMore) || other.loadingMore == loadingMore)&&(identical(other.followProcessing, followProcessing) || other.followProcessing == followProcessing)&&const DeepCollectionEquality().equals(other._commentsByPost, _commentsByPost)&&const DeepCollectionEquality().equals(other._loadingCommentPostIds, _loadingCommentPostIds));
}


@override
int get hashCode => Object.hash(runtimeType,userId,pageStatus,processing,failure,profile,const DeepCollectionEquality().hash(_stories),const DeepCollectionEquality().hash(_posts),page,pageSize,hasMore,loadingMore,followProcessing,const DeepCollectionEquality().hash(_commentsByPost),const DeepCollectionEquality().hash(_loadingCommentPostIds));

@override
String toString() {
  return 'CommunityProfileState(userId: $userId, pageStatus: $pageStatus, processing: $processing, failure: $failure, profile: $profile, stories: $stories, posts: $posts, page: $page, pageSize: $pageSize, hasMore: $hasMore, loadingMore: $loadingMore, followProcessing: $followProcessing, commentsByPost: $commentsByPost, loadingCommentPostIds: $loadingCommentPostIds)';
}


}

/// @nodoc
abstract mixin class _$CommunityProfileStateCopyWith<$Res> implements $CommunityProfileStateCopyWith<$Res> {
  factory _$CommunityProfileStateCopyWith(_CommunityProfileState value, $Res Function(_CommunityProfileState) _then) = __$CommunityProfileStateCopyWithImpl;
@override @useResult
$Res call({
 String userId, PageStatus pageStatus, bool processing, AppFailure? failure, CommunityProfile? profile, List<CommunityStory> stories, List<CommunityPost> posts, int page, int pageSize, bool hasMore, bool loadingMore, bool followProcessing, Map<String, List<CommunityComment>> commentsByPost, Set<String> loadingCommentPostIds
});


@override $AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$CommunityProfileStateCopyWithImpl<$Res>
    implements _$CommunityProfileStateCopyWith<$Res> {
  __$CommunityProfileStateCopyWithImpl(this._self, this._then);

  final _CommunityProfileState _self;
  final $Res Function(_CommunityProfileState) _then;

/// Create a copy of CommunityProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? pageStatus = null,Object? processing = null,Object? failure = freezed,Object? profile = freezed,Object? stories = null,Object? posts = null,Object? page = null,Object? pageSize = null,Object? hasMore = null,Object? loadingMore = null,Object? followProcessing = null,Object? commentsByPost = null,Object? loadingCommentPostIds = null,}) {
  return _then(_CommunityProfileState(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as CommunityProfile?,stories: null == stories ? _self._stories : stories // ignore: cast_nullable_to_non_nullable
as List<CommunityStory>,posts: null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<CommunityPost>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,loadingMore: null == loadingMore ? _self.loadingMore : loadingMore // ignore: cast_nullable_to_non_nullable
as bool,followProcessing: null == followProcessing ? _self.followProcessing : followProcessing // ignore: cast_nullable_to_non_nullable
as bool,commentsByPost: null == commentsByPost ? _self._commentsByPost : commentsByPost // ignore: cast_nullable_to_non_nullable
as Map<String, List<CommunityComment>>,loadingCommentPostIds: null == loadingCommentPostIds ? _self._loadingCommentPostIds : loadingCommentPostIds // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}

/// Create a copy of CommunityProfileState
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
