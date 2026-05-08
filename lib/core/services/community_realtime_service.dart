import 'dart:async';

import 'package:imovie_app/core/events/app_auth_event.dart';
import 'package:imovie_app/core/events/app_community_event.dart';
import 'package:imovie_app/core/events/app_event_bus.dart';
import 'package:imovie_app/core/logger/app_logger.dart';
import 'package:imovie_app/core/services/supabase_data_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class CommunityRealtimeService {
  Future<void> initialize();
}

class SupabaseCommunityRealtimeService implements CommunityRealtimeService {
  SupabaseCommunityRealtimeService({required SupabaseDataService dataService})
    : _dataService = dataService;
  static const _watchedTables = <String>[
    'community_posts',
    'community_stories',
    'community_comments',
    'community_reactions',
    'community_follows',
    'profiles',
  ];
  static const _duplicateWindow = Duration(seconds: 3);

  final SupabaseDataService _dataService;
  final List<StreamSubscription<SupabaseTableChange>> _tableSubscriptions = [];
  final List<StreamSubscription<dynamic>> _subscriptions = [];
  final Map<String, DateTime> _recentEventKeys = <String, DateTime>{};

  bool _initialized = false;

  @override
  Future<void> initialize() async {
    if (_initialized) {
      return;
    }
    _initialized = true;

    _subscriptions.add(appEventBus.authStream.listen(_handleAuthEvent));
    await _startWatchingIfPossible();
  }

  void _handleAuthEvent(AppAuthEvent event) {
    switch (event.status) {
      case AppAuthEventStatus.authenticated:
        unawaited(_restartWatching());
        break;
      case AppAuthEventStatus.unauthenticated:
        unawaited(_cancelTableSubscriptions());
        break;
    }
  }

  Future<void> _restartWatching() async {
    await _cancelTableSubscriptions();
    await _startWatchingIfPossible();
  }

  Future<void> _startWatchingIfPossible() async {
    if (_tableSubscriptions.isNotEmpty || !_hasActiveUser) {
      return;
    }

    await _dataService.syncRealtimeAuth();

    for (final table in _watchedTables) {
      final broadcastSubscription = _dataService
          .watchBroadcastChanges(topic: _topicForTable(table))
          .listen(_handleRealtimeChange);
      _tableSubscriptions.add(broadcastSubscription);

      final fallbackSubscription = _dataService
          .watchTableChangeDetails(table: table)
          .listen(_handleRealtimeChange);
      _tableSubscriptions.add(fallbackSubscription);
    }
    AppLogger.info(
      'Community realtime subscriptions started.',
      name: 'CommunityRealtime',
    );
  }

  void _handleRealtimeChange(SupabaseTableChange change) {
    if (_isIncompleteRelationshipDelete(change)) {
      return;
    }

    if (_shouldSkipDuplicate(change)) {
      return;
    }

    appEventBus.emitCommunity(
      AppCommunityEvent.realtime(
        table: change.table,
        action: _mapAction(change.eventType),
        record: change.record,
        oldRecord: change.oldRecord,
      ),
    );
  }

  AppCommunityRealtimeAction _mapAction(PostgresChangeEvent eventType) {
    return switch (eventType) {
      PostgresChangeEvent.insert => AppCommunityRealtimeAction.inserted,
      PostgresChangeEvent.update => AppCommunityRealtimeAction.updated,
      PostgresChangeEvent.delete => AppCommunityRealtimeAction.deleted,
      _ => AppCommunityRealtimeAction.unknown,
    };
  }

  String _topicForTable(String table) => 'community:$table';

  bool _shouldSkipDuplicate(SupabaseTableChange change) {
    final recordId = _recordId(change);
    if (recordId.isEmpty) {
      return false;
    }

    final now = DateTime.now();
    _recentEventKeys.removeWhere(
      (_, timestamp) => now.difference(timestamp) > _duplicateWindow,
    );

    final key = '${change.table}:${change.eventType.name}:$recordId';
    final lastSeenAt = _recentEventKeys[key];
    if (lastSeenAt != null && now.difference(lastSeenAt) <= _duplicateWindow) {
      return true;
    }

    _recentEventKeys[key] = now;
    return false;
  }

  String _recordId(SupabaseTableChange change) {
    final record = change.isDelete ? change.oldRecord : change.record;
    return record['id']?.toString().trim() ?? '';
  }

  bool _isIncompleteRelationshipDelete(SupabaseTableChange change) {
    if (!change.isDelete) {
      return false;
    }

    if (change.table == 'community_reactions') {
      final postId = change.oldRecord['post_id']?.toString().trim() ?? '';
      final userId = change.oldRecord['user_id']?.toString().trim() ?? '';
      return postId.isEmpty || userId.isEmpty;
    }

    if (change.table == 'community_follows') {
      final followerId =
          change.oldRecord['follower_id']?.toString().trim() ?? '';
      final followingId =
          change.oldRecord['following_id']?.toString().trim() ?? '';
      return followerId.isEmpty || followingId.isEmpty;
    }

    return false;
  }

  Future<void> _cancelTableSubscriptions() async {
    for (final subscription in _tableSubscriptions) {
      await subscription.cancel();
    }
    _tableSubscriptions.clear();
    _recentEventKeys.clear();
    AppLogger.info(
      'Community realtime subscriptions stopped.',
      name: 'CommunityRealtime',
    );
  }

  bool get _hasActiveUser {
    try {
      _dataService.requireCurrentUser(
        unauthorizedMessage: 'Unable to access current user.',
        logName: 'CommunityRealtime',
        blockedLogMessage:
            'Community realtime skipped because there is no active user.',
      );
      return true;
    } catch (_) {
      return false;
    }
  }
}

class NoOpCommunityRealtimeService implements CommunityRealtimeService {
  const NoOpCommunityRealtimeService();

  @override
  Future<void> initialize() async {}
}
