import 'dart:async';
import 'dart:io';

import 'package:agora_chat_sdk/agora_chat_sdk.dart' as agora;
import 'package:imovie_app/core/error/app_exception.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/logger/app_logger.dart';
import 'package:imovie_app/core/services/supabase_data_service.dart';

class AgoraChatSession {
  const AgoraChatSession({
    required this.userId,
    required this.agoraUsername,
    required this.agoraUuid,
    required this.agoraToken,
    required this.peerUserId,
    required this.peerAgoraUsername,
    required this.peerAgoraUuid,
  });

  factory AgoraChatSession.fromJson(Map<String, dynamic> json) {
    return AgoraChatSession(
      userId: json['user_id']?.toString() ?? '',
      agoraUsername: json['agora_username']?.toString() ?? '',
      agoraUuid: json['agora_uuid']?.toString() ?? '',
      agoraToken: json['agora_token']?.toString() ?? '',
      peerUserId: json['peer_user_id']?.toString() ?? '',
      peerAgoraUsername: json['peer_agora_username']?.toString() ?? '',
      peerAgoraUuid: json['peer_agora_uuid']?.toString() ?? '',
    );
  }

  final String userId;
  final String agoraUsername;
  final String agoraUuid;
  final String agoraToken;
  final String peerUserId;
  final String peerAgoraUsername;
  final String peerAgoraUuid;
}

abstract interface class AgoraChatService {
  Future<AgoraChatSession> sessionForConversation(String conversationId);

  Future<List<agora.ChatMessage>> fetchTextMessages({
    required String conversationId,
    required int page,
    required int limit,
  });

  Future<agora.ChatMessage> sendTextMessage({
    required String conversationId,
    required String body,
  });

  Future<agora.ChatMessage> sendImageMessage({
    required String conversationId,
    required String imagePath,
    required String fileName,
  });

  Future<void> recallMessage(String messageId);

  Future<Map<String, List<agora.ChatMessageReaction>>> fetchReactions({
    required String conversationId,
    required List<String> messageIds,
  });

  Future<void> addReaction({
    required String conversationId,
    required String messageId,
    required String reaction,
  });

  Future<void> removeReaction({
    required String conversationId,
    required String messageId,
    required String reaction,
  });

  Future<agora.ChatMessage> prepareMessageForDisplay(agora.ChatMessage message);

  Future<void> notifyTextMessageSent({
    required String conversationId,
    required String body,
    required String agoraMessageId,
  });

  Future<void> markConversationRead(String conversationId);

  Stream<agora.ChatMessage> watchMessages();

  Stream<void> watchMessageChanges();
}

class SdkAgoraChatService implements AgoraChatService {
  SdkAgoraChatService({required this.dataService, required this.appKey});

  static const _edgeFunction = 'call-chat';
  static const _logName = 'AgoraChat';
  static const _connectionHandlerId = 'imovie_agora_chat_connection';
  static const _messageHandlerId = 'imovie_agora_chat_messages';
  static const _sdkTimeout = Duration(seconds: 20);

  final SupabaseDataService dataService;
  final String appKey;

  final _messageController = StreamController<agora.ChatMessage>.broadcast();
  final _messageChangeController = StreamController<void>.broadcast();
  final Map<String, AgoraChatSession> _sessions = {};

  bool _initialized = false;
  String _signedInAgoraUsername = '';
  Future<void>? _initializeFuture;
  Future<void>? _signInFuture;

