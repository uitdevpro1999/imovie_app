import 'dart:async';

import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/events/app_community_event.dart';
import 'package:imovie_app/core/events/app_event_bus.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/community/community_comment.dart';
import 'package:imovie_app/domain/entities/community/community_post.dart';
import 'package:imovie_app/domain/entities/community/community_story.dart';
import 'package:imovie_app/domain/usecases/community/add_community_comment_use_case.dart';
import 'package:imovie_app/domain/usecases/community/delete_community_post_use_case.dart';
import 'package:imovie_app/domain/usecases/community/delete_community_story_use_case.dart';
import 'package:imovie_app/domain/usecases/community/get_community_comments_use_case.dart';
import 'package:imovie_app/domain/usecases/community/get_community_followed_user_ids_use_case.dart';
import 'package:imovie_app/domain/usecases/community/get_community_post_by_id_use_case.dart';
import 'package:imovie_app/domain/usecases/community/get_community_posts_use_case.dart';
import 'package:imovie_app/domain/usecases/community/get_community_stories_use_case.dart';
import 'package:imovie_app/domain/usecases/community/toggle_community_reaction_use_case.dart';
import 'package:imovie_app/presentation/ui/community/feed/community_state.dart';

class CommunityCubit extends BaseCubit<CommunityState> {
  CommunityCubit({
    required bool mineOnly,
    required String currentUserId,
    required GetCommunityFollowedUserIdsUseCase
    getCommunityFollowedUserIdsUseCase,
    required GetCommunityStoriesUseCase getCommunityStoriesUseCase,
    required DeleteCommunityStoryUseCase deleteCommunityStoryUseCase,
    required GetCommunityPostsUseCase getCommunityPostsUseCase,
    required GetCommunityPostByIdUseCase getCommunityPostByIdUseCase,
    required DeleteCommunityPostUseCase deleteCommunityPostUseCase,
    required ToggleCommunityReactionUseCase toggleCommunityReactionUseCase,
    required GetCommunityCommentsUseCase getCommunityCommentsUseCase,
    required AddCommunityCommentUseCase addCommunityCommentUseCase,
  }) : _getCommunityFollowedUserIdsUseCase = getCommunityFollowedUserIdsUseCase,
       _getCommunityStoriesUseCase = getCommunityStoriesUseCase,
       _deleteCommunityStoryUseCase = deleteCommunityStoryUseCase,
       _getCommunityPostsUseCase = getCommunityPostsUseCase,
       _getCommunityPostByIdUseCase = getCommunityPostByIdUseCase,
       _deleteCommunityPostUseCase = deleteCommunityPostUseCase,
       _toggleCommunityReactionUseCase = toggleCommunityReactionUseCase,
       _getCommunityCommentsUseCase = getCommunityCommentsUseCase,
       _addCommunityCommentUseCase = addCommunityCommentUseCase,
       _currentUserId = currentUserId.trim(),
       super(CommunityState(mineOnly: mineOnly)) {
    _communitySubscription = appEventBus.communityStream.listen(
      _handleCommunityEvent,
    );
  }

  static const _initialPage = 1;

  final GetCommunityFollowedUserIdsUseCase _getCommunityFollowedUserIdsUseCase;
  final GetCommunityStoriesUseCase _getCommunityStoriesUseCase;
  final DeleteCommunityStoryUseCase _deleteCommunityStoryUseCase;
  final GetCommunityPostsUseCase _getCommunityPostsUseCase;
  final GetCommunityPostByIdUseCase _getCommunityPostByIdUseCase;
  final DeleteCommunityPostUseCase _deleteCommunityPostUseCase;
  final ToggleCommunityReactionUseCase _toggleCommunityReactionUseCase;
  final GetCommunityCommentsUseCase _getCommunityCommentsUseCase;
  final AddCommunityCommentUseCase _addCommunityCommentUseCase;
  final String _currentUserId;
  late final StreamSubscription<AppCommunityEvent> _communitySubscription;
  final Set<String> _pendingLocalCommentPostIds = <String>{};

  @override
  Future<void> initData() async {
    await load();
  }

