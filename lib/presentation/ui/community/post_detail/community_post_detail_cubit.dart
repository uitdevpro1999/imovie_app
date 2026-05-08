import 'dart:async';

import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/events/app_community_event.dart';
import 'package:imovie_app/core/events/app_event_bus.dart';
import 'package:imovie_app/domain/entities/community/community_comment.dart';
import 'package:imovie_app/domain/entities/community/community_post.dart';
import 'package:imovie_app/domain/usecases/community/add_community_comment_use_case.dart';
import 'package:imovie_app/domain/usecases/community/delete_community_post_use_case.dart';
import 'package:imovie_app/domain/usecases/community/get_community_comments_use_case.dart';
import 'package:imovie_app/domain/usecases/community/get_community_post_by_id_use_case.dart';
import 'package:imovie_app/domain/usecases/community/toggle_community_reaction_use_case.dart';
import 'package:imovie_app/presentation/ui/community/post_detail/community_post_detail_state.dart';

class CommunityPostDetailCubit extends BaseCubit<CommunityPostDetailState> {
  CommunityPostDetailCubit({
    required String postId,
    required String currentUserId,
    required GetCommunityPostByIdUseCase getCommunityPostByIdUseCase,
    required ToggleCommunityReactionUseCase toggleCommunityReactionUseCase,
    required GetCommunityCommentsUseCase getCommunityCommentsUseCase,
    required AddCommunityCommentUseCase addCommunityCommentUseCase,
    required DeleteCommunityPostUseCase deleteCommunityPostUseCase,
  }) : _getCommunityPostByIdUseCase = getCommunityPostByIdUseCase,
       _toggleCommunityReactionUseCase = toggleCommunityReactionUseCase,
       _getCommunityCommentsUseCase = getCommunityCommentsUseCase,
       _addCommunityCommentUseCase = addCommunityCommentUseCase,
       _deleteCommunityPostUseCase = deleteCommunityPostUseCase,
       _currentUserId = currentUserId.trim(),
       super(CommunityPostDetailState(postId: postId)) {
    _communitySubscription = appEventBus.communityStream.listen(
      _handleCommunityEvent,
    );
  }

  final GetCommunityPostByIdUseCase _getCommunityPostByIdUseCase;
  final ToggleCommunityReactionUseCase _toggleCommunityReactionUseCase;
  final GetCommunityCommentsUseCase _getCommunityCommentsUseCase;
  final AddCommunityCommentUseCase _addCommunityCommentUseCase;
  final DeleteCommunityPostUseCase _deleteCommunityPostUseCase;
  final String _currentUserId;
  late final StreamSubscription<AppCommunityEvent> _communitySubscription;
  bool _pendingLocalComment = false;

  @override
  Future<void> initData() => load();

  Future<void> load() async {
    emit(
      state.copyWith(
        pageStatus: PageStatus.loading,
        processing: false,
        failure: null,
      ),
    );

    final result = await _getCommunityPostByIdUseCase(
      GetCommunityPostByIdParams(id: state.postId),
    );
    result.map(
      success: (post) {
        emit(
          state.copyWith(
            pageStatus: PageStatus.loaded,
            processing: false,
            failure: null,
            post: post,
          ),
        );
      },
      failure: _emitFailure,
    );
  }

  Future<void> _handleCommunityEvent(AppCommunityEvent event) async {
    if (event.isFallbackRefresh) {
      await load();
      if (state.comments.isNotEmpty) {
        await loadComments();
      }
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
      case 'profiles':
        await _handleProfileChange(event);
        break;
    }
  }

  Future<void> loadComments() async {
    if (state.loadingComments) {
      return;
    }

    emit(state.copyWith(loadingComments: true, failure: null));
    final result = await _getCommunityCommentsUseCase(
      GetCommunityCommentsParams(postId: state.postId),
    );
    result.map(
      success: (comments) {
        emit(
          state.copyWith(
            comments: comments,
            loadingComments: false,
            failure: null,
          ),
        );
      },
      failure: (failure) {
        emit(state.copyWith(loadingComments: false, failure: failure));
        showFailureToast(failure);
      },
    );
  }

  Future<void> addComment({
    required String content,
    required String emptyMessage,
  }) async {
    final normalizedContent = content.trim();
    if (normalizedContent.isEmpty) {
      showFailureToast(AppFailure.unknown(emptyMessage));
      return;
    }

    final result = await _addCommunityCommentUseCase(
      AddCommunityCommentParams(
        postId: state.postId,
        content: normalizedContent,
      ),
    );
    result.map(
      success: (comment) {
        _pendingLocalComment = true;
        emit(
          state.copyWith(
            comments: [comment, ...state.comments],
            post: state.post?.copyWith(commentCount: state.comments.length + 1),
          ),
        );
      },
      failure: showFailureToast,
    );
  }

