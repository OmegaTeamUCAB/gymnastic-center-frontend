import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpFormState> {
  SignUpBloc() : super(const SignUpFormState()) {
    // on<FormSubmitted>(_onFormSubmitted);
    on<FullNameChanged>(_onFullNameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<PasswordChanged>(_onPasswordChanged);
  }

  // void _onFormSubmitted(FormSubmitted event, Emitter<SignUpFormState> emit) {}

  void _onFullNameChanged(
      FullNameChanged event, Emitter<SignUpFormState> emit) {
    emit(state.copyWith(fullName: event.name));
  }

  void _onEmailChanged(EmailChanged event, Emitter<SignUpFormState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPhoneNumberChanged(
      PhoneNumberChanged event, Emitter<SignUpFormState> emit) {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }

  void _onPasswordChanged(
      PasswordChanged event, Emitter<SignUpFormState> emit) {
    emit(state.copyWith(password: event.password));
  }
}
