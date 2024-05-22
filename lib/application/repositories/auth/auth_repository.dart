import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/domain/auth/user.dart';

abstract class IAuthResponse {
  final String token;
  final User user;

  IAuthResponse({required this.token, required this.user});
}

abstract class IPasswordResetResponse {
  final bool success;

  IPasswordResetResponse({required this.success});
}

abstract class IAuthRepository {
  Future<Result<IAuthResponse>> login(
      {required String email, required String password});
  Future<Result<IAuthResponse>> signUp({
    required String email,
    required String fullName,
    required String phoneNumber,
    required String password,
  });
  Future<Result<IAuthResponse>> verifyUser();
  Future<Result<IPasswordResetResponse>> requestCode({required String email});
  Future<Result<IPasswordResetResponse>> verifyCode(
      {required String email, required String code});
  Future<Result<IPasswordResetResponse>> resetPassword(
      {required String email, required String newPassword});
}
