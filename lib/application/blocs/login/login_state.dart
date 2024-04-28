part of 'login_bloc.dart';

enum FormStatus { invalid, valid, validating, posting }

class LoginFormState extends Equatable {
  final FormStatus formStatus;
  final String email;
  final String password;

  const LoginFormState(
      {this.formStatus = FormStatus.invalid,
      this.email = '',
      this.password = ''});

  LoginFormState copyWith({
    FormStatus? formStatus,
    String? email,
    String? password,
  }) =>
      LoginFormState(
        formStatus: formStatus ?? this.formStatus,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  @override
  List<Object> get props => [formStatus, email, password];
}
