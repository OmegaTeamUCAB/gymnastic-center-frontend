part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
}

class SignedIn extends AuthEvent {
  const SignedIn();
}

class SignedOut extends AuthEvent {
  const SignedOut();
}

class VerifiedUser extends AuthEvent {
  const VerifiedUser();
}