  Future<bool> load({bool showLoading = true}) async {
    if (showLoading) {
      emit(
        state.copyWith(
          pageStatus: state.posts.isEmpty
              ? PageStatus.loading
              : PageStatus.loaded,
          processing: state.posts.isNotEmpty,
          failure: null,
        ),
      );
    } else {
      emit(state.copyWith(failure: null));
    }

    var nextStories = state.mineOnly ? const <CommunityStory>[] : state.stories;
    var nextFollowedUserIds = state.followedUserIds;
    if (!state.mineOnly) {
      final followedIdsResult = await _getCommunityFollowedUserIdsUseCase(
        const NoParams(),
      );
      followedIdsResult.map(
        success: (userIds) {
          nextFollowedUserIds = {...userIds.map((item) => item.trim())}
            ..removeWhere((item) => item.isEmpty);
          return true;
        },
        failure: (failure) {
          showFailureToast(failure);
          return false;
        },
      );

      final storiesResult = await _getCommunityStoriesUseCase(
        const GetCommunityStoriesParams(followedOnly: true),
      );
      storiesResult.map(
        success: (stories) {
          nextStories = stories
              .where((story) => !story.isExpired)
              .toList(growable: false);
          return true;
        },
        failure: (failure) {
          showFailureToast(failure);
          return false;
        },
      );
    }

    final result = await _getCommunityPostsUseCase(
      GetCommunityPostsParams(
        mineOnly: state.mineOnly,
        userId: '',
        page: _initialPage,
        limit: state.pageSize,
      ),
    );
    return result.map(
      success: (posts) {
        emit(
          state.copyWith(
            pageStatus: PageStatus.loaded,
            processing: false,
            failure: null,
            stories: nextStories,
            followedUserIds: nextFollowedUserIds,
            posts: posts,
            page: _initialPage,
            hasMore: posts.length == state.pageSize,
          ),
        );
        return true;
      },
      failure: (failure) {
        emit(
          state.copyWith(
            pageStatus: showLoading && state.posts.isEmpty
                ? PageStatus.error
                : PageStatus.loaded,
            processing: false,
            failure: failure,
          ),
        );
        showFailureToast(failure);
        return false;
      },
    );
  }

  Future<bool> refresh() => load(showLoading: false);

  Future<void> _handleCommunityEvent(AppCommunityEvent event) async {
    if (event.isFallbackRefresh || state.mineOnly) {
      await refresh();
      return;
    }

    switch (event.table) {
      case 'community_posts':
        await _handlePostChange(event);
        break;
      case 'community_comments':
        await _handleCommentChange(event);
        break;
      case 'community_reactions':
        await _handleReactionChange(event);
        break;
      case 'community_stories':
        _handleStoryChange(event);
        break;
      case 'community_follows':
        _handleFollowChange(event);
        break;
      case 'profiles':
        _patchVisibleAuthors(event);
        break;
    }
  }

  Future<void> deleteStory({
    required CommunityStory story,
    required String successMessage,
  }) async {
    if (!story.isOwner) {
      return;
    }

    emit(state.copyWith(processing: true, failure: null));
    final result = await _deleteCommunityStoryUseCase(
      DeleteCommunityStoryParams(id: story.id),
    );
    result.map(
      success: (_) {
        emit(
          state.copyWith(
            processing: false,
            stories: state.stories
                .where((item) => item.id != story.id)
                .toList(growable: false),
          ),
        );
        appEventBus.emitCommunity(AppCommunityEvent.changed());
        showSuccessToast(successMessage);
      },
      failure: (failure) {
        emit(state.copyWith(processing: false, failure: failure));
        showFailureToast(failure);
      },
    );
  }

  Future<bool> loadMore() async {
    if (state.loadingMore || !state.hasMore) {
      return true;
    }

    final nextPage = state.page + 1;
    emit(state.copyWith(loadingMore: true, failure: null));
    final result = await _getCommunityPostsUseCase(
      GetCommunityPostsParams(
        mineOnly: state.mineOnly,
        userId: '',
        page: nextPage,
        limit: state.pageSize,
      ),
    );

    return result.map(
      success: (posts) {
        final existingIds = state.posts.map((item) => item.id).toSet();
        final nextPosts = posts
            .where((post) => !existingIds.contains(post.id))
            .toList(growable: false);
        emit(
          state.copyWith(
            posts: [...state.posts, ...nextPosts],
            page: nextPage,
            hasMore: posts.length == state.pageSize,
            loadingMore: false,
            failure: null,
          ),
        );
        return true;
      },
      failure: (failure) {
        emit(state.copyWith(loadingMore: false, failure: failure));
        showFailureToast(failure);
        return false;
      },
    );
  }

