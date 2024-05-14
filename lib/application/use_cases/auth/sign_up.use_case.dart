import 'package:gymnastic_center/application/services/datasources/local_datasource.dart';
import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/application/repositories/auth/auth_repository.dart';
import 'package:gymnastic_center/domain/auth/user.dart';

class SignUpDto {
  final String email;
  final String password;
  final String fullName;
  final String phoneNumber;

  SignUpDto({required this.email, required this.password, required this.fullName, required this.phoneNumber});
}

class SignUpUseCase extends IUseCase<SignUpDto, User> {
  final IAuthRepository _authRepository;
  final LocalDatasource _localDatasource;

  SignUpUseCase(
    this._authRepository,
    this._localDatasource,
  );

  @override
  Future<Result<User>> execute(SignUpDto dto) async {
    final result = await _authRepository.signUp(
      email: dto.email,
      password: dto.password,
      fullName: dto.fullName,
      phoneNumber: dto.phoneNumber,
    );
    if (result.isSuccessful) {
      _localDatasource.setKeyValue('token', result.unwrap().token);
      return Result.success(result.unwrap().user);
    }
    return Result.failure(result.error);
  }
}
