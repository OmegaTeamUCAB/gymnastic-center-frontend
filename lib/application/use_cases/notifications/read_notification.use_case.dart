import 'package:gymnastic_center/application/repositories/notifications/notification_repository.dart';
import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';

class ReadNotificationsDto {
  final String id;
  ReadNotificationsDto(this.id);
}

class ReadNotificationUseCase extends IUseCase<ReadNotificationsDto, dynamic> {
  final INotificationRepository notificationRepository;

  ReadNotificationUseCase(this.notificationRepository);

  @override
  Future<Result<void>> execute(ReadNotificationsDto dto) async {
    return await notificationRepository.markAsRead(dto.id);
  }
}