  Future<void> deletePost({
    required CommunityPost post,
    required String successMessage,
  }) async {
    if (!post.isOwner) {
      return;
    }

    emit(state.copyWith(processing: true, failure: null));
    final result = await _deleteCommunityPostUseCase(
      DeleteCommunityPostParams(id: post.id),
    );
    result.map(
      success: (_) {
        emit(
          state.copyWith(
            processing: false,
            posts: state.posts
                .where((item) => item.id != post.id)
                .toList(growable: false),
          ),
        );
        appEventBus.emitCommunity(AppCommunityEvent.changed());
        showSuccessToast(successMessage);
      },
      failure: (failure) {
        emit(state.copyWith(processing: false, failure: failure));
        showFailureToast(failure);
      },
    );
  }

  Future<void> toggleReaction(CommunityPost post) async {
    final optimisticPost = post.copyWith(
      isReactedByMe: !post.isReactedByMe,
      reactionCount: (post.reactionCount + (post.isReactedByMe ? -1 : 1)).clamp(
        0,
        999999,
      ),
    );
    _replacePost(optimisticPost);

    final result = await _toggleCommunityReactionUseCase(
      ToggleCommunityReactionParams(postId: post.id),
    );
    result.map(
      success: (nextPost) {
        _replacePost(nextPost);
      },
      failure: (failure) {
        _replacePost(post);
        showFailureToast(failure);
      },
    );
  }

  Future<void> loadComments(String postId) async {
    emit(
      state.copyWith(
        loadingCommentPostIds: {...state.loadingCommentPostIds, postId},
      ),
    );
    final result = await _getCommunityCommentsUseCase(
      GetCommunityCommentsParams(postId: postId),
    );
    result.map(
      success: (comments) {
        emit(
          state.copyWith(
            commentsByPost: {...state.commentsByPost, postId: comments},
            loadingCommentPostIds: {...state.loadingCommentPostIds}
              ..remove(postId),
          ),
        );
      },
      failure: (failure) {
        emit(
          state.copyWith(
            loadingCommentPostIds: {...state.loadingCommentPostIds}
              ..remove(postId),
            failure: failure,
          ),
        );
        showFailureToast(failure);
      },
    );
  }

  Future<void> _handlePostChange(AppCommunityEvent event) async {
    final postId = event.recordId;
    if (postId.isEmpty) {
      return;
    }

    if (event.isDeleted) {
      emit(
        state.copyWith(
          posts: state.posts
              .where((item) => item.id != postId)
              .toList(growable: false),
          commentsByPost: Map<String, List<CommunityComment>>.from(
            state.commentsByPost,
          )..remove(postId),
        ),
      );
      return;
    }

    final existingIndex = state.posts.indexWhere((item) => item.id == postId);
    if (existingIndex >= 0) {
      _replacePost(
        _mergeRealtimePost(event.activeRecord, state.posts[existingIndex]),
      );
      return;
    }

    await _syncPost(postId, insertToFront: true);
  }

  Future<void> _handleCommentChange(AppCommunityEvent event) async {
    final postId = event.valueOf('post_id');
    if (postId.isEmpty) {
      return;
    }

    final isVisiblePost = state.posts.any((post) => post.id == postId);
    final hasLoadedComments = state.commentsByPost.containsKey(postId);
    if (!isVisiblePost && !hasLoadedComments) {
      return;
    }

    final actorUserId = event.valueOf('user_id');
    final isOwnPendingInsert =
        event.action == AppCommunityRealtimeAction.inserted &&
        actorUserId == _currentUserId &&
        _pendingLocalCommentPostIds.remove(postId);

    if (hasLoadedComments) {
      _patchCommentsFromEvent(postId, event);
    }

    if (!isOwnPendingInsert) {
      _adjustPostCommentCount(postId, event);
    }
  }

  Future<void> _handleReactionChange(AppCommunityEvent event) async {
    final postId = event.valueOf('post_id');
    if (postId.isEmpty || !state.posts.any((post) => post.id == postId)) {
      return;
    }

    final actorUserId = event.valueOf('user_id');
    _patchReactionFromEvent(postId, event, actorUserId);
  }

