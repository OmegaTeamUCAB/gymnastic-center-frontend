part of 'sign_up_bloc.dart';

enum FormStatus { invalid, valid, validating, posting }

class SignUpFormState extends Equatable {
  final FormStatus formStatus;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;

  const SignUpFormState(
      {this.formStatus = FormStatus.invalid,
      this.fullName = '',
      this.email = '',
      this.phoneNumber = '',
      this.password = ''});

  SignUpFormState copyWith({
    FormStatus? formStatus,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? password,
  }) =>
      SignUpFormState(
        formStatus: formStatus ?? this.formStatus,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        password: password ?? this.password,
      );

  @override
  List<Object> get props =>
      [formStatus, fullName, email, phoneNumber, password];
}
