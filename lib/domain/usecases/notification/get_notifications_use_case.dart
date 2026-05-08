import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/entities/notification/community_notification.dart';
import 'package:imovie_app/domain/repositories/notification_repository.dart';

class GetNotificationsParams {
  const GetNotificationsParams({required this.page, required this.limit});

  final int page;
  final int limit;
}

class GetNotificationsUseCase
    implements UseCase<List<CommunityNotification>, GetNotificationsParams> {
  const GetNotificationsUseCase(this.repository);

  final NotificationRepository repository;

  @override
  Future<Result<List<CommunityNotification>>> call(
    GetNotificationsParams params,
  ) {
    return repository.getNotifications(page: params.page, limit: params.limit);
  }
}
