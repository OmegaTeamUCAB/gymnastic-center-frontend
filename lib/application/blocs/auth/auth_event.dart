part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
}

class SignedUp extends AuthEvent {
  final String email;
  final String fullName;
  final String password;
  final String phoneNumber;

  const SignedUp(
      {required this.email,
      required this.fullName,
      required this.password,
      required this.phoneNumber});
}

class LoggedIn extends AuthEvent {
  final String email;
  final String password;
  const LoggedIn({required this.email, required this.password});
}

class SignedOut extends AuthEvent {
  const SignedOut();
}

class VerifiedUser extends AuthEvent {
  const VerifiedUser();
}

class CodeRequested extends AuthEvent {
  final String email;

  const CodeRequested({required this.email});
}

class CodeVerified extends AuthEvent {
  final String email;
  final String code;

  const CodeVerified({required this.email, required this.code});
}

class PasswordReset extends AuthEvent {
  final String email;
  final String code;
  final String newPassword;

  const PasswordReset(
      {required this.email, required this.newPassword, required this.code});
}
