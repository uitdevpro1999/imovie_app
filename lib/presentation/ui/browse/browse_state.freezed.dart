// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'browse_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BrowseState {

 PageStatus get pageStatus; bool get processing; AppFailure? get failure; HomeFeed? get feed; List<HomeGenre> get genres; String get keyword; bool get searchLoading; List<HomeMovie> get searchResults;
/// Create a copy of BrowseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BrowseStateCopyWith<BrowseState> get copyWith => _$BrowseStateCopyWithImpl<BrowseState>(this as BrowseState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BrowseState&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.feed, feed) || other.feed == feed)&&const DeepCollectionEquality().equals(other.genres, genres)&&(identical(other.keyword, keyword) || other.keyword == keyword)&&(identical(other.searchLoading, searchLoading) || other.searchLoading == searchLoading)&&const DeepCollectionEquality().equals(other.searchResults, searchResults));
}


@override
int get hashCode => Object.hash(runtimeType,pageStatus,processing,failure,feed,const DeepCollectionEquality().hash(genres),keyword,searchLoading,const DeepCollectionEquality().hash(searchResults));

@override
String toString() {
  return 'BrowseState(pageStatus: $pageStatus, processing: $processing, failure: $failure, feed: $feed, genres: $genres, keyword: $keyword, searchLoading: $searchLoading, searchResults: $searchResults)';
}


}

/// @nodoc
abstract mixin class $BrowseStateCopyWith<$Res>  {
  factory $BrowseStateCopyWith(BrowseState value, $Res Function(BrowseState) _then) = _$BrowseStateCopyWithImpl;
@useResult
$Res call({
 PageStatus pageStatus, bool processing, AppFailure? failure, HomeFeed? feed, List<HomeGenre> genres, String keyword, bool searchLoading, List<HomeMovie> searchResults
});


$AppFailureCopyWith<$Res>? get failure;$HomeFeedCopyWith<$Res>? get feed;

}
/// @nodoc
class _$BrowseStateCopyWithImpl<$Res>
    implements $BrowseStateCopyWith<$Res> {
  _$BrowseStateCopyWithImpl(this._self, this._then);

  final BrowseState _self;
  final $Res Function(BrowseState) _then;

/// Create a copy of BrowseState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pageStatus = null,Object? processing = null,Object? failure = freezed,Object? feed = freezed,Object? genres = null,Object? keyword = null,Object? searchLoading = null,Object? searchResults = null,}) {
  return _then(_self.copyWith(
pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,feed: freezed == feed ? _self.feed : feed // ignore: cast_nullable_to_non_nullable
as HomeFeed?,genres: null == genres ? _self.genres : genres // ignore: cast_nullable_to_non_nullable
as List<HomeGenre>,keyword: null == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String,searchLoading: null == searchLoading ? _self.searchLoading : searchLoading // ignore: cast_nullable_to_non_nullable
as bool,searchResults: null == searchResults ? _self.searchResults : searchResults // ignore: cast_nullable_to_non_nullable
as List<HomeMovie>,
  ));
}
/// Create a copy of BrowseState
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
}/// Create a copy of BrowseState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeFeedCopyWith<$Res>? get feed {
    if (_self.feed == null) {
    return null;
  }

  return $HomeFeedCopyWith<$Res>(_self.feed!, (value) {
    return _then(_self.copyWith(feed: value));
  });
}
}


/// Adds pattern-matching-related methods to [BrowseState].
extension BrowseStatePatterns on BrowseState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BrowseState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BrowseState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BrowseState value)  $default,){
final _that = this;
switch (_that) {
case _BrowseState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BrowseState value)?  $default,){
final _that = this;
switch (_that) {
case _BrowseState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PageStatus pageStatus,  bool processing,  AppFailure? failure,  HomeFeed? feed,  List<HomeGenre> genres,  String keyword,  bool searchLoading,  List<HomeMovie> searchResults)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BrowseState() when $default != null:
return $default(_that.pageStatus,_that.processing,_that.failure,_that.feed,_that.genres,_that.keyword,_that.searchLoading,_that.searchResults);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PageStatus pageStatus,  bool processing,  AppFailure? failure,  HomeFeed? feed,  List<HomeGenre> genres,  String keyword,  bool searchLoading,  List<HomeMovie> searchResults)  $default,) {final _that = this;
switch (_that) {
case _BrowseState():
return $default(_that.pageStatus,_that.processing,_that.failure,_that.feed,_that.genres,_that.keyword,_that.searchLoading,_that.searchResults);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PageStatus pageStatus,  bool processing,  AppFailure? failure,  HomeFeed? feed,  List<HomeGenre> genres,  String keyword,  bool searchLoading,  List<HomeMovie> searchResults)?  $default,) {final _that = this;
switch (_that) {
case _BrowseState() when $default != null:
return $default(_that.pageStatus,_that.processing,_that.failure,_that.feed,_that.genres,_that.keyword,_that.searchLoading,_that.searchResults);case _:
  return null;

}
}

}

