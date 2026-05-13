import 'package:imovie_app/domain/repositories/call_repository.dart';
import 'package:imovie_app/domain/entities/call/call_session.dart';

class WatchCallUseCase {
  const WatchCallUseCase(this.repository);

  final CallRepository repository;

  Stream<CallStatus> call(String callId) => repository.watchCallStatus(callId);
}
