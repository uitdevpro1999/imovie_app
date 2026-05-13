import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/call/call_session.dart';
import 'package:imovie_app/domain/repositories/call_repository.dart';

class StartCallParams {
  const StartCallParams({required this.conversationId, required this.type});

  final String conversationId;
  final CallType type;
}

class StartCallUseCase implements UseCase<CallSession, StartCallParams> {
  const StartCallUseCase(this.repository);

  final CallRepository repository;

  @override
  Future<Result<CallSession>> call(StartCallParams params) {
    return repository.startCall(
      conversationId: params.conversationId,
      type: params.type,
    );
  }
}
