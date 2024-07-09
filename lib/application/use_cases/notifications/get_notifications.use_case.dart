import 'package:gymnastic_center/application/repositories/notifications/notification_repository.dart';
import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';

class GetNotificationsDto {
  GetNotificationsDto();
}

class GetNotificationsUseCase extends IUseCase<GetNotificationsDto, dynamic> {
  final INotificationRepository notificationRepository;

  GetNotificationsUseCase(this.notificationRepository);

  @override
  Future<Result<List<BrandNotification>>> execute(
      GetNotificationsDto dto) async {
    return await notificationRepository.getNotifications();
  }
}
