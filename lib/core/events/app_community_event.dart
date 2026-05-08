enum AppCommunityEventType { changed, realtime }

enum AppCommunityRealtimeAction { inserted, updated, deleted, unknown }

class AppCommunityEvent {
  const AppCommunityEvent._({
    required this.type,
    this.table = '',
    this.action = AppCommunityRealtimeAction.unknown,
    this.record = const <String, dynamic>{},
    this.oldRecord = const <String, dynamic>{},
  });

  factory AppCommunityEvent.changed() {
    return const AppCommunityEvent._(type: AppCommunityEventType.changed);
  }

  factory AppCommunityEvent.realtime({
    required String table,
    required AppCommunityRealtimeAction action,
    required Map<String, dynamic> record,
    required Map<String, dynamic> oldRecord,
  }) {
    return AppCommunityEvent._(
      type: AppCommunityEventType.realtime,
      table: table.trim(),
      action: action,
      record: Map<String, dynamic>.unmodifiable(record),
      oldRecord: Map<String, dynamic>.unmodifiable(oldRecord),
    );
  }

  final AppCommunityEventType type;
  final String table;
  final AppCommunityRealtimeAction action;
  final Map<String, dynamic> record;
  final Map<String, dynamic> oldRecord;

  bool get isFallbackRefresh => type == AppCommunityEventType.changed;
  bool get isRealtime => type == AppCommunityEventType.realtime;
  bool get isDeleted => action == AppCommunityRealtimeAction.deleted;

  Map<String, dynamic> get activeRecord => isDeleted ? oldRecord : record;

  String valueOf(String column) {
    return activeRecord[column]?.toString().trim() ?? '';
  }

  String valueOfAny(Iterable<String> columns) {
    for (final column in columns) {
      final value = valueOf(column);
      if (value.isNotEmpty) {
        return value;
      }
    }

    return '';
  }

  String get recordId => valueOf('id');
}