/// @nodoc


class _BrowseState extends BrowseState {
  const _BrowseState({this.pageStatus = PageStatus.initial, this.processing = false, this.failure, this.feed, final  List<HomeGenre> genres = const <HomeGenre>[], this.keyword = '', this.searchLoading = false, final  List<HomeMovie> searchResults = const <HomeMovie>[]}): _genres = genres,_searchResults = searchResults,super._();
  

@override@JsonKey() final  PageStatus pageStatus;
@override@JsonKey() final  bool processing;
@override final  AppFailure? failure;
@override final  HomeFeed? feed;
 final  List<HomeGenre> _genres;
@override@JsonKey() List<HomeGenre> get genres {
  if (_genres is EqualUnmodifiableListView) return _genres;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_genres);
}

@override@JsonKey() final  String keyword;
@override@JsonKey() final  bool searchLoading;
 final  List<HomeMovie> _searchResults;
@override@JsonKey() List<HomeMovie> get searchResults {
  if (_searchResults is EqualUnmodifiableListView) return _searchResults;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_searchResults);
}


/// Create a copy of BrowseState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BrowseStateCopyWith<_BrowseState> get copyWith => __$BrowseStateCopyWithImpl<_BrowseState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BrowseState&&(identical(other.pageStatus, pageStatus) || other.pageStatus == pageStatus)&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.feed, feed) || other.feed == feed)&&const DeepCollectionEquality().equals(other._genres, _genres)&&(identical(other.keyword, keyword) || other.keyword == keyword)&&(identical(other.searchLoading, searchLoading) || other.searchLoading == searchLoading)&&const DeepCollectionEquality().equals(other._searchResults, _searchResults));
}


@override
int get hashCode => Object.hash(runtimeType,pageStatus,processing,failure,feed,const DeepCollectionEquality().hash(_genres),keyword,searchLoading,const DeepCollectionEquality().hash(_searchResults));

@override
String toString() {
  return 'BrowseState(pageStatus: $pageStatus, processing: $processing, failure: $failure, feed: $feed, genres: $genres, keyword: $keyword, searchLoading: $searchLoading, searchResults: $searchResults)';
}


}

/// @nodoc
abstract mixin class _$BrowseStateCopyWith<$Res> implements $BrowseStateCopyWith<$Res> {
  factory _$BrowseStateCopyWith(_BrowseState value, $Res Function(_BrowseState) _then) = __$BrowseStateCopyWithImpl;
@override @useResult
$Res call({
 PageStatus pageStatus, bool processing, AppFailure? failure, HomeFeed? feed, List<HomeGenre> genres, String keyword, bool searchLoading, List<HomeMovie> searchResults
});


@override $AppFailureCopyWith<$Res>? get failure;@override $HomeFeedCopyWith<$Res>? get feed;

}
/// @nodoc
class __$BrowseStateCopyWithImpl<$Res>
    implements _$BrowseStateCopyWith<$Res> {
  __$BrowseStateCopyWithImpl(this._self, this._then);

  final _BrowseState _self;
  final $Res Function(_BrowseState) _then;

/// Create a copy of BrowseState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pageStatus = null,Object? processing = null,Object? failure = freezed,Object? feed = freezed,Object? genres = null,Object? keyword = null,Object? searchLoading = null,Object? searchResults = null,}) {
  return _then(_BrowseState(
pageStatus: null == pageStatus ? _self.pageStatus : pageStatus // ignore: cast_nullable_to_non_nullable
as PageStatus,processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,feed: freezed == feed ? _self.feed : feed // ignore: cast_nullable_to_non_nullable
as HomeFeed?,genres: null == genres ? _self._genres : genres // ignore: cast_nullable_to_non_nullable
as List<HomeGenre>,keyword: null == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String,searchLoading: null == searchLoading ? _self.searchLoading : searchLoading // ignore: cast_nullable_to_non_nullable
as bool,searchResults: null == searchResults ? _self._searchResults : searchResults // ignore: cast_nullable_to_non_nullable
as List<HomeMovie>,
  ));
}

/// Create a copy of BrowseState
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
}/// Create a copy of BrowseState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeFeedCopyWith<$Res>? get feed {
    if (_self.feed == null) {
    return null;
  }

  return $HomeFeedCopyWith<$Res>(_self.feed!, (value) {
    return _then(_self.copyWith(feed: value));
  });
}
}

// dart format on
