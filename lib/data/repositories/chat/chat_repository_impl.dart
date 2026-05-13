import 'package:imovie_app/config/flavors/app_bootstrap.dart';
import 'package:imovie_app/core/error/app_exception.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/data/datasources/chat/chat_remote_data_source.dart';
import 'package:imovie_app/domain/entities/chat/chat_conversation.dart';
import 'package:imovie_app/domain/entities/chat/chat_message.dart';
import 'package:imovie_app/domain/repositories/chat_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatRepositoryImpl implements ChatRepository {
  const ChatRepositoryImpl({
    required this.bootstrap,
    required this.remoteDataSource,
  });

  final AppBootstrap bootstrap;
  final ChatRemoteDataSource remoteDataSource;

  @override
  Future<Result<List<ChatConversation>>> getConversations({
    required int page,
    required int limit,
  }) {
    return _run(
      request: () async {
        final response = await remoteDataSource.getConversations(
          page: page,
          limit: limit,
        );
        return response.map((item) => item.toEntity()).toList(growable: false);
      },
      authMessage: 'Unable to load conversations.',
      unknownMessage: 'Unexpected error while loading conversations.',
    );
  }

  @override
  Future<Result<ChatConversation>> getOrCreateDirectConversation({
    required String userId,
  }) {
    return _run(
      request: () async {
        final response = await remoteDataSource.getOrCreateDirectConversation(
          userId: userId,
        );
        return response.toEntity();
      },
      authMessage: 'Unable to open this conversation.',
      unknownMessage: 'Unexpected error while opening this conversation.',
    );
  }

  @override
  Future<Result<List<ChatMessage>>> getMessages({
    required String conversationId,
    required int page,
    required int limit,
  }) {
    return _run(
      request: () async {
        final response = await remoteDataSource.getMessages(
          conversationId: conversationId,
          page: page,
          limit: limit,
        );
        return response
            .map((item) => item.toEntity())
            .toList(growable: false)
            .reversed
            .toList(growable: false);
      },
      authMessage: 'Unable to load messages.',
      unknownMessage: 'Unexpected error while loading messages.',
    );
  }

  @override
  Future<Result<ChatMessage>> sendTextMessage({
    required String conversationId,
    required String body,
  }) {
    return _run(
      request: () async {
        final response = await remoteDataSource.sendTextMessage(
          conversationId: conversationId,
          body: body,
        );
        return response.toEntity();
      },
      authMessage: 'Unable to send this message.',
      unknownMessage: 'Unexpected error while sending this message.',
    );
  }

  @override
  Future<Result<ChatMessage>> sendImageMessage({
    required String conversationId,
    required String imagePath,
    required String fileName,
  }) {
    return _run(
      request: () async {
        final response = await remoteDataSource.sendImageMessage(
          conversationId: conversationId,
          imagePath: imagePath,
          fileName: fileName,
        );
        return response.toEntity();
      },
      authMessage: 'Unable to send this image.',
      unknownMessage: 'Unexpected error while sending this image.',
    );
  }

  @override
  Future<Result<void>> recallMessage(String messageId) {
    return _run(
      request: () => remoteDataSource.recallMessage(messageId),
      authMessage: 'Unable to recall this message.',
      unknownMessage: 'Unexpected error while recalling this message.',
    );
  }

  @override
  Future<Result<void>> toggleReaction({
    required String conversationId,
    required String messageId,
    required String reaction,
    required bool reactedByMe,
  }) {
    return _run(
      request: () => remoteDataSource.toggleReaction(
        conversationId: conversationId,
        messageId: messageId,
        reaction: reaction,
        reactedByMe: reactedByMe,
      ),
      authMessage: 'Unable to update this reaction.',
      unknownMessage: 'Unexpected error while updating this reaction.',
    );
  }

  @override
  Future<Result<void>> markConversationRead(String conversationId) {
    return _run(
      request: () => remoteDataSource.markConversationRead(conversationId),
      authMessage: 'Unable to mark this conversation as read.',
      unknownMessage: 'Unexpected error while marking conversation as read.',
    );
  }

  @override
  Stream<void> watchConversations() {
    if (!bootstrap.isSupabaseReady) {
      return const Stream<void>.empty();
    }
    return remoteDataSource.watchConversations();
  }

  @override
  Stream<void> watchMessages(String conversationId) {
    if (!bootstrap.isSupabaseReady) {
      return const Stream<void>.empty();
    }
    return remoteDataSource.watchMessages(conversationId);
  }

  Future<Result<T>> _run<T>({
    required Future<T> Function() request,
    required String authMessage,
    required String unknownMessage,
  }) async {
    if (!bootstrap.isSupabaseReady) {
      return FailureResult(
        AppFailure.configuration('Supabase is not configured for chat.'),
      );
    }

    try {
      return Success(await request());
    } on AppException catch (error) {
      return FailureResult(_mapFailure(error.failure, authMessage));
    } on AuthException catch (error) {
      return FailureResult(
        AppFailure.unauthorized(
          error.message.trim().isEmpty ? authMessage : error.message,
        ),
      );
    } catch (error) {
      return FailureResult(
        AppFailure.unknown(unknownMessage, details: error.toString()),
      );
    }
  }

  AppFailure _mapFailure(AppFailure failure, String fallbackMessage) {
    if (failure.message.trim().isNotEmpty) {
      return failure;
    }
    return AppFailure(
      type: failure.type,
      message: fallbackMessage,
      details: failure.details,
    );
  }
}