  Future<void> toggleReaction() async {
    final currentPost = state.post;
    if (currentPost == null) {
      return;
    }

    final optimisticPost = currentPost.copyWith(
      isReactedByMe: !currentPost.isReactedByMe,
      reactionCount:
          (currentPost.reactionCount + (currentPost.isReactedByMe ? -1 : 1))
              .clamp(0, 999999),
    );
    emit(state.copyWith(post: optimisticPost));

    final result = await _toggleCommunityReactionUseCase(
      ToggleCommunityReactionParams(postId: currentPost.id),
    );
    result.map(
      success: (post) => emit(state.copyWith(post: post)),
      failure: (failure) {
        emit(state.copyWith(post: currentPost));
        showFailureToast(failure);
      },
    );
  }

  Future<bool> deletePost({required String successMessage}) async {
    final currentPost = state.post;
    if (currentPost == null || !currentPost.isOwner) {
      return false;
    }

    emit(state.copyWith(processing: true, failure: null));
    final result = await _deleteCommunityPostUseCase(
      DeleteCommunityPostParams(id: currentPost.id),
    );
    return result.map(
      success: (_) {
        emit(state.copyWith(processing: false));
        showSuccessToast(successMessage);
        return true;
      },
      failure: (failure) {
        emit(state.copyWith(processing: false, failure: failure));
        showFailureToast(failure);
        return false;
      },
    );
  }

  Future<void> _handlePostChange(AppCommunityEvent event) async {
    if (event.recordId != state.postId) {
      return;
    }

    if (event.isDeleted) {
      _emitFailure(AppFailure.unknown('This post is no longer available.'));
      return;
    }

    final currentPost = state.post;
    if (currentPost != null) {
      emit(
        state.copyWith(
          post: _mergeRealtimePost(event.activeRecord, currentPost),
        ),
      );
      return;
    }

    await _refreshPost();
  }

  Future<void> _handleCommentChange(AppCommunityEvent event) async {
    if (event.valueOf('post_id') != state.postId) {
      return;
    }

    final actorUserId = event.valueOf('user_id');
    final isOwnPendingInsert =
        event.action == AppCommunityRealtimeAction.inserted &&
        actorUserId == _currentUserId &&
        _pendingLocalComment;
    if (isOwnPendingInsert) {
      _pendingLocalComment = false;
    } else {
      _patchCommentsFromEvent(event);
    }

    if (!isOwnPendingInsert) {
      _adjustCommentCount(event);
    }
  }

  Future<void> _handleReactionChange(AppCommunityEvent event) async {
    if (event.valueOf('post_id') != state.postId) {
      return;
    }

    final actorUserId = event.valueOf('user_id');
    _patchReaction(event, actorUserId);
  }

  Future<void> _handleProfileChange(AppCommunityEvent event) async {
    final post = state.post;
    if (post == null) {
      return;
    }

    final userId = event.valueOfAny(const ['id', 'user_id']);
    if (userId != post.userId) {
      return;
    }

    await _refreshPost();
  }

  Future<void> _refreshPost() async {
    final result = await _getCommunityPostByIdUseCase(
      GetCommunityPostByIdParams(id: state.postId),
    );
    result.map(
      success: (post) => emit(
        state.copyWith(
          pageStatus: PageStatus.loaded,
          processing: false,
          failure: null,
          post: post,
        ),
      ),
      failure: (_) => null,
    );
  }

  void _patchCommentsFromEvent(AppCommunityEvent event) {
    final next = switch (event.action) {
      AppCommunityRealtimeAction.inserted => _insertOrReplaceComment(
        state.comments,
        _commentFromRecord(event.activeRecord),
      ),
      AppCommunityRealtimeAction.updated => _replaceComment(
        state.comments,
        _commentFromRecord(event.activeRecord),
      ),
      AppCommunityRealtimeAction.deleted =>
        state.comments
            .where((item) => item.id != event.recordId)
            .toList(growable: false),
      AppCommunityRealtimeAction.unknown => state.comments,
    };
    emit(state.copyWith(comments: next));
  }

  void _adjustCommentCount(AppCommunityEvent event) {
    final currentPost = state.post;
    if (currentPost == null) {
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

    emit(
      state.copyWith(
        post: currentPost.copyWith(
          commentCount: (currentPost.commentCount + delta).clamp(0, 999999),
        ),
      ),
    );
  }

  void _patchReaction(AppCommunityEvent event, String actorUserId) {
    final currentPost = state.post;
    if (currentPost == null) {
      return;
    }

    final affectsMe = actorUserId.isNotEmpty && actorUserId == _currentUserId;
    if (!affectsMe) {
      return;
    }

    final nextIsReactedByMe = switch (event.action) {
      AppCommunityRealtimeAction.inserted => true,
      AppCommunityRealtimeAction.deleted => false,
      _ => currentPost.isReactedByMe,
    };
    emit(
      state.copyWith(
        post: currentPost.copyWith(isReactedByMe: nextIsReactedByMe),
      ),
    );
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

  void _emitFailure(AppFailure failure) {
    emit(
      state.copyWith(
        pageStatus: PageStatus.error,
        processing: false,
        failure: failure,
      ),
    );
    showFailureToast(failure);
  }

  @override
  Future<void> close() async {
    await _communitySubscription.cancel();
    return super.close();
  }
}
