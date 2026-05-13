import 'dart:async';

import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/events/app_community_event.dart';
import 'package:imovie_app/core/events/app_event_bus.dart';
import 'package:imovie_app/domain/entities/community/community_comment.dart';
import 'package:imovie_app/domain/entities/community/community_post.dart';
import 'package:imovie_app/domain/entities/community/community_profile.dart';
import 'package:imovie_app/domain/entities/community/community_story.dart';
import 'package:imovie_app/domain/entities/chat/chat_conversation.dart';
import 'package:imovie_app/domain/usecases/chat/get_or_create_direct_conversation_use_case.dart';
import 'package:imovie_app/domain/usecases/community/add_community_comment_use_case.dart';
import 'package:imovie_app/domain/usecases/community/delete_community_post_use_case.dart';
import 'package:imovie_app/domain/usecases/community/delete_community_story_use_case.dart';
import 'package:imovie_app/domain/usecases/community/follow_community_user_use_case.dart';
import 'package:imovie_app/domain/usecases/community/get_community_comments_use_case.dart';
import 'package:imovie_app/domain/usecases/community/get_community_post_by_id_use_case.dart';
import 'package:imovie_app/domain/usecases/community/get_community_posts_use_case.dart';
import 'package:imovie_app/domain/usecases/community/get_community_profile_use_case.dart';
import 'package:imovie_app/domain/usecases/community/get_community_stories_use_case.dart';
import 'package:imovie_app/domain/usecases/community/toggle_community_reaction_use_case.dart';
import 'package:imovie_app/domain/usecases/community/unfollow_community_user_use_case.dart';
import 'package:imovie_app/presentation/ui/community/profile/community_profile_state.dart';

class CommunityProfileCubit extends BaseCubit<CommunityProfileState> {
  CommunityProfileCubit({
    required String userId,
    required String currentUserId,
    required GetCommunityProfileUseCase getCommunityProfileUseCase,
    required GetOrCreateDirectConversationUseCase
    getOrCreateDirectConversationUseCase,
    required FollowCommunityUserUseCase followCommunityUserUseCase,
    required UnfollowCommunityUserUseCase unfollowCommunityUserUseCase,
    required GetCommunityStoriesUseCase getCommunityStoriesUseCase,
    required DeleteCommunityStoryUseCase deleteCommunityStoryUseCase,
    required GetCommunityPostsUseCase getCommunityPostsUseCase,
    required GetCommunityPostByIdUseCase getCommunityPostByIdUseCase,
    required DeleteCommunityPostUseCase deleteCommunityPostUseCase,
    required ToggleCommunityReactionUseCase toggleCommunityReactionUseCase,
    required GetCommunityCommentsUseCase getCommunityCommentsUseCase,
    required AddCommunityCommentUseCase addCommunityCommentUseCase,
  }) : _getCommunityProfileUseCase = getCommunityProfileUseCase,
       _getOrCreateDirectConversationUseCase =
           getOrCreateDirectConversationUseCase,
       _followCommunityUserUseCase = followCommunityUserUseCase,
       _unfollowCommunityUserUseCase = unfollowCommunityUserUseCase,
       _getCommunityStoriesUseCase = getCommunityStoriesUseCase,
       _deleteCommunityStoryUseCase = deleteCommunityStoryUseCase,
       _getCommunityPostsUseCase = getCommunityPostsUseCase,
       _getCommunityPostByIdUseCase = getCommunityPostByIdUseCase,
       _deleteCommunityPostUseCase = deleteCommunityPostUseCase,
       _toggleCommunityReactionUseCase = toggleCommunityReactionUseCase,
       _getCommunityCommentsUseCase = getCommunityCommentsUseCase,
       _addCommunityCommentUseCase = addCommunityCommentUseCase,
       _currentUserId = currentUserId.trim(),
       super(CommunityProfileState(userId: userId)) {
    _communitySubscription = appEventBus.communityStream.listen(
      _handleCommunityEvent,
    );
  }

  static const _initialPage = 1;

  final GetCommunityProfileUseCase _getCommunityProfileUseCase;
  final GetOrCreateDirectConversationUseCase
  _getOrCreateDirectConversationUseCase;
  final FollowCommunityUserUseCase _followCommunityUserUseCase;
  final UnfollowCommunityUserUseCase _unfollowCommunityUserUseCase;
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
    final targetUserId = state.userId.trim();
    if (targetUserId.isEmpty) {
      final failure = AppFailure.unknown('Community profile user id is empty.');
      emit(
        state.copyWith(
          pageStatus: PageStatus.error,
          processing: false,
          failure: failure,
        ),
      );
      showFailureToast(failure);
      return false;
    }

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