  @override
  Future<AgoraChatSession> sessionForConversation(String conversationId) async {
    final cached = _sessions[conversationId];
    if (cached != null) {
      AppLogger.info(
        'Reuse session for conversation=${AppLogger.shortId(conversationId)} '
        'user=${cached.agoraUsername} peer=${cached.peerAgoraUsername}',
        name: _logName,
      );
      await _ensureSignedIn(cached);
      return cached;
    }

    AppLogger.info(
      'Request session for conversation=${AppLogger.shortId(conversationId)}',
      name: _logName,
    );
    final row = await dataService.invokeFunction(
      function: _edgeFunction,
      body: {
        'action': 'get_agora_chat_session',
        'conversationId': conversationId,
      },
    );
    final sessionPayload = row['session'] is Map
        ? Map<String, dynamic>.from(row['session'] as Map)
        : row;
    final session = AgoraChatSession.fromJson(sessionPayload);
    if (session.agoraUsername.isEmpty || session.agoraToken.isEmpty) {
      throw AppException(
        AppFailure.configuration('Agora Chat session is not configured.'),
      );
    }
    if (conversationId.trim().isNotEmpty && session.peerAgoraUsername.isEmpty) {
      throw AppException(
        AppFailure.notFound('Không tìm thấy người nhận trong cuộc trò chuyện.'),
      );
    }
    _sessions[conversationId] = session;
    AppLogger.info(
      'Session ready conversation=${AppLogger.shortId(conversationId)} '
      'user=${session.agoraUsername} peer=${session.peerAgoraUsername} '
      'token=${session.agoraToken.isNotEmpty ? '<present>' : '<missing>'}',
      name: _logName,
    );
    await _ensureSignedIn(session);
    return session;
  }

  @override
  Future<List<agora.ChatMessage>> fetchTextMessages({
    required String conversationId,
    required int page,
    required int limit,
  }) async {
    AppLogger.info(
      'Fetch history conversation=${AppLogger.shortId(conversationId)} '
      'page=$page limit=$limit',
      name: _logName,
    );
    final session = await sessionForConversation(conversationId);
    final normalizedLimit = limit.clamp(1, 50).toInt();
    final result = await agora.ChatClient.getInstance.chatManager
        .fetchHistoryMessagesByOption(
          session.peerAgoraUsername,
          agora.ChatConversationType.Chat,
          options: const agora.FetchMessageOptions(
            msgTypes: [agora.MessageType.TXT, agora.MessageType.IMAGE],
            direction: agora.ChatSearchDirection.Up,
          ),
          pageSize: normalizedLimit,
        );
    AppLogger.info(
      'History loaded conversation=${AppLogger.shortId(conversationId)} '
      'peer=${session.peerAgoraUsername} count=${result.data.length} '
      'cursor=${result.cursor ?? '<none>'}',
      name: _logName,
    );
    return result.data;
  }

  @override
  Future<agora.ChatMessage> sendTextMessage({
    required String conversationId,
    required String body,
  }) async {
    AppLogger.info(
      'Send text conversation=${AppLogger.shortId(conversationId)} '
      'bodyLength=${body.trim().length}',
      name: _logName,
    );
    final session = await sessionForConversation(conversationId);
    final message = agora.ChatMessage.createTxtSendMessage(
      targetId: session.peerAgoraUsername,
      content: body,
    );
    message.attributes = {'supabase_conversation_id': conversationId};
    final sent = await agora.ChatClient.getInstance.chatManager.sendMessage(
      message,
    );
    AppLogger.info(
      'Text sent conversation=${AppLogger.shortId(conversationId)} '
      'msg=${AppLogger.shortId(sent.msgId)} to=${session.peerAgoraUsername}',
      name: _logName,
    );
    return sent;
  }

  @override
  Future<agora.ChatMessage> sendImageMessage({
    required String conversationId,
    required String imagePath,
    required String fileName,
  }) async {
    AppLogger.info(
      'Send image conversation=${AppLogger.shortId(conversationId)} '
      'file=$fileName',
      name: _logName,
    );
    final session = await sessionForConversation(conversationId);
    final message = agora.ChatMessage.createImageSendMessage(
      targetId: session.peerAgoraUsername,
      filePath: imagePath,
      displayName: fileName,
    );
    message.attributes = {'supabase_conversation_id': conversationId};
    final sent = await agora.ChatClient.getInstance.chatManager.sendMessage(
      message,
    );
    AppLogger.info(
      'Image sent conversation=${AppLogger.shortId(conversationId)} '
      'msg=${AppLogger.shortId(sent.msgId)} to=${session.peerAgoraUsername}',
      name: _logName,
    );
    return sent;
  }

