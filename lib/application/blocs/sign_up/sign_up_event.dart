part of 'sign_up_bloc.dart';

sealed class SignUpEvent {
  const SignUpEvent();
}

class FullNameChanged extends SignUpEvent {
  final String name;
  const FullNameChanged(this.name);
}

class EmailChanged extends SignUpEvent {
  final String email;
  const EmailChanged(this.email);
}

class PhoneNumberChanged extends SignUpEvent {
  final String phoneNumber;
  const PhoneNumberChanged(this.phoneNumber);
}

class PasswordChanged extends SignUpEvent {
  final String password;
  const PasswordChanged(this.password);
}

class FormSubmitted extends SignUpEvent {
  const FormSubmitted();
}
