import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:imovie_app/core/error/app_exception.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/logger/app_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseTableChange {
  const SupabaseTableChange({
    required this.schema,
    required this.table,
    required this.commitTimestamp,
    required this.eventType,
    required this.record,
    required this.oldRecord,
  });

  final String schema;
  final String table;
  final DateTime commitTimestamp;
  final PostgresChangeEvent eventType;
  final Map<String, dynamic> record;
  final Map<String, dynamic> oldRecord;

  bool get isDelete => eventType == PostgresChangeEvent.delete;
}

class SupabaseDataUser {
  const SupabaseDataUser({required this.id, this.email});

  final String id;
  final String? email;
}

abstract interface class SupabaseDataService {
  String getCurrentUserId();

  Future<void> syncRealtimeAuth();

  SupabaseDataUser requireCurrentUser({
    required String unauthorizedMessage,
    required String logName,
    required String blockedLogMessage,
  });

  Future<List<Map<String, dynamic>>> selectList({
    required String table,
    String columns = '*',
    Map<String, Object?> equals = const {},
    Map<String, List<Object?>> inFilters = const {},
    Map<String, Object?> greaterThan = const {},
    String? orderBy,
    bool ascending = true,
    int? rangeFrom,
    int? rangeTo,
  });

  Future<Map<String, dynamic>?> selectMaybeSingle({
    required String table,
    String columns = '*',
    Map<String, Object?> equals = const {},
  });

  Future<Map<String, dynamic>> selectSingle({
    required String table,
    String columns = '*',
    Map<String, Object?> equals = const {},
  });

  Future<Map<String, dynamic>> insertAndSelectSingle({
    required String table,
    required Map<String, dynamic> values,
  });

  Future<void> insert({
    required String table,
    required Map<String, dynamic> values,
  });

  Future<Map<String, dynamic>> upsertAndSelectSingle({
    required String table,
    required Map<String, dynamic> values,
    String? onConflict,
  });

  Future<Map<String, dynamic>> updateAndSelectSingle({
    required String table,
    required Map<String, dynamic> values,
    required Map<String, Object?> equals,
  });

  Future<int> count({
    required String table,
    Map<String, Object?> equals = const {},
  });

  Future<void> rpc({
    required String function,
    Map<String, dynamic> params = const {},
  });

  Future<Map<String, dynamic>> invokeFunction({
    required String function,
    Map<String, dynamic> body = const {},
  });

  Stream<void> watchTableChanges({
    required String table,
    String schema = 'public',
    String? filterColumn,
    String? filterValue,
  });

  Stream<SupabaseTableChange> watchTableChangeDetails({
    required String table,
    String schema = 'public',
    String? filterColumn,
    String? filterValue,
  });

  Stream<SupabaseTableChange> watchBroadcastChanges({
    required String topic,
    String event = '*',
    bool isPrivate = true,
  });

  Future<void> delete({
    required String table,
    required Map<String, Object?> equals,
  });

  Future<void> uploadBinary({
    required String bucket,
    required String path,
    required Uint8List bytes,
    required String contentType,
    required bool upsert,
    String cacheControl = '3600',
  });

  String getPublicUrl({required String bucket, required String path});

  Future<void> removeStorageObjects({
    required String bucket,
    required List<String> paths,
  });
}

class ConfiguredSupabaseDataService implements SupabaseDataService {
  const ConfiguredSupabaseDataService({required this.client});

  static const _databaseBroadcastEvents = <String>[
    'INSERT',
    'UPDATE',
    'DELETE',
  ];

  final SupabaseClient client;

  @override
  String getCurrentUserId() {
    return client.auth.currentUser?.id ?? '';
  }

  @override
  Future<void> syncRealtimeAuth() async {
    try {
      await client.realtime.setAuth(client.auth.currentSession?.accessToken);
    } catch (error) {
      AppLogger.warning(
        'Unable to sync realtime auth token. $error',
        name: 'SupabaseRealtime',
      );
    }
  }

  @override
  SupabaseDataUser requireCurrentUser({
    required String unauthorizedMessage,
    required String logName,
    required String blockedLogMessage,
  }) {
    final user = client.auth.currentUser;
    if (user == null) {
      AppLogger.warning(blockedLogMessage, name: logName);
      throw AppException(AppFailure.unauthorized(unauthorizedMessage));
    }

    return SupabaseDataUser(id: user.id, email: user.email);
  }

