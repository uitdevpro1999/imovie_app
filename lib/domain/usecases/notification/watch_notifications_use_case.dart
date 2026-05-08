import 'package:imovie_app/domain/repositories/notification_repository.dart';

class WatchNotificationsUseCase {
  const WatchNotificationsUseCase(this.repository);

  final NotificationRepository repository;

  Stream<void> call() => repository.watchNotifications();
}
