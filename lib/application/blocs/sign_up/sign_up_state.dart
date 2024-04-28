part of 'sign_up_bloc.dart';

enum FormStatus { invalid, valid, validating, posting }

class SignUpFormState extends Equatable {
  final FormStatus formStatus;
  final String name;
  final String email;
  final String phone;
  final String password;

  const SignUpFormState(
      {this.formStatus = FormStatus.invalid,
      this.name = '',
      this.email = '',
      this.phone = '',
      this.password = ''});

  SignUpFormState copyWith({
    FormStatus? formStatus,
    String? name,
    String? email,
    String? phone,
    String? password,
  }) =>
      SignUpFormState(
        formStatus: formStatus ?? this.formStatus,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        password: password ?? this.password,
      );

  @override
  List<Object> get props => [formStatus, name, email, phone, password];
}