  @override
  Future<List<Map<String, dynamic>>> selectList({
    required String table,
    String columns = '*',
    Map<String, Object?> equals = const {},
    Map<String, List<Object?>> inFilters = const {},
    Map<String, Object?> greaterThan = const {},
    String? orderBy,
    bool ascending = true,
    int? rangeFrom,
    int? rangeTo,
  }) async {
    dynamic query = client.from(table).select(columns);
    query = _applyEquals(query, equals);
    query = _applyInFilters(query, inFilters);
    query = _applyGreaterThan(query, greaterThan);

    if (orderBy != null && orderBy.trim().isNotEmpty) {
      query = query.order(orderBy, ascending: ascending);
    }

    if (rangeFrom != null && rangeTo != null) {
      query = query.range(rangeFrom, rangeTo);
    }

    return _asRows(await query);
  }

  @override
  Future<Map<String, dynamic>?> selectMaybeSingle({
    required String table,
    String columns = '*',
    Map<String, Object?> equals = const {},
  }) async {
    dynamic query = client.from(table).select(columns);
    query = _applyEquals(query, equals);
    final row = await query.maybeSingle();
    return row == null ? null : _asRow(row);
  }

  @override
  Future<Map<String, dynamic>> selectSingle({
    required String table,
    String columns = '*',
    Map<String, Object?> equals = const {},
  }) async {
    dynamic query = client.from(table).select(columns);
    query = _applyEquals(query, equals);
    return _asRow(await query.single());
  }

  @override
  Future<Map<String, dynamic>> insertAndSelectSingle({
    required String table,
    required Map<String, dynamic> values,
  }) async {
    final row = await client.from(table).insert(values).select().single();
    return _asRow(row);
  }

  @override
  Future<void> insert({
    required String table,
    required Map<String, dynamic> values,
  }) async {
    await client.from(table).insert(values);
  }

  @override
  Future<Map<String, dynamic>> upsertAndSelectSingle({
    required String table,
    required Map<String, dynamic> values,
    String? onConflict,
  }) async {
    final row = await client
        .from(table)
        .upsert(values, onConflict: onConflict)
        .select()
        .single();
    return _asRow(row);
  }

  @override
  Future<Map<String, dynamic>> updateAndSelectSingle({
    required String table,
    required Map<String, dynamic> values,
    required Map<String, Object?> equals,
  }) async {
    dynamic query = client.from(table).update(values);
    query = _applyEquals(query, equals);
    return _asRow(await query.select().single());
  }

  @override
  Future<int> count({
    required String table,
    Map<String, Object?> equals = const {},
  }) async {
    dynamic query = client.from(table).count(CountOption.exact);
    query = _applyEquals(query, equals);
    return await query as int;
  }

  @override
  Future<void> rpc({
    required String function,
    Map<String, dynamic> params = const {},
  }) async {
    await client.rpc(function, params: params);
  }

  @override
  Future<Map<String, dynamic>> invokeFunction({
    required String function,
    Map<String, dynamic> body = const {},
  }) async {
    try {
      AppLogger.info(
        'Invoke function=$function action=${body['action'] ?? '<none>'}',
        name: 'Supabase.Function',
      );
      final response = await client.functions.invoke(function, body: body);
      AppLogger.info(
        'Function success function=$function status=${response.status}',
        name: 'Supabase.Function',
      );
      return _asRow(response.data);
    } on FunctionException catch (error) {
      final fallbackFunction = _fallbackFunctionName(function);
      if (fallbackFunction != null && _isFunctionNotFound(error)) {
        AppLogger.warning(
          'Function not found function=$function; retrying fallback=$fallbackFunction',
          name: 'Supabase.Function',
          error: error,
        );
        final response = await client.functions.invoke(
          fallbackFunction,
          body: body,
        );
        AppLogger.info(
          'Function success function=$fallbackFunction status=${response.status}',
          name: 'Supabase.Function',
        );
        return _asRow(response.data);
      }
      final message = _functionErrorMessage(error);
      AppLogger.error(
        'Function failed function=$function status=${error.status} '
        'reason=${error.reasonPhrase} message=$message',
        name: 'Supabase.Function',
        error: error,
      );
      throw AppException(
        AppFailure.server(
          message.isEmpty ? 'Supabase function request failed.' : message,
          details: error.toString(),
        ),
      );
    }
  }

  String? _fallbackFunctionName(String function) {
    return switch (function.trim()) {
      'call-chat' => 'chat-call',
      'chat-call' => 'call-chat',
      _ => null,
    };
  }

