import 'package:imovie_app/core/services/supabase_data_service.dart';
import 'package:imovie_app/data/models/response/call/call_session_response.dart';
import 'package:imovie_app/domain/entities/call/call_session.dart';

abstract interface class CallRemoteDataSource {
  Future<CallSessionResponse> startCall({
    required String conversationId,
    required CallType type,
  });

  Future<CallSessionResponse> answerCall(String callId);

  Future<void> declineCall(String callId);

  Future<void> endCall(String callId);

  Future<CallSessionResponse> getCall(String callId);

  Stream<CallStatus> watchCallStatus(String callId);
}

class SupabaseCallRemoteDataSource implements CallRemoteDataSource {
  const SupabaseCallRemoteDataSource({required this.dataService});

  static const _callsTable = 'call_sessions';
  static const _edgeFunction = 'call-chat';

  final SupabaseDataService dataService;

  @override
  Future<CallSessionResponse> startCall({
    required String conversationId,
    required CallType type,
  }) async {
    final row = await dataService.invokeFunction(
      function: _edgeFunction,
      body: {
        'action': 'start_call',
        'conversationId': conversationId,
        'type': type == CallType.video ? 'video' : 'audio',
      },
    );
    return _responseFromPayload(row);
  }

  @override
  Future<CallSessionResponse> answerCall(String callId) async {
    final row = await dataService.invokeFunction(
      function: _edgeFunction,
      body: {'action': 'answer_call', 'callId': callId},
    );
    return _responseFromPayload(row);
  }

  @override
  Future<void> declineCall(String callId) async {
    await dataService.invokeFunction(
      function: _edgeFunction,
      body: {'action': 'decline_call', 'callId': callId},
    );
  }

  @override
  Future<void> endCall(String callId) async {
    await dataService.invokeFunction(
      function: _edgeFunction,
      body: {'action': 'end_call', 'callId': callId},
    );
  }

  @override
  Future<CallSessionResponse> getCall(String callId) async {
    final row = await dataService.invokeFunction(
      function: _edgeFunction,
      body: {'action': 'get_call', 'callId': callId},
    );
    return _responseFromPayload(row);
  }

  @override
  Stream<CallStatus> watchCallStatus(String callId) {
    _currentUser();
    return dataService
        .watchTableChangeDetails(
          table: _callsTable,
          filterColumn: 'id',
          filterValue: callId,
        )
        .map((change) => _statusFromRaw(change.record['status']));
  }

  CallStatus _statusFromRaw(Object? raw) {
    return switch (raw?.toString().trim()) {
      'accepted' => CallStatus.accepted,
      'active' => CallStatus.active,
      'ended' => CallStatus.ended,
      'missed' => CallStatus.missed,
      'declined' => CallStatus.declined,
      'cancelled' => CallStatus.cancelled,
      'failed' => CallStatus.failed,
      _ => CallStatus.ringing,
    };
  }

  CallSessionResponse _responseFromPayload(Map<String, dynamic> payload) {
    return CallSessionResponse.fromJson(
      payload['call'] is Map
          ? Map<String, dynamic>.from(payload['call'] as Map)
          : payload,
    );
  }

  SupabaseDataUser _currentUser() {
    return dataService.requireCurrentUser(
      unauthorizedMessage: 'Unable to access calls.',
      logName: 'Supabase.Call',
      blockedLogMessage:
          'Call request blocked because there is no active user.',
    );
  }
}
