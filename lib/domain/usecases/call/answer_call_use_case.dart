import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/call/call_session.dart';
import 'package:imovie_app/domain/repositories/call_repository.dart';

class AnswerCallParams {
  const AnswerCallParams({required this.callId});

  final String callId;
}

class AnswerCallUseCase implements UseCase<CallSession, AnswerCallParams> {
  const AnswerCallUseCase(this.repository);

  final CallRepository repository;

  @override
  Future<Result<CallSession>> call(AnswerCallParams params) {
    return repository.answerCall(params.callId);
  }
}
