enum CallType { audio, video }

enum CallStatus {
  ringing,
  accepted,
  active,
  ended,
  missed,
  declined,
  cancelled,
  failed,
}

class CallSession {
  const CallSession({
    required this.id,
    required this.conversationId,
    required this.callerId,
    required this.callerName,
    required this.callerAvatarUrl,
    required this.displayName,
    required this.displayAvatarUrl,
    required this.type,
    required this.status,
    required this.agoraChannel,
    required this.agoraUid,
    required this.agoraToken,
    required this.startedAt,
    required this.acceptedAt,
    required this.endedAt,
  });

  final String id;
  final String conversationId;
  final String callerId;
  final String callerName;
  final String callerAvatarUrl;
  final String displayName;
  final String displayAvatarUrl;
  final CallType type;
  final CallStatus status;
  final String agoraChannel;
  final int agoraUid;
  final String agoraToken;
  final DateTime? startedAt;
  final DateTime? acceptedAt;
  final DateTime? endedAt;

  bool get isVideo => type == CallType.video;
  bool get canJoin => agoraChannel.isNotEmpty && agoraToken.isNotEmpty;
  bool get isFinished {
    return switch (status) {
      CallStatus.ended ||
      CallStatus.missed ||
      CallStatus.declined ||
      CallStatus.cancelled ||
      CallStatus.failed => true,
      _ => false,
    };
  }

  CallSession copyWith({CallStatus? status, DateTime? endedAt}) {
    return CallSession(
      id: id,
      conversationId: conversationId,
      callerId: callerId,
      callerName: callerName,
      callerAvatarUrl: callerAvatarUrl,
      displayName: displayName,
      displayAvatarUrl: displayAvatarUrl,
      type: type,
      status: status ?? this.status,
      agoraChannel: agoraChannel,
      agoraUid: agoraUid,
      agoraToken: agoraToken,
      startedAt: startedAt,
      acceptedAt: acceptedAt,
      endedAt: endedAt ?? this.endedAt,
    );
  }
}
