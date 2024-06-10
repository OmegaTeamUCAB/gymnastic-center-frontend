import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/domain/auth/user.dart';

abstract class ILoginResponse {
  final String token;
  final User user;

  ILoginResponse({required this.token, required this.user});
}

abstract class IVerifyUserResponse {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String image;
  final String email;

  IVerifyUserResponse(
      {required this.id,
      required this.fullName,
      required this.email,
      required this.phoneNumber,
      required this.image});
}

abstract class IPasswordResetResponse {
  final bool success;

  IPasswordResetResponse({required this.success});
}

abstract class IAuthRepository {
  Future<Result<ILoginResponse>> login(
      {required String email, required String password});
  Future<Result<void>> signUp({
    required String email,
    required String fullName,
    required String phoneNumber,
    required String password,
  });
  Future<Result<User>> verifyUser();
  Future<Result<IPasswordResetResponse>> requestCode({required String email});
  Future<Result<IPasswordResetResponse>> verifyCode(
      {required String email, required String code});
  Future<Result<IPasswordResetResponse>> resetPassword(
      {required String email, required String newPassword});
  void logout();
}
