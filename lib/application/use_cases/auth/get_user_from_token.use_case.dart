import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/application/repositories/auth/auth_repository.dart';
import 'package:gymnastic_center/domain/auth/user.dart';

class GetUserFromTokenUseCase extends IUseCase<void, User> {
  final IAuthRepository _authRepository;

  GetUserFromTokenUseCase(
    this._authRepository,
  );

  @override
  Future<Result<User>> execute(void dto) async {
    final result = await _authRepository.verifyUser();
    if (result.isSuccessful) {
      return Result.success(result.unwrap());
    }
    return Result.failure(result.error);
  }
}
