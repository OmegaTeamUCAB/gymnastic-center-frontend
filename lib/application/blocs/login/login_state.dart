part of 'login_bloc.dart';

class LoginFormState extends Equatable {
  final String email;
  final String password;

  const LoginFormState({this.email = '', this.password = ''});

  LoginFormState copyWith({
    String? email,
    String? password,
  }) =>
      LoginFormState(
        email: email ?? this.email,
        password: password ?? this.password,
      );

  @override
  List<Object> get props => [email, password];
}
