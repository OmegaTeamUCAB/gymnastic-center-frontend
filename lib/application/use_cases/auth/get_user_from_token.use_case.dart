import 'package:gymnastic_center/application/services/data-sources/local_data_source.dart';
import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/application/repositories/auth/auth_repository.dart';
import 'package:gymnastic_center/domain/auth/user.dart';

class GetUserFromTokenUseCase extends IUseCase<void, User> {
  final IAuthRepository _authRepository;
  final LocalDataSource _localDataSource;

  GetUserFromTokenUseCase(
    this._authRepository,
    this._localDataSource,
  );

  @override
  Future<Result<User>> execute(void dto) async {
    final result = await _authRepository.verifyUser();
    if (result.isSuccessful) {
      _localDataSource.setKeyValue('token', result.unwrap().token);
      return Result.success(result.unwrap().user);
    }
    return Result.failure(result.error);
  }
}
