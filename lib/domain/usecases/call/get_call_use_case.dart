import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/call/call_session.dart';
import 'package:imovie_app/domain/repositories/call_repository.dart';

class GetCallParams {
  const GetCallParams({required this.callId});

  final String callId;
}

class GetCallUseCase implements UseCase<CallSession, GetCallParams> {
  const GetCallUseCase(this.repository);

  final CallRepository repository;

  @override
  Future<Result<CallSession>> call(GetCallParams params) {
    return repository.getCall(params.callId);
  }
}
