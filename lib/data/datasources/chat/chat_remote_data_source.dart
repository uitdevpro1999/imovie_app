import 'dart:async';
import 'dart:io';

import 'package:agora_chat_sdk/agora_chat_sdk.dart' as agora;
import 'package:imovie_app/core/logger/app_logger.dart';
import 'package:imovie_app/core/services/chat/agora_chat_service.dart';
import 'package:imovie_app/core/services/supabase_data_service.dart';
import 'package:imovie_app/data/models/response/chat/chat_conversation_response.dart';
import 'package:imovie_app/data/models/response/chat/chat_message_response.dart';
import 'package:imovie_app/domain/entities/chat/chat_message.dart';

abstract interface class ChatRemoteDataSource {
  Future<List<ChatConversationResponse>> getConversations({
    required int page,
    required int limit,
  });

  Future<ChatConversationResponse> getOrCreateDirectConversation({
    required String userId,
  });

  Future<List<ChatMessageResponse>> getMessages({
    required String conversationId,
    required int page,
    required int limit,
  });

  Future<ChatMessageResponse> sendTextMessage({
    required String conversationId,
    required String body,
  });

  Future<ChatMessageResponse> sendImageMessage({
    required String conversationId,
    required String imagePath,
    required String fileName,
  });

  Future<void> recallMessage(String messageId);

  Future<void> toggleReaction({
    required String conversationId,
    required String messageId,
    required String reaction,
    required bool reactedByMe,
  });

  Future<void> markConversationRead(String conversationId);

  Stream<void> watchConversations();

  Stream<void> watchMessages(String conversationId);
}

class SupabaseChatRemoteDataSource implements ChatRemoteDataSource {
  const SupabaseChatRemoteDataSource({
    required this.dataService,
    required this.agoraChatService,
  });

  static const _conversationSummariesView = 'chat_conversation_summaries';
  static const _edgeFunction = 'call-chat';
  static const _logName = 'ChatDataSource';

  final SupabaseDataService dataService;
  final AgoraChatService agoraChatService;

  @override
  Future<List<ChatConversationResponse>> getConversations({
    required int page,
    required int limit,
  }) async {
    final user = _currentUser();
    AppLogger.info(
      'Load conversations user=${AppLogger.shortId(user.id)} '
      'page=$page limit=$limit',
      name: _logName,
    );
    final normalizedPage = page < 1 ? 1 : page;
    final normalizedLimit = limit < 1 ? 1 : limit;
    final from = (normalizedPage - 1) * normalizedLimit;
    final to = from + normalizedLimit - 1;
    final rows = await dataService.selectList(
      table: _conversationSummariesView,
      equals: {'current_user_id': user.id},
      orderBy: 'last_message_at',
      ascending: false,
      rangeFrom: from,
      rangeTo: to,
    );
    final conversations = rows
        .map(ChatConversationResponse.fromJson)
        .toList(growable: false);
    AppLogger.info(
      'Loaded conversations count=${conversations.length}',
      name: _logName,
    );
    return conversations;
  }

  @override
  Future<ChatConversationResponse> getOrCreateDirectConversation({
    required String userId,
  }) async {
    AppLogger.info(
      'Get/create direct conversation target=${AppLogger.shortId(userId)}',
      name: _logName,
    );
    final row = await dataService.invokeFunction(
      function: _edgeFunction,
      body: {'action': 'get_or_create_direct_conversation', 'userId': userId},
    );
    final conversation = ChatConversationResponse.fromJson(
      row['conversation'] is Map
          ? Map<String, dynamic>.from(row['conversation'] as Map)
          : row,
    );
    AppLogger.info(
      'Direct conversation ready conversation=${AppLogger.shortId(conversation.id)} '
      'participants=${conversation.participantIds.map(AppLogger.shortId).join(',')}',
      name: _logName,
    );
    return conversation;
  }

