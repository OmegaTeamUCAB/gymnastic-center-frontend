import 'package:gymnastic_center/application/services/datasources/local_datasource.dart';
import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/application/repositories/auth/auth_repository.dart';
import 'package:gymnastic_center/domain/auth/user.dart';

class GetUserFromTokenUseCase extends IUseCase<void, User> {
  final IAuthRepository _authRepository;
  final LocalDatasource _localDatasource;

  GetUserFromTokenUseCase(
    this._authRepository,
    this._localDatasource,
  );

  @override
  Future<Result<User>> execute(void dto) async {
    final result = await _authRepository.verifyUser();
    if (result.isSuccessful) {
      _localDatasource.setKeyValue('token', result.unwrap().token);
      return Result.success(result.unwrap().user);
    }
    return Result.failure(result.error);
  }
}
