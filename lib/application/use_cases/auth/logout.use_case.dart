import 'package:gymnastic_center/application/repositories/auth/auth_repository.dart';
import 'package:gymnastic_center/core/exception.dart';
import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';

class LogoutUseCase extends IUseCase<void, bool> {
  final IAuthRepository _authRepository;
  LogoutUseCase(
    this._authRepository,
  );

  @override
  Future<Result<bool>> execute(void dto) async {
    try {
      _authRepository.logout();
      return Result.success<bool>(true);
    } catch (e) {
      return Result.failure<bool>(const UnknownException());
    }
  }
}
