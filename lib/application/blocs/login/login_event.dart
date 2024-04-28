part of 'login_bloc.dart';

sealed class LoginFormEvent {
  const LoginFormEvent();
}

class EmailChanged extends LoginFormEvent {
  final String email;
  const EmailChanged(this.email);
}

class PasswordChanged extends LoginFormEvent {
  final String password;
  const PasswordChanged(this.password);
}

class FormSubmitted extends LoginFormEvent {
  final String email;
  final String password;
  const FormSubmitted(this.email, this.password);
}
