import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/application/repositories/auth/auth_repository.dart';

class VerifyCodeDto {
  final String email;
  final String code;

  VerifyCodeDto({required this.email, required this.code});
}

class VerifyCodeUseCase
    extends IUseCase<VerifyCodeDto, IPasswordResetResponse> {
  final IAuthRepository _authRepository;

  VerifyCodeUseCase(
    this._authRepository,
  );

  @override
  Future<Result<IPasswordResetResponse>> execute(VerifyCodeDto dto) async {
    final result = await _authRepository.verifyCode(
      email: dto.email,
      code: dto.code,
    );
    if (result.isSuccessful) {
      return Result.success(result.unwrap());
    }
    return Result.failure(result.error);
  }
}
