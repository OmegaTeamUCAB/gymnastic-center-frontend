import 'package:gymnastic_center/application/repositories/notifications/notification_repository.dart';
import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';

class DeleteNotificationsDto {
  DeleteNotificationsDto();
}

class DeleteNotificationsUseCase
    extends IUseCase<DeleteNotificationsDto, dynamic> {
  final INotificationRepository notificationRepository;

  DeleteNotificationsUseCase(this.notificationRepository);

  @override
  Future<Result<void>> execute(DeleteNotificationsDto dto) async {
    return await notificationRepository.deleteNotifications();
  }
}