  bool _isFunctionNotFound(FunctionException error) {
    final details = error.details?.toString().toLowerCase() ?? '';
    final reason = error.reasonPhrase?.toLowerCase() ?? '';
    return error.status == 404 ||
        details.contains('not_found') ||
        details.contains('function was not found') ||
        reason.contains('not found');
  }

  @override
  Stream<void> watchTableChanges({
    required String table,
    String schema = 'public',
    String? filterColumn,
    String? filterValue,
  }) {
    return watchTableChangeDetails(
      table: table,
      schema: schema,
      filterColumn: filterColumn,
      filterValue: filterValue,
    ).map((_) {});
  }

  @override
  Stream<SupabaseTableChange> watchTableChangeDetails({
    required String table,
    String schema = 'public',
    String? filterColumn,
    String? filterValue,
  }) {
    late RealtimeChannel channel;
    late final StreamController<SupabaseTableChange> controller;
    final safeFilterColumn = filterColumn?.trim() ?? '';
    final safeFilterValue = filterValue?.trim() ?? '';
    final hasFilter = safeFilterColumn.isNotEmpty && safeFilterValue.isNotEmpty;

    controller = StreamController<SupabaseTableChange>.broadcast(
      onListen: () {
        channel = client.channel(
          '$schema:$table:${safeFilterColumn.isEmpty ? 'all' : safeFilterColumn}:${safeFilterValue.isEmpty ? 'all' : safeFilterValue}',
        );

        channel = channel.onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: schema,
          table: table,
          filter: hasFilter
              ? PostgresChangeFilter(
                  type: PostgresChangeFilterType.eq,
                  column: safeFilterColumn,
                  value: safeFilterValue,
                )
              : null,
          callback: (payload) {
            if (!controller.isClosed) {
              controller.add(
                SupabaseTableChange(
                  schema: payload.schema,
                  table: payload.table,
                  commitTimestamp: payload.commitTimestamp,
                  eventType: payload.eventType,
                  record: Map<String, dynamic>.unmodifiable(payload.newRecord),
                  oldRecord: Map<String, dynamic>.unmodifiable(
                    payload.oldRecord,
                  ),
                ),
              );
            }
          },
        );

        channel.subscribe();
      },
      onCancel: () {
        unawaited(client.removeChannel(channel));
      },
    );

