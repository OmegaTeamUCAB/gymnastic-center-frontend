import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/application/repositories/auth/auth_repository.dart';

class RequestCodeDto {
  final String email;

  RequestCodeDto({required this.email});
}

class RequestCodeUseCase
    extends IUseCase<RequestCodeDto, IPasswordResetResponse> {
  final IAuthRepository _authRepository;

  RequestCodeUseCase(
    this._authRepository,
  );

  @override
  Future<Result<IPasswordResetResponse>> execute(RequestCodeDto dto) async {
    final result = await _authRepository.requestCode(
      email: dto.email,
    );
    if (result.isSuccessful) {
      return Result.success(result.unwrap());
    }
    return Result.failure(result.error);
  }
}
