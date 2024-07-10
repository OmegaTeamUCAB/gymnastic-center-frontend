import 'package:gymnastic_center/application/repositories/auth/auth_repository.dart';
import 'package:gymnastic_center/application/repositories/notifications/notification_repository.dart';
import 'package:gymnastic_center/core/exception.dart';
import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/infrastructure/services/notifications/notification_handler.dart';

class LogoutUseCase extends IUseCase<void, bool> {
  final IAuthRepository _authRepository;
  final INotificationRepository _notificationRepository;

  LogoutUseCase(
    this._authRepository,
    this._notificationRepository,
  );

  @override
  Future<Result<bool>> execute(void dto) async {
    try {
      final token = await NotificationHandler().token;
      if (token == null) {
        return Result.success<bool>(true);
      } else {
        final removeTokenResult =
            await _notificationRepository.removeToken(token);
        if (removeTokenResult.isError) {
          print('Error al eliminar el token');
          return Result.failure(removeTokenResult.error);
        }
        _authRepository.logout();
      }
      return Result.success<bool>(true);
    } catch (e) {
      return Result.failure<bool>(const UnknownException());
    }
  }
}
