import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/repositories/notification_repository.dart';

class GetUnreadNotificationCountUseCase implements UseCase<int, NoParams> {
  const GetUnreadNotificationCountUseCase(this.repository);

  final NotificationRepository repository;

  @override
  Future<Result<int>> call(NoParams params) {
    return repository.getUnreadCount();
  }
}
