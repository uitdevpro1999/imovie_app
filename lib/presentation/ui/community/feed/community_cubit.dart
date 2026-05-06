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
import 'package:imovie_app/domain/usecases/community/get_community_posts_use_case.dart';
import 'package:imovie_app/domain/usecases/community/get_community_stories_use_case.dart';
import 'package:imovie_app/domain/usecases/community/toggle_community_reaction_use_case.dart';
import 'package:imovie_app/presentation/ui/community/feed/community_state.dart';

class CommunityCubit extends BaseCubit<CommunityState> {
  CommunityCubit({
    required bool mineOnly,
    required GetCommunityStoriesUseCase getCommunityStoriesUseCase,
    required DeleteCommunityStoryUseCase deleteCommunityStoryUseCase,
    required GetCommunityPostsUseCase getCommunityPostsUseCase,
    required DeleteCommunityPostUseCase deleteCommunityPostUseCase,
    required ToggleCommunityReactionUseCase toggleCommunityReactionUseCase,
    required GetCommunityCommentsUseCase getCommunityCommentsUseCase,
    required AddCommunityCommentUseCase addCommunityCommentUseCase,
  }) : _getCommunityStoriesUseCase = getCommunityStoriesUseCase,
       _deleteCommunityStoryUseCase = deleteCommunityStoryUseCase,
       _getCommunityPostsUseCase = getCommunityPostsUseCase,
       _deleteCommunityPostUseCase = deleteCommunityPostUseCase,
       _toggleCommunityReactionUseCase = toggleCommunityReactionUseCase,
       _getCommunityCommentsUseCase = getCommunityCommentsUseCase,
       _addCommunityCommentUseCase = addCommunityCommentUseCase,
       super(CommunityState(mineOnly: mineOnly)) {
    _communitySubscription = appEventBus.communityStream.listen(
      (_) => refresh(),
    );
  }

  static const _initialPage = 1;

  final GetCommunityStoriesUseCase _getCommunityStoriesUseCase;
  final DeleteCommunityStoryUseCase _deleteCommunityStoryUseCase;
  final GetCommunityPostsUseCase _getCommunityPostsUseCase;
  final DeleteCommunityPostUseCase _deleteCommunityPostUseCase;
  final ToggleCommunityReactionUseCase _toggleCommunityReactionUseCase;
  final GetCommunityCommentsUseCase _getCommunityCommentsUseCase;
  final AddCommunityCommentUseCase _addCommunityCommentUseCase;
  late final StreamSubscription<AppCommunityEvent> _communitySubscription;

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
    if (!state.mineOnly) {
      final storiesResult = await _getCommunityStoriesUseCase(const NoParams());
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
      success: _replacePost,
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
        final List<CommunityComment> comments = [
          ...(state.commentsByPost[post.id] ?? const <CommunityComment>[]),
          comment,
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

  @override
  Future<void> close() async {
    await _communitySubscription.cancel();
    return super.close();
  }
}