  @override
  Future<agora.ChatMessage> prepareMessageForDisplay(
    agora.ChatMessage message,
  ) async {
    final body = message.body;
    if (body is! agora.ChatImageMessageBody) {
      return message;
    }

    final localPath = body.localPath.trim();
    final thumbnailPath = body.thumbnailLocalPath?.trim() ?? '';
    if (_fileExists(localPath) || _fileExists(thumbnailPath)) {
      return message;
    }

    final attachmentMessage = await _downloadImageAttachment(message);
    if (attachmentMessage != null) {
      return attachmentMessage;
    }

    final thumbnailMessage = await _downloadImageThumbnail(message);
    if (thumbnailMessage != null) {
      return thumbnailMessage;
    }

    AppLogger.warning(
      'Image message has no local file after download attempts '
      'msg=${AppLogger.shortId(message.msgId)} '
      'localPath=${localPath.isEmpty ? '<empty>' : localPath} '
      'thumbnailPath=${thumbnailPath.isEmpty ? '<empty>' : thumbnailPath}.',
      name: _logName,
    );
    return message;
  }

  Future<agora.ChatMessage?> _downloadImageAttachment(
    agora.ChatMessage message,
  ) async {
    try {
      await _withSdkTimeout(
        agora.ChatClient.getInstance.chatManager.downloadAttachment(message),
        operation: 'downloadAttachment',
      );
      return _reloadImageMessageWithFile(message.msgId, allowThumbnail: false);
    } catch (error, stackTrace) {
      AppLogger.warning(
        'Download image attachment failed msg=${AppLogger.shortId(message.msgId)}.',
        name: _logName,
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<agora.ChatMessage?> _downloadImageThumbnail(
    agora.ChatMessage message,
  ) async {
    try {
      await _withSdkTimeout(
        agora.ChatClient.getInstance.chatManager.downloadThumbnail(message),
        operation: 'downloadThumbnail',
      );
      return _reloadImageMessageWithFile(message.msgId, allowThumbnail: true);
    } catch (error, stackTrace) {
      AppLogger.warning(
        'Download image thumbnail failed msg=${AppLogger.shortId(message.msgId)}.',
        name: _logName,
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<agora.ChatMessage?> _reloadImageMessageWithFile(
    String messageId, {
    required bool allowThumbnail,
  }) async {
    for (var attempt = 0; attempt < 5; attempt++) {
      final updatedMessage = await agora.ChatClient.getInstance.chatManager
          .loadMessage(messageId);
      final updatedBody = updatedMessage?.body;
      if (updatedMessage != null && updatedBody is agora.ChatImageMessageBody) {
        final hasAttachment = _fileExists(updatedBody.localPath);
        final hasThumbnail =
            allowThumbnail && _fileExists(updatedBody.thumbnailLocalPath);
        if (hasAttachment || hasThumbnail) {
          AppLogger.info(
            'Image local file ready msg=${AppLogger.shortId(messageId)} '
            'attachment=$hasAttachment thumbnail=$hasThumbnail attempt=$attempt.',
            name: _logName,
          );
          return updatedMessage;
        }
      }
      await Future<void>.delayed(const Duration(milliseconds: 160));
    }
    return null;
  }

  @override
  Future<void> recallMessage(String messageId) async {
    final normalizedMessageId = messageId.trim();
    if (normalizedMessageId.isEmpty ||
        normalizedMessageId.startsWith('local_')) {
      return;
    }
    AppLogger.info(
      'Recall message msg=${AppLogger.shortId(normalizedMessageId)}',
      name: _logName,
    );
    await _withSdkTimeout(
      agora.ChatClient.getInstance.chatManager.recallMessage(
        normalizedMessageId,
      ),
      operation: 'recallMessage',
    );
  }

  @override
  Future<Map<String, List<agora.ChatMessageReaction>>> fetchReactions({
    required String conversationId,
    required List<String> messageIds,
  }) async {
    final normalizedIds = messageIds
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty && !item.startsWith('local_'))
        .toList(growable: false);
    if (normalizedIds.isEmpty) {
      return const {};
    }

    await sessionForConversation(conversationId);
    return _withSdkTimeout(
      agora.ChatClient.getInstance.chatManager.fetchReactionList(
        messageIds: normalizedIds,
        chatType: agora.ChatType.Chat,
      ),
      operation: 'fetchReactionList',
    );
  }

  @override
  Future<void> addReaction({
    required String conversationId,
    required String messageId,
    required String reaction,
  }) async {
    await sessionForConversation(conversationId);
    await _withSdkTimeout(
      agora.ChatClient.getInstance.chatManager.addReaction(
        messageId: messageId,
        reaction: reaction,
      ),
      operation: 'addReaction',
    );
  }

  @override
  Future<void> removeReaction({
    required String conversationId,
    required String messageId,
    required String reaction,
  }) async {
    await sessionForConversation(conversationId);
    await _withSdkTimeout(
      agora.ChatClient.getInstance.chatManager.removeReaction(
        messageId: messageId,
        reaction: reaction,
      ),
      operation: 'removeReaction',
    );
  }

  bool _fileExists(String? path) {
    final normalized = path?.trim() ?? '';
    return normalized.isNotEmpty && File(normalized).existsSync();
  }

  @override
  Future<void> notifyTextMessageSent({
    required String conversationId,
    required String body,
    required String agoraMessageId,
  }) {
    AppLogger.info(
      'Notify Supabase message event conversation=${AppLogger.shortId(conversationId)} '
      'msg=${AppLogger.shortId(agoraMessageId)} bodyLength=${body.length}',
      name: _logName,
    );
    return dataService.invokeFunction(
      function: _edgeFunction,
      body: {
        'action': 'notify_agora_chat_message',
        'conversationId': conversationId,
        'body': body,
        'agoraMessageId': agoraMessageId,
      },
    );
  }

  @override
  Future<void> markConversationRead(String conversationId) async {
    AppLogger.info(
      'Mark read conversation=${AppLogger.shortId(conversationId)}',
      name: _logName,
    );
    final session = await sessionForConversation(conversationId);
    await agora.ChatClient.getInstance.chatManager.sendConversationReadAck(
      session.peerAgoraUsername,
    );
  }

  @override
  Stream<agora.ChatMessage> watchMessages() => _messageController.stream;

  @override
  Stream<void> watchMessageChanges() => _messageChangeController.stream;

  Future<void> _ensureInitialized() async {
    if (_initialized) {
      return;
    }
    final pendingInitialize = _initializeFuture;
    if (pendingInitialize != null) {
      return pendingInitialize;
    }

    final future = _initializeSdk();
    _initializeFuture = future;
    try {
      await future;
    } finally {
      _initializeFuture = null;
    }
  }

  Future<void> _initializeSdk() async {
    final normalizedAppKey = appKey.trim();
    if (normalizedAppKey.isEmpty) {
      AppLogger.error('Missing AGORA_CHAT_APP_KEY.', name: _logName);
      throw AppException(
        AppFailure.configuration('AGORA_CHAT_APP_KEY is not configured.'),
      );
    }

    AppLogger.info(
      'Initialize Agora Chat SDK appKey=${AppLogger.shortId(normalizedAppKey)}',
      name: _logName,
    );
    try {
      await _withSdkTimeout(
        agora.ChatClient.getInstance.init(
          agora.ChatOptions(
            appKey: normalizedAppKey,
            autoLogin: false,
            requireAck: true,
            requireDeliveryAck: true,
          ),
        ),
        operation: 'init',
      );
      await _withSdkTimeout(
        agora.ChatClient.getInstance.startCallback(),
        operation: 'startCallback',
      );
      agora.ChatClient.getInstance.addConnectionEventHandler(
        _connectionHandlerId,
        agora.ConnectionEventHandler(
          onTokenWillExpire: () => unawaited(_renewToken()),
          onTokenDidExpire: () => unawaited(_renewToken()),
        ),
      );
      agora.ChatClient.getInstance.chatManager.addEventHandler(
        _messageHandlerId,
        agora.ChatEventHandler(
          onMessagesReceived: (messages) {
            AppLogger.info(
              'Received messages count=${messages.length}',
              name: _logName,
            );
            for (final message in messages) {
              AppLogger.info(
                'Received message msg=${AppLogger.shortId(message.msgId)} '
                'from=${message.from ?? '<unknown>'} to=${message.to ?? '<unknown>'} '
                'type=${message.body.type.name}',
                name: _logName,
              );
              _messageController.add(message);
              _messageChangeController.add(null);
            }
          },
          onMessagesDelivered: (messages) {
            AppLogger.info(
              'Messages delivered count=${messages.length}',
              name: _logName,
            );
            for (final message in messages) {
              _messageController.add(message);
              _messageChangeController.add(null);
            }
          },
          onMessagesRead: (messages) {
            AppLogger.info(
              'Messages read count=${messages.length}',
              name: _logName,
            );
            for (final message in messages) {
              _messageController.add(message);
              _messageChangeController.add(null);
            }
          },
          onMessagesRecalled: (messages) {
            AppLogger.info(
              'Messages recalled count=${messages.length}',
              name: _logName,
            );
            for (final message in messages) {
              _messageController.add(message);
              _messageChangeController.add(null);
            }
          },
          onMessageReactionDidChange: (events) {
            AppLogger.info(
              'Message reactions changed count=${events.length}',
              name: _logName,
            );
            for (final _ in events) {
              _messageChangeController.add(null);
            }
          },
        ),
      );
      _initialized = true;
      AppLogger.info('Agora Chat SDK initialized.', name: _logName);
    } catch (error, stackTrace) {
      _initialized = false;
      _signedInAgoraUsername = '';
      AppLogger.error(
        'Agora Chat SDK initialize failed.',
        name: _logName,
        error: error,
        stackTrace: stackTrace,
      );
      throw _failureFromSdkError(
        error,
        timeoutMessage:
            'Kết nối Agora Chat quá lâu. Vui lòng thử lại sau vài giây.',
        fallbackMessage: 'Không thể khởi tạo Agora Chat.',
      );
    }
  }

  Future<void> _ensureSignedIn(AgoraChatSession session) async {
    await _ensureInitialized();
    final pendingSignIn = _signInFuture;
    if (pendingSignIn != null) {
      await pendingSignIn;
    }

    final currentUserId = agora.ChatClient.getInstance.currentUserId ?? '';
    if (_signedInAgoraUsername == session.agoraUsername &&
        currentUserId == session.agoraUsername &&
        await _withSdkTimeout(
          agora.ChatClient.getInstance.isConnected(),
          operation: 'isConnected',
        )) {
      AppLogger.info(
        'Already connected user=${session.agoraUsername}',
        name: _logName,
      );
      return;
    }

    final future = _signIn(session);
    _signInFuture = future;
    try {
      await future;
    } finally {
      _signInFuture = null;
    }
  }

  Future<void> _signIn(AgoraChatSession session) async {
    AppLogger.info(
      'Login with token user=${session.agoraUsername}',
      name: _logName,
    );
    try {
      final currentUserId = agora.ChatClient.getInstance.currentUserId ?? '';
      if (currentUserId.isNotEmpty && currentUserId != session.agoraUsername) {
        await _withSdkTimeout(
          agora.ChatClient.getInstance.logout(false),
          operation: 'logout',
        );
        _signedInAgoraUsername = '';
      }
      await _withSdkTimeout(
        agora.ChatClient.getInstance.loginWithToken(
          session.agoraUsername,
          session.agoraToken,
        ),
        operation: 'loginWithToken',
      );
      _signedInAgoraUsername = session.agoraUsername;
      AppLogger.info(
        'Login success user=${session.agoraUsername}',
        name: _logName,
      );
    } catch (error, stackTrace) {
      if (_isAlreadyLoggedInError(error)) {
        _signedInAgoraUsername = session.agoraUsername;
        AppLogger.info(
          'Login skipped because SDK already has an active session '
          'user=${session.agoraUsername}.',
          name: _logName,
        );
        return;
      }
      _signedInAgoraUsername = '';
      AppLogger.error(
        'Agora Chat login failed user=${session.agoraUsername}.',
        name: _logName,
        error: error,
        stackTrace: stackTrace,
      );
      throw _failureFromSdkError(
        error,
        timeoutMessage:
            'Đăng nhập Agora Chat quá lâu. Vui lòng thử lại sau vài giây.',
        fallbackMessage: 'Không thể đăng nhập Agora Chat.',
      );
    }
  }

  bool _isAlreadyLoggedInError(Object error) {
    if (error is agora.ChatError) {
      return error.code == 200 &&
          error.description.toLowerCase().contains('already logged in');
    }
    final description = error.toString().toLowerCase();
    return description.contains('code: 200') &&
        description.contains('already logged in');
  }

  Future<void> _renewToken() async {
    AppLogger.info('Renew token requested.', name: _logName);
    final row = await dataService.invokeFunction(
      function: _edgeFunction,
      body: {'action': 'get_agora_chat_session'},
    );
    final sessionPayload = row['session'] is Map
        ? Map<String, dynamic>.from(row['session'] as Map)
        : row;
    final session = AgoraChatSession.fromJson(sessionPayload);
    if (session.agoraToken.isNotEmpty) {
      await _withSdkTimeout(
        agora.ChatClient.getInstance.renewAgoraToken(session.agoraToken),
        operation: 'renewAgoraToken',
      );
      AppLogger.info('Renew token success.', name: _logName);
    } else {
      AppLogger.warning('Renew token skipped: empty token.', name: _logName);
    }
  }

  Future<T> _withSdkTimeout<T>(Future<T> future, {required String operation}) {
    return future.timeout(
      _sdkTimeout,
      onTimeout: () {
        throw TimeoutException(
          'Agora Chat $operation timed out after ${_sdkTimeout.inSeconds}s.',
          _sdkTimeout,
        );
      },
    );
  }

  AppException _failureFromSdkError(
    Object error, {
    required String timeoutMessage,
    required String fallbackMessage,
  }) {
    if (error is AppException) {
      return error;
    }
    if (error is TimeoutException) {
      return AppException(
        AppFailure.network(timeoutMessage, details: error.toString()),
      );
    }
    return AppException(
      AppFailure.unknown(fallbackMessage, details: error.toString()),
    );
  }
}

class NoOpAgoraChatService implements AgoraChatService {
  const NoOpAgoraChatService();

  @override
  Future<List<agora.ChatMessage>> fetchTextMessages({
    required String conversationId,
    required int page,
    required int limit,
  }) async {
    return const [];
  }

  @override
  Future<void> markConversationRead(String conversationId) async {}

  @override
  Future<void> notifyTextMessageSent({
    required String conversationId,
    required String body,
    required String agoraMessageId,
  }) async {}

  @override
  Future<agora.ChatMessage> prepareMessageForDisplay(
    agora.ChatMessage message,
  ) async {
    return message;
  }

  @override
  Future<agora.ChatMessage> sendTextMessage({
    required String conversationId,
    required String body,
  }) {
    throw AppException(
      AppFailure.configuration('Agora Chat is not configured.'),
    );
  }

  @override
  Future<agora.ChatMessage> sendImageMessage({
    required String conversationId,
    required String imagePath,
    required String fileName,
  }) {
    throw AppException(
      AppFailure.configuration('Agora Chat is not configured.'),
    );
  }

  @override
  Future<void> recallMessage(String messageId) async {}

  @override
  Future<Map<String, List<agora.ChatMessageReaction>>> fetchReactions({
    required String conversationId,
    required List<String> messageIds,
  }) async {
    return const {};
  }

  @override
  Future<void> addReaction({
    required String conversationId,
    required String messageId,
    required String reaction,
  }) async {}

  @override
  Future<void> removeReaction({
    required String conversationId,
    required String messageId,
    required String reaction,
  }) async {}

  @override
  Future<AgoraChatSession> sessionForConversation(String conversationId) {
    throw AppException(
      AppFailure.configuration('Agora Chat is not configured.'),
    );
  }

  @override
  Stream<agora.ChatMessage> watchMessages() => const Stream.empty();

  @override
  Stream<void> watchMessageChanges() => const Stream.empty();
}
