import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/repositories/notification_repository.dart';

class MarkAllNotificationsReadUseCase implements UseCase<void, NoParams> {
  const MarkAllNotificationsReadUseCase(this.repository);

  final NotificationRepository repository;

  @override
  Future<Result<void>> call(NoParams params) {
    return repository.markAllNotificationsRead();
  }
}