  void _handleStoryChange(AppCommunityEvent event) {
    final userId = event.valueOf('user_id');
    if (userId.isEmpty) {
      return;
    }

    final hasVisibleOwner = state.stories.any(
      (story) => story.userId == userId,
    );
    final isCurrentUser = userId == _currentUserId;
    final isFollowedUser = state.followedUserIds.contains(userId);
    if (!hasVisibleOwner && !isCurrentUser && !isFollowedUser) {
      return;
    }

    final nextStories = switch (event.action) {
      AppCommunityRealtimeAction.inserted => _insertOrReplaceStory(
        state.stories,
        _storyFromRecord(event.activeRecord),
      ),
      AppCommunityRealtimeAction.updated => _replaceStory(
        state.stories,
        _storyFromRecord(event.activeRecord),
      ),
      AppCommunityRealtimeAction.deleted =>
        state.stories
            .where((item) => item.id != event.recordId)
            .toList(growable: false),
      AppCommunityRealtimeAction.unknown => state.stories,
    };

    emit(
      state.copyWith(
        stories: nextStories
            .where((story) => !story.isExpired)
            .toList(growable: false),
      ),
    );
  }

  void _handleFollowChange(AppCommunityEvent event) {
    final followerId = event.valueOf('follower_id');
    final followingId = event.valueOf('following_id');
    if (followerId != _currentUserId || followingId.isEmpty) {
      return;
    }

    final nextFollowedUserIds = {...state.followedUserIds};
    switch (event.action) {
      case AppCommunityRealtimeAction.inserted:
        nextFollowedUserIds.add(followingId);
        break;
      case AppCommunityRealtimeAction.deleted:
        nextFollowedUserIds.remove(followingId);
        break;
      case AppCommunityRealtimeAction.updated:
      case AppCommunityRealtimeAction.unknown:
        return;
    }

    emit(state.copyWith(followedUserIds: nextFollowedUserIds));
  }

  Future<void> _syncPost(String postId, {bool insertToFront = false}) async {
    final result = await _getCommunityPostByIdUseCase(
      GetCommunityPostByIdParams(id: postId),
    );
    result.map(
      success: (post) {
        final existingIndex = state.posts.indexWhere(
          (item) => item.id == postId,
        );
        final nextPosts = [...state.posts];
        if (existingIndex >= 0) {
          nextPosts[existingIndex] = post;
        } else if (insertToFront) {
          nextPosts.insert(0, post);
        } else {
          return;
        }

        emit(state.copyWith(posts: nextPosts));
      },
      failure: (_) => null,
    );
  }

  CommunityPost _mergeRealtimePost(
    Map<String, dynamic> record,
    CommunityPost fallback,
  ) {
    return fallback.copyWith(
      authorName: _stringValue(record, 'author_name', fallback.authorName),
      authorAvatarUrl: _stringValue(
        record,
        'author_avatar_url',
        fallback.authorAvatarUrl,
      ),
      content: _stringValue(record, 'content', fallback.content),
      imageUrls: _imageUrls(record, fallback.imageUrls),
      movieTitle: _stringValue(record, 'movie_title', fallback.movieTitle),
      movieSlug: _stringValue(record, 'movie_slug', fallback.movieSlug),
      moviePosterUrl: _stringValue(
        record,
        'movie_poster_url',
        fallback.moviePosterUrl,
      ),
      locationName: _stringValue(
        record,
        'location_name',
        fallback.locationName,
      ),
      reactionCount: _intValue(
        record,
        'reaction_count',
        fallback.reactionCount,
      ),
      commentCount: _intValue(record, 'comment_count', fallback.commentCount),
    );
  }

  String _stringValue(
    Map<String, dynamic> record,
    String key,
    String fallback,
  ) {
    final value = record[key]?.toString();
    return value ?? fallback;
  }

  int _intValue(Map<String, dynamic> record, String key, int fallback) {
    final value = record[key];
    if (value is num) {
      return value.toInt();
    }

    return int.tryParse(value?.toString() ?? '') ?? fallback;
  }

  List<String> _imageUrls(Map<String, dynamic> record, List<String> fallback) {
    final imageUrls = record['image_urls'];
    if (imageUrls is Iterable) {
      final values = imageUrls
          .map((item) => item?.toString().trim() ?? '')
          .where((item) => item.isNotEmpty)
          .toList(growable: false);
      if (values.isNotEmpty) {
        return values;
      }
    }

    final legacyUrl = record['image_url']?.toString().trim() ?? '';
    if (legacyUrl.isNotEmpty) {
      return <String>[legacyUrl];
    }

    return fallback;
  }