    return controller.stream;
  }

  @override
  Stream<SupabaseTableChange> watchBroadcastChanges({
    required String topic,
    String event = '*',
    bool isPrivate = true,
  }) {
    late RealtimeChannel channel;
    late final StreamController<SupabaseTableChange> controller;
    final normalizedTopic = topic.trim();
    final normalizedEvent = event.trim().isEmpty ? '*' : event.trim();

    controller = StreamController<SupabaseTableChange>.broadcast(
      onListen: () {
        channel = client.channel(
          normalizedTopic,
          opts: RealtimeChannelConfig(private: isPrivate),
        );

        void handlePayload(String fallbackEvent, Map<String, dynamic> payload) {
          final data = _extractBroadcastChangePayload(
            payload,
            fallbackEvent: fallbackEvent,
          );
          if (data == null || controller.isClosed) {
            return;
          }

          controller.add(data);
        }

        if (normalizedEvent == '*') {
          for (final eventName in _databaseBroadcastEvents) {
            channel = channel.onBroadcast(
              event: eventName,
              callback: (payload) => handlePayload(eventName, payload),
            );
          }
        } else {
          channel = channel.onBroadcast(
            event: normalizedEvent,
            callback: (payload) => handlePayload(normalizedEvent, payload),
          );
        }

        channel.subscribe((status, error) {
          if (status == RealtimeSubscribeStatus.channelError) {
            AppLogger.warning(
              'Broadcast subscribe failed for $normalizedTopic:$normalizedEvent. $error',
              name: 'SupabaseRealtime',
            );
          }
        });
      },
      onCancel: () {
        unawaited(client.removeChannel(channel));
      },
    );

    return controller.stream;
  }

  @override
  Future<void> delete({
    required String table,
    required Map<String, Object?> equals,
  }) async {
    dynamic query = client.from(table).delete();
    query = _applyEquals(query, equals);
    await query;
  }

  @override
  Future<void> uploadBinary({
    required String bucket,
    required String path,
    required Uint8List bytes,
    required String contentType,
    required bool upsert,
    String cacheControl = '3600',
  }) async {
    await client.storage
        .from(bucket)
        .uploadBinary(
          path,
          bytes,
          fileOptions: FileOptions(
            cacheControl: cacheControl,
            contentType: contentType,
            upsert: upsert,
          ),
        );
  }

  @override
  String getPublicUrl({required String bucket, required String path}) {
    return client.storage.from(bucket).getPublicUrl(path);
  }

  @override
  Future<void> removeStorageObjects({
    required String bucket,
    required List<String> paths,
  }) async {
    if (paths.isEmpty) {
      return;
    }

    await client.storage.from(bucket).remove(paths);
  }

  dynamic _applyEquals(dynamic query, Map<String, Object?> equals) {
    var nextQuery = query;
    for (final entry in equals.entries) {
      nextQuery = nextQuery.eq(entry.key, entry.value);
    }
    return nextQuery;
  }

  dynamic _applyInFilters(dynamic query, Map<String, List<Object?>> inFilters) {
    var nextQuery = query;
    for (final entry in inFilters.entries) {
      nextQuery = nextQuery.inFilter(entry.key, entry.value);
    }
    return nextQuery;
  }

  dynamic _applyGreaterThan(dynamic query, Map<String, Object?> greaterThan) {
    var nextQuery = query;
    for (final entry in greaterThan.entries) {
      nextQuery = nextQuery.gt(entry.key, entry.value);
    }
    return nextQuery;
  }

  List<Map<String, dynamic>> _asRows(Object? rows) {
    if (rows is! Iterable) {
      return const [];
    }

    return rows
        .whereType<Map>()
        .map((row) => Map<String, dynamic>.from(row))
        .toList(growable: false);
  }

  Map<String, dynamic> _asRow(Object? row) {
    if (row is Map) {
      return Map<String, dynamic>.from(row);
    }

    throw AppException(
      AppFailure.unknown('Unexpected Supabase response shape.'),
    );
  }

  String _functionErrorMessage(FunctionException error) {
    final details = error.details;
    if (details is Map) {
      final value = details['error'] ?? details['message'];
      if (value != null) {
        if (value is Map || value is Iterable) {
          return jsonEncode(value);
        }
        return value.toString();
      }
      return jsonEncode(details);
    }
    if (details is String) {
      return details;
    }
    return error.reasonPhrase ?? '';
  }

  SupabaseTableChange? _extractBroadcastChangePayload(
    Map<String, dynamic> payload, {
    required String fallbackEvent,
  }) {
    final base = payload['schema'] != null && payload['table'] != null
        ? payload
        : payload['payload'] is Map<String, dynamic>
        ? Map<String, dynamic>.from(payload['payload'] as Map<String, dynamic>)
        : payload['data'] is Map<String, dynamic>
        ? Map<String, dynamic>.from(payload['data'] as Map<String, dynamic>)
        : null;
    if (base == null) {
      return null;
    }

    final table = base['table']?.toString().trim() ?? '';
    if (table.isEmpty) {
      return null;
    }

    final rawEvent =
        base['eventType']?.toString() ??
        base['type']?.toString() ??
        payload['event']?.toString() ??
        fallbackEvent;

    final eventType = _postgresChangeEventFromString(rawEvent);
    final record = _recordFromAny(base, const [
      'new',
      'new_record',
      'newRecord',
      'record',
    ]);
    final oldRecord = _recordFromAny(base, const [
      'old',
      'old_record',
      'oldRecord',
      'previous_record',
    ]);

    return SupabaseTableChange(
      schema: base['schema']?.toString() ?? 'public',
      table: table,
      commitTimestamp:
          DateTime.tryParse(base['commit_timestamp']?.toString() ?? '') ??
          DateTime.now().toUtc(),
      eventType: eventType,
      record: Map<String, dynamic>.unmodifiable(record),
      oldRecord: Map<String, dynamic>.unmodifiable(
        eventType == PostgresChangeEvent.delete && oldRecord.isEmpty
            ? record
            : oldRecord,
      ),
    );
  }

  Map<String, dynamic> _recordFromAny(
    Map<String, dynamic> payload,
    List<String> keys,
  ) {
    for (final key in keys) {
      final value = payload[key];
      if (value is Map) {
        return Map<String, dynamic>.from(value);
      }
    }

    return const <String, dynamic>{};
  }

  PostgresChangeEvent _postgresChangeEventFromString(String rawEvent) {
    return switch (rawEvent.toUpperCase()) {
      'INSERT' => PostgresChangeEvent.insert,
      'UPDATE' => PostgresChangeEvent.update,
      'DELETE' => PostgresChangeEvent.delete,
      _ => PostgresChangeEvent.all,
    };
  }
}