    final profileResult = await _getCommunityProfileUseCase(
      GetCommunityProfileParams(userId: targetUserId),
    );
    final profile = profileResult.map(
      success: (profile) => profile,
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
        return null;
      },
    );
    if (profile == null) {
      return false;
    }

    var nextStories = state.stories;
    final storiesResult = await _getCommunityStoriesUseCase(
      GetCommunityStoriesParams(userId: targetUserId),
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

    final postsResult = await _getCommunityPostsUseCase(
      GetCommunityPostsParams(
        mineOnly: false,
        userId: targetUserId,
        page: _initialPage,
        limit: state.pageSize,
      ),
    );
    return postsResult.map(
      success: (posts) {
        emit(
          state.copyWith(
            pageStatus: PageStatus.loaded,
            processing: false,
            failure: null,
            profile: profile.copyWith(
              storyCount: nextStories.length,
              postCount: posts.length > profile.postCount
                  ? posts.length
                  : profile.postCount,
            ),
            stories: nextStories,
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

  Future<ChatConversation?> openDirectConversation() async {
    final profile = state.profile;
    if (profile == null || profile.isMe) {
      return null;
    }

    emit(state.copyWith(processing: true, failure: null));
    final result = await _getOrCreateDirectConversationUseCase(
      GetOrCreateDirectConversationParams(userId: profile.userId),
    );
    return result.map(
      success: (conversation) {
        emit(state.copyWith(processing: false, failure: null));
        return conversation;
      },
      failure: (failure) {
        emit(state.copyWith(processing: false, failure: failure));
        showFailureToast(failure);
        return null;
      },
    );
  }

  Future<bool> refresh() => load(showLoading: false);

  Future<void> _handleCommunityEvent(AppCommunityEvent event) async {
    if (event.isFallbackRefresh) {
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
        await _handleStoryChange(event);
        break;
      case 'community_follows':
        await _handleFollowChange(event);
        break;
      case 'profiles':
        await _handleProfileChange(event);
        break;
    }
  }

  Future<bool> loadMore() async {
    if (state.loadingMore || !state.hasMore) {
      return true;
    }

    final nextPage = state.page + 1;
    emit(state.copyWith(loadingMore: true, failure: null));
    final result = await _getCommunityPostsUseCase(
      GetCommunityPostsParams(
        mineOnly: false,
        userId: state.userId,
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

  Future<void> toggleFollow({
    required String followSuccessMessage,
    required String unfollowSuccessMessage,
  }) async {
    final profile = state.profile;
    if (profile == null || profile.isMe || state.followProcessing) {
      return;
    }

    emit(state.copyWith(followProcessing: true, failure: null));
    final result = profile.isFollowing
        ? await _unfollowCommunityUserUseCase(
            UnfollowCommunityUserParams(userId: profile.userId),
          )
        : await _followCommunityUserUseCase(
            FollowCommunityUserParams(userId: profile.userId),
          );

    result.map(
      success: (nextProfile) {
        emit(
          state.copyWith(
            profile: nextProfile,
            followProcessing: false,
            failure: null,
          ),
        );
        appEventBus.emitCommunity(AppCommunityEvent.changed());
        showSuccessToast(
          nextProfile.isFollowing
              ? followSuccessMessage
              : unfollowSuccessMessage,
        );
      },
      failure: (failure) {
        emit(state.copyWith(followProcessing: false, failure: failure));
        showFailureToast(failure);
      },
    );
  }

  Future<void> deleteStory({
    required String storyId,
    required String successMessage,
  }) async {
    emit(state.copyWith(processing: true, failure: null));
    final result = await _deleteCommunityStoryUseCase(
      DeleteCommunityStoryParams(id: storyId),
    );
    result.map(
      success: (_) {
        final nextStories = state.stories
            .where((item) => item.id != storyId)
            .toList(growable: false);
        emit(
          state.copyWith(
            processing: false,
            stories: nextStories,
            profile: state.profile?.copyWith(storyCount: nextStories.length),
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
        final nextPosts = state.posts
            .where((item) => item.id != post.id)
            .toList(growable: false);
        emit(
          state.copyWith(
            processing: false,
            posts: nextPosts,
            profile: state.profile?.copyWith(postCount: nextPosts.length),
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

  Future<void> _handlePostChange(AppCommunityEvent event) async {
    final targetUserId = event.valueOf('user_id');
    if (targetUserId != state.userId) {
      return;
    }

    final postId = event.recordId;
    if (postId.isEmpty) {
      return;
    }

    if (event.isDeleted) {
      final nextPosts = state.posts
          .where((item) => item.id != postId)
          .toList(growable: false);
      emit(
        state.copyWith(
          posts: nextPosts,
          profile: state.profile?.copyWith(postCount: nextPosts.length),
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

  Future<void> _handleStoryChange(AppCommunityEvent event) async {
    if (event.valueOf('user_id') != state.userId) {
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
        profile: state.profile?.copyWith(
          storyCount: nextStories.where((story) => !story.isExpired).length,
        ),
      ),
    );
  }

  Future<void> _handleFollowChange(AppCommunityEvent event) async {
    final profile = state.profile;
    if (profile == null) {
      return;
    }

    final followerId = event.valueOf('follower_id');
    final followingId = event.valueOf('following_id');
    if (followerId != state.userId && followingId != state.userId) {
      return;
    }

    final delta = switch (event.action) {
      AppCommunityRealtimeAction.inserted => 1,
      AppCommunityRealtimeAction.deleted => -1,
      _ => 0,
    };
    if (delta == 0) {
      return;
    }

    final isCurrentUserFollowForViewedProfile =
        followerId == _currentUserId && followingId == state.userId;
    final followerDelta =
        followingId == state.userId &&
            (!_isDuplicateCurrentUserFollowEvent(
              profile: profile,
              event: event,
              isCurrentUserFollowForViewedProfile:
                  isCurrentUserFollowForViewedProfile,
            ))
        ? delta
        : 0;
    final followingDelta = followerId == state.userId ? delta : 0;

    emit(
      state.copyWith(
        profile: profile.copyWith(
          followerCount: (profile.followerCount + followerDelta).clamp(
            0,
            999999,
          ),
          followingCount: (profile.followingCount + followingDelta).clamp(
            0,
            999999,
          ),
          isFollowing: isCurrentUserFollowForViewedProfile
              ? event.action == AppCommunityRealtimeAction.inserted
              : profile.isFollowing,
        ),
      ),
    );
  }

  bool _isDuplicateCurrentUserFollowEvent({
    required CommunityProfile profile,
    required AppCommunityEvent event,
    required bool isCurrentUserFollowForViewedProfile,
  }) {
    if (!isCurrentUserFollowForViewedProfile) {
      return false;
    }

    return switch (event.action) {
      AppCommunityRealtimeAction.inserted => profile.isFollowing,
      AppCommunityRealtimeAction.deleted => !profile.isFollowing,
      _ => false,
    };
  }

  Future<void> _handleProfileChange(AppCommunityEvent event) async {
    final userId = event.valueOfAny(const ['id', 'user_id']);
    if (userId.isEmpty) {
      return;
    }

    final displayName = event.valueOf('full_name');
    final avatarUrl = event.valueOf('avatar_url');
    final coverUrl = event.valueOf('cover_url');
    if (displayName.isEmpty && avatarUrl.isEmpty) {
      if (coverUrl.isEmpty) {
        return;
      }
    }

    emit(
      state.copyWith(
        profile: userId == state.userId
            ? state.profile?.copyWith(
                displayName: displayName.isEmpty
                    ? state.profile?.displayName
                    : displayName,
                avatarUrl: avatarUrl.isEmpty
                    ? state.profile?.avatarUrl
                    : avatarUrl,
                coverUrl: coverUrl.isEmpty ? state.profile?.coverUrl : coverUrl,
              )
            : state.profile,
        posts: state.posts
            .map((post) {
              if (post.userId != userId) {
                return post;
              }

              return post.copyWith(
                authorName: displayName.isEmpty ? post.authorName : displayName,
                authorAvatarUrl: avatarUrl.isEmpty
                    ? post.authorAvatarUrl
                    : avatarUrl,
              );
            })
            .toList(growable: false),
        stories: state.stories
            .map((story) {
              if (story.userId != userId) {
                return story;
              }

              return story.copyWith(
                authorName: displayName.isEmpty
                    ? story.authorName
                    : displayName,
                authorAvatarUrl: avatarUrl.isEmpty
                    ? story.authorAvatarUrl
                    : avatarUrl,
              );
            })
            .toList(growable: false),
      ),
    );
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

        emit(
          state.copyWith(
            posts: nextPosts,
            profile: state.profile?.copyWith(postCount: nextPosts.length),
          ),
        );
      },
      failure: (_) => null,
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

  @override
  Future<void> close() async {
    await _communitySubscription.cancel();
    return super.close();
  }
}
