import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/domain/entities/call/call_session.dart';

abstract interface class CallRepository {
  Future<Result<CallSession>> startCall({
    required String conversationId,
    required CallType type,
  });

  Future<Result<CallSession>> answerCall(String callId);

  Future<Result<void>> declineCall(String callId);

  Future<Result<void>> endCall(String callId);

  Future<Result<CallSession>> getCall(String callId);

  Stream<CallStatus> watchCallStatus(String callId);
}
