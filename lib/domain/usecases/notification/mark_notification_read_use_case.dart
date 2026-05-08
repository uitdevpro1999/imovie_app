import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/repositories/notification_repository.dart';

class MarkNotificationReadParams {
  const MarkNotificationReadParams({required this.notificationId});

  final String notificationId;
}

class MarkNotificationReadUseCase
    implements UseCase<void, MarkNotificationReadParams> {
  const MarkNotificationReadUseCase(this.repository);

  final NotificationRepository repository;

  @override
  Future<Result<void>> call(MarkNotificationReadParams params) {
    return repository.markNotificationRead(params.notificationId);
  }
}