  @override
  Future<List<ChatMessageResponse>> getMessages({
    required String conversationId,
    required int page,
    required int limit,
  }) async {
    AppLogger.info(
      'Load messages conversation=${AppLogger.shortId(conversationId)} '
      'page=$page limit=$limit',
      name: _logName,
    );
    final session = await agoraChatService.sessionForConversation(
      conversationId,
    );
    final messages = await agoraChatService.fetchTextMessages(
      conversationId: conversationId,
      page: page,
      limit: limit,
    );
    final displayMessages = await Future.wait(
      messages.map(agoraChatService.prepareMessageForDisplay),
    );
    final reactionsByMessageId = await _fetchReactions(
      conversationId: conversationId,
      messages: displayMessages,
    );
    final chatResponses = await Future.wait(
      displayMessages.map(
        (message) => _agoraMessageToResponse(
          message,
          session,
          conversationId,
          reactionsByMessageId[message.msgId] ?? const [],
        ),
      ),
    );
    final callResponses = await _getCallMessages(conversationId);
    final responses = [...chatResponses, ...callResponses]
      ..sort((left, right) => _compareDate(left.createdAt, right.createdAt));
    AppLogger.info(
      'Loaded messages conversation=${AppLogger.shortId(conversationId)} '
      'count=${responses.length}',
      name: _logName,
    );
    return responses;
  }

  @override
  Future<ChatMessageResponse> sendTextMessage({
    required String conversationId,
    required String body,
  }) async {
    AppLogger.info(
      'Send message conversation=${AppLogger.shortId(conversationId)} '
      'bodyLength=${body.trim().length}',
      name: _logName,
    );
    final session = await agoraChatService.sessionForConversation(
      conversationId,
    );
    final message = await agoraChatService.sendTextMessage(
      conversationId: conversationId,
      body: body.trim(),
    );
    await agoraChatService.notifyTextMessageSent(
      conversationId: conversationId,
      body: body.trim(),
      agoraMessageId: message.msgId,
    );
    final response = await _agoraMessageToResponse(
      message,
      session,
      conversationId,
      const [],
    );
    AppLogger.info(
      'Send message complete conversation=${AppLogger.shortId(conversationId)} '
      'msg=${AppLogger.shortId(response.id)}',
      name: _logName,
    );
    return response;
  }

  @override
  Future<ChatMessageResponse> sendImageMessage({
    required String conversationId,
    required String imagePath,
    required String fileName,
  }) async {
    AppLogger.info(
      'Send image message conversation=${AppLogger.shortId(conversationId)} '
      'file=$fileName',
      name: _logName,
    );
    final session = await agoraChatService.sessionForConversation(
      conversationId,
    );
    final message = await agoraChatService.sendImageMessage(
      conversationId: conversationId,
      imagePath: imagePath,
      fileName: fileName,
    );
    await agoraChatService.notifyTextMessageSent(
      conversationId: conversationId,
      body: 'Ảnh',
      agoraMessageId: message.msgId,
    );
    final displayMessage = await agoraChatService.prepareMessageForDisplay(
      message,
    );
    final response = await _agoraMessageToResponse(
      displayMessage,
      session,
      conversationId,
      const [],
    );
    AppLogger.info(
      'Send image complete conversation=${AppLogger.shortId(conversationId)} '
      'msg=${AppLogger.shortId(response.id)}',
      name: _logName,
    );
    return response;
  }

  @override
  Future<void> recallMessage(String messageId) {
    return agoraChatService.recallMessage(messageId);
  }

  @override
  Future<void> toggleReaction({
    required String conversationId,
    required String messageId,
    required String reaction,
    required bool reactedByMe,
  }) {
    if (reactedByMe) {
      return agoraChatService.removeReaction(
        conversationId: conversationId,
        messageId: messageId,
        reaction: reaction,
      );
    }
    return agoraChatService.addReaction(
      conversationId: conversationId,
      messageId: messageId,
      reaction: reaction,
    );
  }

  @override
  Future<void> markConversationRead(String conversationId) async {
    AppLogger.info(
      'Mark conversation read conversation=${AppLogger.shortId(conversationId)}',
      name: _logName,
    );
    await agoraChatService.markConversationRead(conversationId);
    await dataService.rpc(
      function: 'mark_chat_conversation_read',
      params: {'target_conversation_id': conversationId},
    );
  }

