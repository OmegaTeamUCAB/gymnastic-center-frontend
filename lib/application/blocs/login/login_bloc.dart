import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginFormEvent, LoginFormState> {
  LoginBloc() : super(const LoginFormState()) {
    on<FormSubmitted>(_onFormSubmitted);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
  }

  void _onFormSubmitted(FormSubmitted event, Emitter<LoginFormState> emit) {
    print('Form submitted');
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginFormState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginFormState> emit) {
    emit(state.copyWith(password: event.password));
  }
}
