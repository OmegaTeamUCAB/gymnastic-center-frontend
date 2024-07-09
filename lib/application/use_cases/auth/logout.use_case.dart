import 'package:gymnastic_center/application/repositories/auth/auth_repository.dart';
import 'package:gymnastic_center/application/repositories/notifications/notification_repository.dart';
import 'package:gymnastic_center/core/exception.dart';
import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';

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
      _authRepository.logout();
      final removeTokenResult = await _notificationRepository.removeToken();
      if (!removeTokenResult.isSuccessful) {
        print('Error al eliminar el token');
        return Result.failure(removeTokenResult.error);
      }
      return Result.success<bool>(true);
    } catch (e) {
      return Result.failure<bool>(const UnknownException());
    }
  }
}
