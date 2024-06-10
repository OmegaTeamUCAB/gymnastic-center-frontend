part of 'auth_bloc.dart';

class AuthState {}

class Authenticated extends AuthState {
  final User user;

  Authenticated(this.user);
}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}

class CodeRequestedSuccess extends AuthState {}

class CodeVerifiedSuccess extends AuthState {}

class PasswordResetSuccess extends AuthState {}
