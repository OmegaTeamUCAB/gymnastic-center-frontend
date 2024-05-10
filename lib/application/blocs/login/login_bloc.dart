import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/infrastructure/services/auth/auth_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginFormEvent, LoginFormState> {
  final AuthService authService = AuthService();

  LoginBloc() : super(const LoginFormState()) {
    on<EmailChanged>(_onEmailChange);
    on<PasswordChanged>(_onPasswordChange);
  }

  void _onEmailChange(EmailChanged event, Emitter<LoginFormState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChange(PasswordChanged event, Emitter<LoginFormState> emit) {
    emit(state.copyWith(password: event.password));
  }
}
