import 'dart:typed_data';

import 'package:imovie_app/core/error/app_exception.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/logger/app_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDataUser {
  const SupabaseDataUser({required this.id, this.email});

  final String id;
  final String? email;
}

abstract interface class SupabaseDataService {
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

  final SupabaseClient client;

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
}

class UnconfiguredSupabaseDataService implements SupabaseDataService {
  const UnconfiguredSupabaseDataService();

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
