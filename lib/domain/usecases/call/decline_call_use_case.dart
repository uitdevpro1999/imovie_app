import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/repositories/call_repository.dart';

class DeclineCallParams {
  const DeclineCallParams({required this.callId});

  final String callId;
}

class DeclineCallUseCase implements UseCase<void, DeclineCallParams> {
  const DeclineCallUseCase(this.repository);

  final CallRepository repository;

  @override
  Future<Result<void>> call(DeclineCallParams params) {
    return repository.declineCall(params.callId);
  }
}
