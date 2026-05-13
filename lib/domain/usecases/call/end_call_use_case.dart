import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/repositories/call_repository.dart';

class EndCallParams {
  const EndCallParams({required this.callId});

  final String callId;
}

class EndCallUseCase implements UseCase<void, EndCallParams> {
  const EndCallUseCase(this.repository);

  final CallRepository repository;

  @override
  Future<Result<void>> call(EndCallParams params) {
    return repository.endCall(params.callId);
  }
}
