import 'package:gymnastic_center/application/services/data-sources/local_data_source.dart';
import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/application/repositories/auth/auth_repository.dart';
import 'package:gymnastic_center/domain/auth/user.dart';
import 'package:gymnastic_center/application/repositories/notifications/notification_repository.dart';
import 'package:gymnastic_center/infrastructure/services/notifications/notification_handler.dart';

class LoginDto {
  final String email;
  final String password;

  LoginDto({required this.email, required this.password});
}

class LoginUseCase extends IUseCase<LoginDto, User> {
  final IAuthRepository _authRepository;
  final INotificationRepository _notificationRepository;
  final LocalDataSource _localDataSource;

  LoginUseCase(
    this._authRepository,
    this._notificationRepository,
    this._localDataSource,
  );

  @override
  Future<Result<User>> execute(LoginDto dto) async {
    final result = await _authRepository.login(
      email: dto.email,
      password: dto.password,
    );
    if (result.isSuccessful) {
      _localDataSource.setKeyValue('token', result.unwrap().token);
      final token = await NotificationHandler().token;
      if (token != null) {
        final saveTokenResult = await _notificationRepository.saveToken(token);
        if (saveTokenResult.isError) {
          print('Error al guardar token');
          // Because Alfa sucks balls
          // return Result.failure(saveTokenResult.error);
        }
        return Result.success(result.unwrap().user);
      } else {
        print('Token is null');
      }
    }
    return Result.failure(result.error);
  }
}
