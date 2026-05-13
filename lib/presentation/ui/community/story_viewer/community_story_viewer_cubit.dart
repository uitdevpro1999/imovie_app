import 'dart:async';

import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/events/app_community_event.dart';
import 'package:imovie_app/core/events/app_event_bus.dart';
import 'package:imovie_app/domain/entities/community/community_story.dart';
import 'package:imovie_app/domain/usecases/community/delete_community_story_use_case.dart';
import 'package:imovie_app/domain/usecases/community/get_community_stories_use_case.dart';
import 'package:imovie_app/domain/usecases/community/get_community_story_by_id_use_case.dart';
import 'package:imovie_app/presentation/ui/community/story_viewer/community_story_viewer_state.dart';

class CommunityStoryViewerCubit extends BaseCubit<CommunityStoryViewerState> {
  CommunityStoryViewerCubit({
    required String storyId,
    required String currentUserId,
    required GetCommunityStoryByIdUseCase getCommunityStoryByIdUseCase,
    required GetCommunityStoriesUseCase getCommunityStoriesUseCase,
    required DeleteCommunityStoryUseCase deleteCommunityStoryUseCase,
  }) : _getCommunityStoryByIdUseCase = getCommunityStoryByIdUseCase,
       _getCommunityStoriesUseCase = getCommunityStoriesUseCase,
       _deleteCommunityStoryUseCase = deleteCommunityStoryUseCase,
       _currentUserId = currentUserId.trim(),
       super(CommunityStoryViewerState(storyId: storyId)) {
    _communitySubscription = appEventBus.communityStream.listen(
      _handleCommunityEvent,
    );
  }

  final GetCommunityStoryByIdUseCase _getCommunityStoryByIdUseCase;
  final GetCommunityStoriesUseCase _getCommunityStoriesUseCase;
  final DeleteCommunityStoryUseCase _deleteCommunityStoryUseCase;
  final String _currentUserId;
  late final StreamSubscription<AppCommunityEvent> _communitySubscription;
  final Set<String> _locallyDeletedStoryIds = <String>{};

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

    final storyResult = await _getCommunityStoryByIdUseCase(
      GetCommunityStoryByIdParams(id: state.storyId),
    );

    final nextAction = storyResult.map<Future<void>>(
      success: _loadStoryGroup,
      failure: (failure) async => _emitFailure(failure),
    );
    await nextAction;
  }

  Future<void> _loadStoryGroup(CommunityStory story) async {
    final storiesResult = await _getCommunityStoriesUseCase(
      GetCommunityStoriesParams(userId: story.userId, followedOnly: false),
    );

    storiesResult.map(
      success: (stories) {
        final visibleStories = stories
            .where((item) => !item.isExpired)
            .toList(growable: false);
        if (visibleStories.isEmpty) {
          _emitFailure(AppFailure.unknown('Unable to load this story.'));
          return;
        }

        final initialIndex = visibleStories.indexWhere(
          (item) => item.id == story.id,
        );
        emit(
          state.copyWith(
            pageStatus: PageStatus.loaded,
            processing: false,
            failure: null,
            stories: visibleStories,
            initialIndex: initialIndex < 0 ? 0 : initialIndex,
          ),
        );
      },
      failure: _emitFailure,
    );
  }

  Future<bool> deleteStory({
    required CommunityStory story,
    required String successMessage,
  }) async {
    if (!story.isOwner) {
      return false;
    }

    emit(state.copyWith(processing: true, failure: null));
    final result = await _deleteCommunityStoryUseCase(
      DeleteCommunityStoryParams(id: story.id),
    );

    return result.map(
      success: (_) {
        final nextStories = state.stories
            .where((item) => item.id != story.id)
            .toList(growable: false);
        emit(
          state.copyWith(
            processing: false,
            stories: nextStories,
            initialIndex: state.initialIndex
                .clamp(0, nextStories.isEmpty ? 0 : nextStories.length - 1)
                .toInt(),
          ),
        );
        _locallyDeletedStoryIds.add(story.id);
        appEventBus.emitCommunity(
          AppCommunityEvent.realtime(
            table: 'community_stories',
            action: AppCommunityRealtimeAction.deleted,
            record: const <String, dynamic>{},
            oldRecord: {'id': story.id, 'user_id': story.userId},
          ),
        );
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

  Future<void> _handleCommunityEvent(AppCommunityEvent event) async {
    if (event.isFallbackRefresh) {
      await load();
      return;
    }

    final currentOwnerId = state.stories.isEmpty
        ? ''
        : state.stories.first.userId;
    final affectedUserId = event.valueOfAny(const ['user_id', 'id']);
    final affectedStoryId = event.recordId;

    if (event.table == 'community_stories' &&
        (affectedStoryId == state.storyId ||
            affectedUserId == currentOwnerId)) {
      if (_locallyDeletedStoryIds.remove(affectedStoryId)) {
        return;
      }
      _patchStories(event);
      return;
    }

    if (event.table == 'profiles' &&
        affectedUserId.isNotEmpty &&
        affectedUserId == currentOwnerId) {
      _patchAuthor(event);
    }
  }

  void _patchStories(AppCommunityEvent event) {
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

    if (nextStories.isEmpty) {
      _emitFailure(AppFailure.unknown('Unable to load this story.'));
      return;
    }

    final nextInitialIndex = nextStories.indexWhere(
      (item) => item.id == state.storyId,
    );
    emit(
      state.copyWith(
        stories: nextStories,
        initialIndex: nextInitialIndex < 0 ? 0 : nextInitialIndex,
      ),
    );
  }

  void _patchAuthor(AppCommunityEvent event) {
    final displayName = event.valueOf('full_name');
    final avatarUrl = event.valueOf('avatar_url');
    if (displayName.isEmpty && avatarUrl.isEmpty) {
      return;
    }

    emit(
      state.copyWith(
        stories: state.stories
            .map((story) {
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