class UnconfiguredSupabaseDataService implements SupabaseDataService {
  const UnconfiguredSupabaseDataService();

  @override
  String getCurrentUserId() => '';

  @override
  Future<void> syncRealtimeAuth() async {}

  @override
  SupabaseDataUser requireCurrentUser({
    required String unauthorizedMessage,
    required String logName,
    required String blockedLogMessage,
  }) {
    AppLogger.warning(
      'Supabase data access blocked because Supabase is not configured.',
      name: logName,
    );
    throw const AppException(_configurationFailure);
  }

  @override
  Future<List<Map<String, dynamic>>> selectList({
    required String table,
    String columns = '*',
    Map<String, Object?> equals = const {},
    Map<String, List<Object?>> inFilters = const {},
    Map<String, Object?> greaterThan = const {},
    String? orderBy,
    bool ascending = true,
    int? rangeFrom,
    int? rangeTo,
  }) async {
    throw const AppException(_configurationFailure);
  }

  @override
  Future<Map<String, dynamic>?> selectMaybeSingle({
    required String table,
    String columns = '*',
    Map<String, Object?> equals = const {},
  }) async {
    throw const AppException(_configurationFailure);
  }

  @override
  Future<Map<String, dynamic>> selectSingle({
    required String table,
    String columns = '*',
    Map<String, Object?> equals = const {},
  }) async {
    throw const AppException(_configurationFailure);
  }

  @override
  Future<Map<String, dynamic>> insertAndSelectSingle({
    required String table,
    required Map<String, dynamic> values,
  }) async {
    throw const AppException(_configurationFailure);
  }

  @override
  Future<void> insert({
    required String table,
    required Map<String, dynamic> values,
  }) async {
    throw const AppException(_configurationFailure);
  }

  @override
  Future<Map<String, dynamic>> upsertAndSelectSingle({
    required String table,
    required Map<String, dynamic> values,
    String? onConflict,
  }) async {
    throw const AppException(_configurationFailure);
  }

  @override
  Future<Map<String, dynamic>> updateAndSelectSingle({
    required String table,
    required Map<String, dynamic> values,
    required Map<String, Object?> equals,
  }) async {
    throw const AppException(_configurationFailure);
  }

  @override
  Future<void> delete({
    required String table,
    required Map<String, Object?> equals,
  }) async {
    throw const AppException(_configurationFailure);
  }

  @override
  Future<int> count({
    required String table,
    Map<String, Object?> equals = const {},
  }) async {
    throw const AppException(_configurationFailure);
  }

  @override
  Future<void> rpc({
    required String function,
    Map<String, dynamic> params = const {},
  }) async {
    throw const AppException(_configurationFailure);
  }

  @override
  Future<Map<String, dynamic>> invokeFunction({
    required String function,
    Map<String, dynamic> body = const {},
  }) async {
    throw const AppException(_configurationFailure);
  }

  @override
  Stream<void> watchTableChanges({
    required String table,
    String schema = 'public',
    String? filterColumn,
    String? filterValue,
  }) {
    throw const AppException(_configurationFailure);
  }

  @override
  Stream<SupabaseTableChange> watchTableChangeDetails({
    required String table,
    String schema = 'public',
    String? filterColumn,
    String? filterValue,
  }) {
    throw const AppException(_configurationFailure);
  }

  @override
  Stream<SupabaseTableChange> watchBroadcastChanges({
    required String topic,
    String event = '*',
    bool isPrivate = true,
  }) {
    throw const AppException(_configurationFailure);
  }

  @override
  Future<void> uploadBinary({
    required String bucket,
    required String path,
    required Uint8List bytes,
    required String contentType,
    required bool upsert,
    String cacheControl = '3600',
  }) async {
    throw const AppException(_configurationFailure);
  }

  @override
  String getPublicUrl({required String bucket, required String path}) {
    throw const AppException(_configurationFailure);
  }

  @override
  Future<void> removeStorageObjects({
    required String bucket,
    required List<String> paths,
  }) async {
    throw const AppException(_configurationFailure);
  }
}

const _configurationFailure = AppFailure(
  type: FailureType.configuration,
  message:
      'Supabase is not configured. Provide SUPABASE_URL and SUPABASE_ANON_KEY via --dart-define.',
);