  void _patchVisibleAuthors(AppCommunityEvent event) {
    final userId = event.valueOfAny(const ['id', 'user_id']);
    if (userId.isEmpty) {
      return;
    }

    final displayName = event.valueOf('full_name');
    final avatarUrl = event.valueOf('avatar_url');
    var changed = false;

    final nextStories = state.stories
        .map((story) {
          if (story.userId != userId) {
            return story;
          }

          changed = true;
          return story.copyWith(
            authorName: displayName.isEmpty ? story.authorName : displayName,
            authorAvatarUrl: avatarUrl.isEmpty
                ? story.authorAvatarUrl
                : avatarUrl,
          );
        })
        .toList(growable: false);

    final nextPosts = state.posts
        .map((post) {
          if (post.userId != userId) {
            return post;
          }

          changed = true;
          return post.copyWith(
            authorName: displayName.isEmpty ? post.authorName : displayName,
            authorAvatarUrl: avatarUrl.isEmpty
                ? post.authorAvatarUrl
                : avatarUrl,
          );
        })
        .toList(growable: false);

    if (!changed) {
      return;
    }

    emit(state.copyWith(stories: nextStories, posts: nextPosts));
  }

  CommunityStory _storyFromRecord(Map<String, dynamic> record) {
    final userId = record['user_id']?.toString() ?? '';
    return CommunityStory(
      id: record['id']?.toString() ?? '',
      userId: userId,
      authorName: record['author_name']?.toString() ?? '',
      authorAvatarUrl: record['author_avatar_url']?.toString() ?? '',
      imageUrl: record['image_url']?.toString() ?? '',
      imagePath: record['image_path']?.toString() ?? '',
      caption: record['caption']?.toString() ?? '',
      movieTitle: record['movie_title']?.toString() ?? '',
      movieSlug: record['movie_slug']?.toString() ?? '',
      moviePosterUrl: record['movie_poster_url']?.toString() ?? '',
      locationName: record['location_name']?.toString() ?? '',
      textPositionX: _doubleValue(record, 'text_position_x', 0.5),
      textPositionY: _doubleValue(record, 'text_position_y', 0.45),
      moviePositionX: _doubleValue(record, 'movie_position_x', 0.28),
      moviePositionY: _doubleValue(record, 'movie_position_y', 0.78),
      locationPositionX: _doubleValue(record, 'location_position_x', 0.32),
      locationPositionY: _doubleValue(record, 'location_position_y', 0.88),
      isOwner: userId == _currentUserId,
      createdAt: DateTime.tryParse(record['created_at']?.toString() ?? ''),
      expiresAt: DateTime.tryParse(record['expires_at']?.toString() ?? ''),
    );
  }

  double _doubleValue(
    Map<String, dynamic> record,
    String key,
    double fallback,
  ) {
    final value = record[key];
    if (value is num) {
      return value.toDouble().clamp(0.0, 1.0);
    }

    return (double.tryParse(value?.toString() ?? '') ?? fallback).clamp(
      0.0,
      1.0,
    );
  }

  List<CommunityStory> _insertOrReplaceStory(
    List<CommunityStory> stories,
    CommunityStory story,
  ) {
    if (story.id.isEmpty || story.isExpired) {
      return stories;
    }

    final index = stories.indexWhere((item) => item.id == story.id);
    if (index >= 0) {
      final next = [...stories];
      next[index] = story;
      return next;
    }

    return [story, ...stories]..sort((a, b) {
      final aTime = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      final bTime = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      return bTime.compareTo(aTime);
    });
  }

  List<CommunityStory> _replaceStory(
    List<CommunityStory> stories,
    CommunityStory story,
  ) {
    if (story.id.isEmpty) {
      return stories;
    }

    final index = stories.indexWhere((item) => item.id == story.id);
    if (index < 0) {
      return stories;
    }

    final next = [...stories];
    if (story.isExpired) {
      next.removeAt(index);
      return next;
    }

    next[index] = story;
    return next;
  }

