// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_story_viewer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CommunityStoryViewerState {

 String get storyId; PageStatus get pageStatus; bool get processing; AppFailure? get failure; List<CommunityStory> get stories; int get initialIndex;
/// Create a copy of CommunityStoryViewerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityStoryViewerStateCopyWith<CommunityStoryViewerState> get copyWith => _$CommunityStoryViewerStateCopyWithImpl<CommunityStoryViewerState>(this as CommunityStoryViewerState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityStoryViewerState&&(identical(other.storyId, storyId) || other.storyId == storyId)&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure)&&const DeepCollectionEquality().equals(other.stories, stories)&&(identical(other.initialIndex, initialIndex) || other.initialIndex == initialIndex));
}


@override
int get hashCode => Object.hash(runtimeType,storyId,pageStatus,processing,failure,const DeepCollectionEquality().hash(stories),initialIndex);

@override
String toString() {
  return 'CommunityStoryViewerState(storyId: $storyId, pageStatus: $pageStatus, processing: $processing, failure: $failure, stories: $stories, initialIndex: $initialIndex)';
}


}

/// @nodoc
abstract mixin class $CommunityStoryViewerStateCopyWith<$Res>  {
  factory $CommunityStoryViewerStateCopyWith(CommunityStoryViewerState value, $Res Function(CommunityStoryViewerState) _then) = _$CommunityStoryViewerStateCopyWithImpl;
@useResult
$Res call({
 String storyId, PageStatus pageStatus, bool processing, AppFailure? failure, List<CommunityStory> stories, int initialIndex
});


$AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$CommunityStoryViewerStateCopyWithImpl<$Res>
    implements $CommunityStoryViewerStateCopyWith<$Res> {
  _$CommunityStoryViewerStateCopyWithImpl(this._self, this._then);

  final CommunityStoryViewerState _self;
  final $Res Function(CommunityStoryViewerState) _then;

/// Create a copy of CommunityStoryViewerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? storyId = null,Object? pageStatus = null,Object? processing = null,Object? failure = freezed,Object? stories = null,Object? initialIndex = null,}) {
  return _then(_self.copyWith(
storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as String,pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,stories: null == stories ? _self.stories : stories // ignore: cast_nullable_to_non_nullable
as List<CommunityStory>,initialIndex: null == initialIndex ? _self.initialIndex : initialIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of CommunityStoryViewerState
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


/// Adds pattern-matching-related methods to [CommunityStoryViewerState].
extension CommunityStoryViewerStatePatterns on CommunityStoryViewerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityStoryViewerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityStoryViewerState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityStoryViewerState value)  $default,){
final _that = this;
switch (_that) {
case _CommunityStoryViewerState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityStoryViewerState value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityStoryViewerState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String storyId,  PageStatus pageStatus,  bool processing,  AppFailure? failure,  List<CommunityStory> stories,  int initialIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityStoryViewerState() when $default != null:
return $default(_that.storyId,_that.pageStatus,_that.processing,_that.failure,_that.stories,_that.initialIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String storyId,  PageStatus pageStatus,  bool processing,  AppFailure? failure,  List<CommunityStory> stories,  int initialIndex)  $default,) {final _that = this;
switch (_that) {
case _CommunityStoryViewerState():
return $default(_that.storyId,_that.pageStatus,_that.processing,_that.failure,_that.stories,_that.initialIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String storyId,  PageStatus pageStatus,  bool processing,  AppFailure? failure,  List<CommunityStory> stories,  int initialIndex)?  $default,) {final _that = this;
switch (_that) {
case _CommunityStoryViewerState() when $default != null:
return $default(_that.storyId,_that.pageStatus,_that.processing,_that.failure,_that.stories,_that.initialIndex);case _:
  return null;

}
}

}

/// @nodoc


class _CommunityStoryViewerState extends CommunityStoryViewerState {
  const _CommunityStoryViewerState({required this.storyId, this.pageStatus = PageStatus.initial, this.processing = false, this.failure, final  List<CommunityStory> stories = const <CommunityStory>[], this.initialIndex = 0}): _stories = stories,super._();
  

@override final  String storyId;
@override@JsonKey() final  PageStatus pageStatus;
@override@JsonKey() final  bool processing;
@override final  AppFailure? failure;
 final  List<CommunityStory> _stories;
@override@JsonKey() List<CommunityStory> get stories {
  if (_stories is EqualUnmodifiableListView) return _stories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stories);
}

@override@JsonKey() final  int initialIndex;

/// Create a copy of CommunityStoryViewerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityStoryViewerStateCopyWith<_CommunityStoryViewerState> get copyWith => __$CommunityStoryViewerStateCopyWithImpl<_CommunityStoryViewerState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityStoryViewerState&&(identical(other.storyId, storyId) || other.storyId == storyId)&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure)&&const DeepCollectionEquality().equals(other._stories, _stories)&&(identical(other.initialIndex, initialIndex) || other.initialIndex == initialIndex));
}


@override
int get hashCode => Object.hash(runtimeType,storyId,pageStatus,processing,failure,const DeepCollectionEquality().hash(_stories),initialIndex);

@override
String toString() {
  return 'CommunityStoryViewerState(storyId: $storyId, pageStatus: $pageStatus, processing: $processing, failure: $failure, stories: $stories, initialIndex: $initialIndex)';
}


}

/// @nodoc
abstract mixin class _$CommunityStoryViewerStateCopyWith<$Res> implements $CommunityStoryViewerStateCopyWith<$Res> {
  factory _$CommunityStoryViewerStateCopyWith(_CommunityStoryViewerState value, $Res Function(_CommunityStoryViewerState) _then) = __$CommunityStoryViewerStateCopyWithImpl;
@override @useResult
$Res call({
 String storyId, PageStatus pageStatus, bool processing, AppFailure? failure, List<CommunityStory> stories, int initialIndex
});


@override $AppFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$CommunityStoryViewerStateCopyWithImpl<$Res>
    implements _$CommunityStoryViewerStateCopyWith<$Res> {
  __$CommunityStoryViewerStateCopyWithImpl(this._self, this._then);

  final _CommunityStoryViewerState _self;
  final $Res Function(_CommunityStoryViewerState) _then;

/// Create a copy of CommunityStoryViewerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? storyId = null,Object? pageStatus = null,Object? processing = null,Object? failure = freezed,Object? stories = null,Object? initialIndex = null,}) {
  return _then(_CommunityStoryViewerState(
storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as String,pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,stories: null == stories ? _self._stories : stories // ignore: cast_nullable_to_non_nullable
as List<CommunityStory>,initialIndex: null == initialIndex ? _self.initialIndex : initialIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of CommunityStoryViewerState
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
