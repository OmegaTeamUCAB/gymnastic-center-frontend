part of 'sign_up_bloc.dart';

sealed class SignUpEvent {
  const SignUpEvent();
}

class NameChanged extends SignUpEvent {
  final String name;
  const NameChanged(this.name);
}

class EmailChanged extends SignUpEvent {
  final String email;
  const EmailChanged(this.email);
}

class PhoneChanged extends SignUpEvent {
  final String phone;
  const PhoneChanged(this.phone);
}

class PasswordChanged extends SignUpEvent {
  final String password;
  const PasswordChanged(this.password);
}

class FormSubmitted extends SignUpEvent {
  final String name;
  final String email;
  final String phone;
  final String password;
  const FormSubmitted(this.email, this.password, this.name, this.phone);
}