  Future<void> addComment({
    required CommunityPost post,
    required String content,
    required String emptyMessage,
  }) async {
    final normalizedContent = content.trim();
    if (normalizedContent.isEmpty) {
      showFailureToast(AppFailure.unknown(emptyMessage));
      return;
    }

    final result = await _addCommunityCommentUseCase(
      AddCommunityCommentParams(postId: post.id, content: normalizedContent),
    );
    result.map(
      success: (comment) {
        _pendingLocalCommentPostIds.add(post.id);
        final List<CommunityComment> comments = [
          comment,
          ...(state.commentsByPost[post.id] ?? const <CommunityComment>[]),
        ];
        emit(
          state.copyWith(
            commentsByPost: {...state.commentsByPost, post.id: comments},
          ),
        );
        _replacePost(post.copyWith(commentCount: post.commentCount + 1));
      },
      failure: showFailureToast,
    );
  }

  void _replacePost(CommunityPost post) {
    emit(
      state.copyWith(
        posts: state.posts
            .map((item) => item.id == post.id ? post : item)
            .toList(growable: false),
      ),
    );
  }

  void _patchCommentsFromEvent(String postId, AppCommunityEvent event) {
    final existing = state.commentsByPost[postId] ?? const <CommunityComment>[];
    final next = switch (event.action) {
      AppCommunityRealtimeAction.inserted => _insertOrReplaceComment(
        existing,
        _commentFromRecord(event.activeRecord),
      ),
      AppCommunityRealtimeAction.updated => _replaceComment(
        existing,
        _commentFromRecord(event.activeRecord),
      ),
      AppCommunityRealtimeAction.deleted =>
        existing
            .where((item) => item.id != event.recordId)
            .toList(growable: false),
      AppCommunityRealtimeAction.unknown => existing,
    };

    emit(
      state.copyWith(commentsByPost: {...state.commentsByPost, postId: next}),
    );
  }

  void _adjustPostCommentCount(String postId, AppCommunityEvent event) {
    final index = state.posts.indexWhere((item) => item.id == postId);
    if (index < 0) {
      return;
    }
    final post = state.posts[index];

    final delta = switch (event.action) {
      AppCommunityRealtimeAction.inserted => 1,
      AppCommunityRealtimeAction.deleted => -1,
      _ => 0,
    };
    if (delta == 0) {
      return;
    }

    _replacePost(
      post.copyWith(commentCount: (post.commentCount + delta).clamp(0, 999999)),
    );
  }

  void _patchReactionFromEvent(
    String postId,
    AppCommunityEvent event,
    String actorUserId,
  ) {
    final index = state.posts.indexWhere((item) => item.id == postId);
    if (index < 0) {
      return;
    }

    final post = state.posts[index];
    final affectsMe = actorUserId.isNotEmpty && actorUserId == _currentUserId;
    if (!affectsMe) {
      return;
    }

    final nextIsReactedByMe = switch (event.action) {
      AppCommunityRealtimeAction.inserted => true,
      AppCommunityRealtimeAction.deleted => false,
      _ => post.isReactedByMe,
    };
    _replacePost(post.copyWith(isReactedByMe: nextIsReactedByMe));
  }

  CommunityComment _commentFromRecord(Map<String, dynamic> record) {
    final userId = record['user_id']?.toString() ?? '';
    return CommunityComment(
      id: record['id']?.toString() ?? '',
      postId: record['post_id']?.toString() ?? '',
      userId: userId,
      authorName: record['author_name']?.toString() ?? '',
      authorAvatarUrl: record['author_avatar_url']?.toString() ?? '',
      content: record['content']?.toString() ?? '',
      isOwner: userId == _currentUserId,
      createdAt: DateTime.tryParse(record['created_at']?.toString() ?? ''),
    );
  }

  List<CommunityComment> _insertOrReplaceComment(
    List<CommunityComment> comments,
    CommunityComment comment,
  ) {
    if (comment.id.isEmpty) {
      return comments;
    }

    final index = comments.indexWhere((item) => item.id == comment.id);
    if (index >= 0) {
      final next = [...comments];
      next[index] = comment;
      return next;
    }

    return [comment, ...comments];
  }

  List<CommunityComment> _replaceComment(
    List<CommunityComment> comments,
    CommunityComment comment,
  ) {
    if (comment.id.isEmpty) {
      return comments;
    }

    final index = comments.indexWhere((item) => item.id == comment.id);
    if (index < 0) {
      return comments;
    }

    final next = [...comments];
    next[index] = comment;
    return next;
  }

  @override
  Future<void> close() async {
    await _communitySubscription.cancel();
    return super.close();
  }
}
