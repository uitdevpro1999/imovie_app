import 'package:imovie_app/config/flavors/app_bootstrap.dart';
import 'package:imovie_app/core/error/app_exception.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/data/datasources/call/call_remote_data_source.dart';
import 'package:imovie_app/domain/entities/call/call_session.dart';
import 'package:imovie_app/domain/repositories/call_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CallRepositoryImpl implements CallRepository {
  const CallRepositoryImpl({
    required this.bootstrap,
    required this.remoteDataSource,
  });

  final AppBootstrap bootstrap;
  final CallRemoteDataSource remoteDataSource;

  @override
  Future<Result<CallSession>> startCall({
    required String conversationId,
    required CallType type,
  }) {
    return _run(
      request: () async {
        final response = await remoteDataSource.startCall(
          conversationId: conversationId,
          type: type,
        );
        return response.toEntity();
      },
      authMessage: 'Unable to start this call.',
      unknownMessage: 'Unexpected error while starting this call.',
    );
  }

  @override
  Future<Result<CallSession>> answerCall(String callId) {
    return _run(
      request: () async {
        final response = await remoteDataSource.answerCall(callId);
        return response.toEntity();
      },
      authMessage: 'Unable to answer this call.',
      unknownMessage: 'Unexpected error while answering this call.',
    );
  }

  @override
  Future<Result<void>> declineCall(String callId) {
    return _run(
      request: () => remoteDataSource.declineCall(callId),
      authMessage: 'Unable to decline this call.',
      unknownMessage: 'Unexpected error while declining this call.',
    );
  }

  @override
  Future<Result<void>> endCall(String callId) {
    return _run(
      request: () => remoteDataSource.endCall(callId),
      authMessage: 'Unable to end this call.',
      unknownMessage: 'Unexpected error while ending this call.',
    );
  }

  @override
  Future<Result<CallSession>> getCall(String callId) {
    return _run(
      request: () async {
        final response = await remoteDataSource.getCall(callId);
        return response.toEntity();
      },
      authMessage: 'Unable to load this call.',
      unknownMessage: 'Unexpected error while loading this call.',
    );
  }

  @override
  Stream<CallStatus> watchCallStatus(String callId) {
    if (!bootstrap.isSupabaseReady) {
      return const Stream<CallStatus>.empty();
    }
    return remoteDataSource.watchCallStatus(callId);
  }

  Future<Result<T>> _run<T>({
    required Future<T> Function() request,
    required String authMessage,
    required String unknownMessage,
  }) async {
    if (!bootstrap.isSupabaseReady) {
      return FailureResult(
        AppFailure.configuration('Supabase is not configured for calls.'),
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
