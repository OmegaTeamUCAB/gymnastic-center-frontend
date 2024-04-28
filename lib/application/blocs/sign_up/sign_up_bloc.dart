import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpFormState> {
  SignUpBloc() : super(const SignUpFormState()) {
    on<FormSubmitted>(_onFormSubmitted);
    on<NameChanged>(_onNameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PhoneChanged>(_onPhoneChanged);
    on<PasswordChanged>(_onPasswordChanged);
  }

  void _onFormSubmitted(FormSubmitted event, Emitter<SignUpFormState> emit) {
    print('Form submitted');
  }

  void _onNameChanged(NameChanged event, Emitter<SignUpFormState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _onEmailChanged(EmailChanged event, Emitter<SignUpFormState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPhoneChanged(PhoneChanged event, Emitter<SignUpFormState> emit) {
    emit(state.copyWith(phone: event.phone));
  }

  void _onPasswordChanged(
      PasswordChanged event, Emitter<SignUpFormState> emit) {
    emit(state.copyWith(password: event.password));
  }
}
