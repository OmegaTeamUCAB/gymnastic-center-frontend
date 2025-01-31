import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/application/repositories/auth/auth_repository.dart';

class ResetPasswordDto {
  final String email;
  final String code;
  final String newPassword;

  ResetPasswordDto(
      {required this.email, required this.code, required this.newPassword});
}

class ResetPasswordUseCase
    extends IUseCase<ResetPasswordDto, IPasswordResetResponse> {
  final IAuthRepository _authRepository;

  ResetPasswordUseCase(
    this._authRepository,
  );

  @override
  Future<Result<IPasswordResetResponse>> execute(ResetPasswordDto dto) async {
    final result = await _authRepository.resetPassword(
      email: dto.email,
      newPassword: dto.newPassword,
      code: dto.code,
    );
    if (result.isSuccessful) {
      return Result.success(result.unwrap());
    }
    return Result.failure(result.error);
  }
}