  @override
  Stream<void> watchConversations() {
    _currentUser();
    AppLogger.info('Watch conversations.', name: _logName);
    late final StreamSubscription<void> conversationSubscription;
    late final StreamSubscription<void> participantSubscription;
    final controller = StreamController<void>();

    controller.onListen = () {
      conversationSubscription = dataService
          .watchTableChanges(table: 'chat_conversations')
          .listen(controller.add, onError: controller.addError);
      participantSubscription = dataService
          .watchTableChanges(table: 'chat_participants')
          .listen(controller.add, onError: controller.addError);
    };
    controller.onCancel = () async {
      await conversationSubscription.cancel();
      await participantSubscription.cancel();
    };
    return controller.stream;
  }

  @override
  Stream<void> watchMessages(String conversationId) {
    AppLogger.info(
      'Watch messages conversation=${AppLogger.shortId(conversationId)}',
      name: _logName,
    );
    return _watchAgoraMessages(conversationId);
  }

  SupabaseDataUser _currentUser() {
    return dataService.requireCurrentUser(
      unauthorizedMessage: 'Unable to access chat.',
      logName: 'Supabase.Chat',
      blockedLogMessage:
          'Chat request blocked because there is no active user.',
    );
  }

  Stream<void> _watchAgoraMessages(String conversationId) async* {
    try {
      final session = await agoraChatService.sessionForConversation(
        conversationId,
      );
      AppLogger.info(
        'Watch messages session ready conversation=${AppLogger.shortId(conversationId)} '
        'peer=${session.peerAgoraUsername}',
        name: _logName,
      );
      yield* agoraChatService.watchMessageChanges();
    } catch (error, stackTrace) {
      AppLogger.error(
        'Watch messages failed conversation=${AppLogger.shortId(conversationId)}.',
        name: _logName,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<ChatMessageResponse> _agoraMessageToResponse(
    agora.ChatMessage message,
    AgoraChatSession session,
    String conversationId,
    List<ChatMessageReaction> reactions,
  ) async {
    final body = message.body;
    final senderId = message.from == session.peerAgoraUsername
        ? session.peerUserId
        : session.userId;
    final createdAt = message.serverTime > 0
        ? DateTime.fromMillisecondsSinceEpoch(message.serverTime)
        : DateTime.fromMillisecondsSinceEpoch(message.localTime);
    final imageBody = body is agora.ChatImageMessageBody ? body : null;
    final imagePath = await _firstExistingImagePath(message.msgId, imageBody);
    return ChatMessageResponse(
      id: message.msgId,
      conversationId: conversationId,
      senderId: senderId,
      senderName: '',
      senderAvatarUrl: '',
      body: body is agora.ChatTextMessageBody ? body.content : imagePath,
      type: body is agora.ChatTextMessageBody
          ? ChatMessageType.text
          : body is agora.ChatImageMessageBody
          ? ChatMessageType.image
          : ChatMessageType.system,
      status: message.hasReadAck
          ? ChatMessageStatus.read
          : message.hasDeliverAck
          ? ChatMessageStatus.delivered
          : ChatMessageStatus.sent,
      reactions: reactions,
      createdAt: createdAt,
      deletedAt: null,
    );
  }

  Future<Map<String, List<ChatMessageReaction>>> _fetchReactions({
    required String conversationId,
    required List<agora.ChatMessage> messages,
  }) async {
    final messageIds = messages
        .map((message) => message.msgId.trim())
        .where((messageId) => messageId.isNotEmpty)
        .toList(growable: false);
    if (messageIds.isEmpty) {
      return const {};
    }

    try {
      final rawReactions = await agoraChatService.fetchReactions(
        conversationId: conversationId,
        messageIds: messageIds,
      );
      return rawReactions.map(
        (messageId, reactions) => MapEntry(
          messageId,
          reactions
              .map(
                (reaction) => ChatMessageReaction(
                  reaction: reaction.reaction,
                  count: reaction.userCount,
                  reactedByMe: reaction.isAddedBySelf,
                ),
              )
              .where((reaction) => reaction.count > 0)
              .toList(growable: false),
        ),
      );
    } catch (error, stackTrace) {
      AppLogger.warning(
        'Fetch message reactions failed conversation=${AppLogger.shortId(conversationId)}.',
        name: _logName,
        error: error,
        stackTrace: stackTrace,
      );
      return const {};
    }
  }

  Future<List<ChatMessageResponse>> _getCallMessages(
    String conversationId,
  ) async {
    try {
      final rows = await dataService.selectList(
        table: 'call_sessions',
        equals: {'conversation_id': conversationId},
        orderBy: 'started_at',
        ascending: true,
      );
      return rows
          .map((row) {
            final callId = row['id']?.toString() ?? '';
            final rawType = row['type']?.toString() ?? '';
            final rawStatus = row['status']?.toString() ?? '';
            final startedAt = DateTime.tryParse(
              row['started_at']?.toString() ?? '',
            );
            return ChatMessageResponse(
              id: 'call_$callId',
              conversationId: conversationId,
              senderId: row['caller_id']?.toString() ?? '',
              senderName: '',
              senderAvatarUrl: '',
              body: _callHistoryLabel(rawType, rawStatus),
              type: ChatMessageType.system,
              status: ChatMessageStatus.sent,
              createdAt: startedAt,
              deletedAt: null,
            );
          })
          .toList(growable: false);
    } catch (error, stackTrace) {
      AppLogger.warning(
        'Load call history failed conversation=${AppLogger.shortId(conversationId)}.',
        name: _logName,
        error: error,
        stackTrace: stackTrace,
      );
      return const [];
    }
  }

  String _callHistoryLabel(String rawType, String rawStatus) {
    final typeLabel = rawType == 'video' ? 'video' : 'thoại';
    return switch (rawStatus) {
      'accepted' || 'active' || 'ended' => 'Cuộc gọi $typeLabel',
      'declined' => 'Cuộc gọi $typeLabel bị từ chối',
      'missed' => 'Cuộc gọi $typeLabel bị nhỡ',
      'cancelled' => 'Cuộc gọi $typeLabel đã hủy',
      'failed' => 'Cuộc gọi $typeLabel thất bại',
      _ => 'Đã bắt đầu cuộc gọi $typeLabel',
    };
  }

  int _compareDate(DateTime? left, DateTime? right) {
    final normalizedLeft = left ?? DateTime.fromMillisecondsSinceEpoch(0);
    final normalizedRight = right ?? DateTime.fromMillisecondsSinceEpoch(0);
    return normalizedRight.compareTo(normalizedLeft);
  }

  Future<String> _firstExistingImagePath(
    String messageId,
    agora.ChatImageMessageBody? body,
  ) async {
    if (body == null) {
      return '';
    }
    final localPath = body.localPath.trim();
    final thumbnailPath = body.thumbnailLocalPath?.trim() ?? '';
    if (localPath.isNotEmpty && File(localPath).existsSync()) {
      return _cacheImagePath(messageId, localPath);
    }
    if (thumbnailPath.isNotEmpty && File(thumbnailPath).existsSync()) {
      return _cacheImagePath(messageId, thumbnailPath);
    }
    AppLogger.warning(
      'Image file path is not ready msg=${AppLogger.shortId(messageId)} '
      'localPath=${localPath.isEmpty ? '<empty>' : localPath} '
      'thumbnailPath=${thumbnailPath.isEmpty ? '<empty>' : thumbnailPath}.',
      name: _logName,
    );
    return '';
  }

  Future<String> _cacheImagePath(String messageId, String sourcePath) async {
    final sourceFile = File(sourcePath);
    if (!sourceFile.existsSync()) {
      return sourcePath;
    }
    final extension = _extensionFor(sourcePath);
    final normalizedId = messageId
        .replaceAll(RegExp(r'[^a-zA-Z0-9_-]'), '_')
        .trim();
    final cacheDirectory = Directory(
      '${Directory.systemTemp.path}/imovie_chat_images',
    );
    if (!cacheDirectory.existsSync()) {
      await cacheDirectory.create(recursive: true);
    }
    final cacheFile = File('${cacheDirectory.path}/$normalizedId$extension');
    if (!cacheFile.existsSync() ||
        cacheFile.lengthSync() != sourceFile.lengthSync()) {
      await sourceFile.copy(cacheFile.path);
    }
    return cacheFile.path;
  }

  String _extensionFor(String path) {
    final lastSegment = path.split('/').last;
    final dotIndex = lastSegment.lastIndexOf('.');
    if (dotIndex < 0 || dotIndex == lastSegment.length - 1) {
      return '.jpg';
    }
    return lastSegment.substring(dotIndex);
  }
}
