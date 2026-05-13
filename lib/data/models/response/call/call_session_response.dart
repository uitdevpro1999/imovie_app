import 'package:imovie_app/domain/entities/call/call_session.dart';

class CallSessionResponse {
  const CallSessionResponse({
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

  factory CallSessionResponse.fromJson(Map<String, dynamic> json) {
    return CallSessionResponse(
      id: json['id']?.toString() ?? '',
      conversationId: json['conversation_id']?.toString() ?? '',
      callerId: json['caller_id']?.toString() ?? '',
      callerName: json['caller_name']?.toString() ?? 'iMovie user',
      callerAvatarUrl: json['caller_avatar_url']?.toString() ?? '',
      displayName:
          json['display_name']?.toString() ??
          json['peer_name']?.toString() ??
          json['caller_name']?.toString() ??
          'iMovie user',
      displayAvatarUrl:
          json['display_avatar_url']?.toString() ??
          json['peer_avatar_url']?.toString() ??
          json['caller_avatar_url']?.toString() ??
          '',
      type: json['type']?.toString() == 'video'
          ? CallType.video
          : CallType.audio,
      status: _statusFromString(json['status']?.toString() ?? ''),
      agoraChannel: json['agora_channel']?.toString() ?? '',
      agoraUid: _intValue(json['agora_uid']),
      agoraToken: json['agora_token']?.toString() ?? '',
      startedAt: DateTime.tryParse(json['started_at']?.toString() ?? ''),
      acceptedAt: DateTime.tryParse(json['accepted_at']?.toString() ?? ''),
      endedAt: DateTime.tryParse(json['ended_at']?.toString() ?? ''),
    );
  }

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

  CallSession toEntity() {
    return CallSession(
      id: id,
      conversationId: conversationId,
      callerId: callerId,
      callerName: callerName,
      callerAvatarUrl: callerAvatarUrl,
      displayName: displayName,
      displayAvatarUrl: displayAvatarUrl,
      type: type,
      status: status,
      agoraChannel: agoraChannel,
      agoraUid: agoraUid,
      agoraToken: agoraToken,
      startedAt: startedAt,
      acceptedAt: acceptedAt,
      endedAt: endedAt,
    );
  }

  static int _intValue(Object? value) {
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static CallStatus _statusFromString(String value) {
    return switch (value.trim()) {
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
}
