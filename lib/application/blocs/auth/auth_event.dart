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
