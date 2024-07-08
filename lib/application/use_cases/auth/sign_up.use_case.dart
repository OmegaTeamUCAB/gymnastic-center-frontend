import 'package:gymnastic_center/application/repositories/notifications/notification_repository.dart';
import 'package:gymnastic_center/application/services/data-sources/local_data_source.dart';
import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/application/repositories/auth/auth_repository.dart';
import 'package:gymnastic_center/domain/auth/user.dart';

class SignUpDto {
  final String email;
  final String password;
  final String fullName;
  final String phoneNumber;

  SignUpDto(
      {required this.email,
      required this.password,
      required this.fullName,
      required this.phoneNumber});
}

class SignUpUseCase extends IUseCase<SignUpDto, User> {
  final IAuthRepository _authRepository;
  final INotificationRepository _notificationRepository;
  final LocalDataSource _localDataSource;

  SignUpUseCase(
    this._authRepository,
    this._notificationRepository,
    this._localDataSource,
  );

  @override
  Future<Result<User>> execute(SignUpDto dto) async {
    final signUpResult = await _authRepository.signUp(
      email: dto.email,
      password: dto.password,
      fullName: dto.fullName,
      phoneNumber: dto.phoneNumber,
    );
    if (signUpResult.isError) {
      return Result.failure(signUpResult.error);
    }
    final result = await _authRepository.login(
      email: dto.email,
      password: dto.password,
    );
    if (result.isSuccessful) {
      final saveTokenResult = await _notificationRepository.saveToken();
      if (!saveTokenResult.isSuccessful) {
        print('Error al guardar token');
        return Result.failure(saveTokenResult.error);
      }
      _localDataSource.setKeyValue('token', result.unwrap().token);
      return Result.success(result.unwrap().user);
    }
    return Result.failure(result.error);
  }
}
