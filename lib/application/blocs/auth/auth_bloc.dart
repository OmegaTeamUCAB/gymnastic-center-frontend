import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/use_cases/auth/get_user_from_token.use_case.dart';
import 'package:gymnastic_center/application/use_cases/auth/login.use_case.dart';
import 'package:gymnastic_center/application/use_cases/auth/logout.use_case.dart';
import 'package:gymnastic_center/application/use_cases/auth/sign_up.use_case.dart';
import 'package:gymnastic_center/domain/auth/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LogoutUseCase logoutUseCase;
  final LoginUseCase loginUseCase;
  final SignUpUseCase signUpUseCase;
  final GetUserFromTokenUseCase getUserFromTokenUseCase;

  AuthBloc({
    required this.logoutUseCase,
    required this.loginUseCase,
    required this.signUpUseCase,
    required this.getUserFromTokenUseCase,
  }) : super(AuthState()) {
    on<VerifiedUser>(_verifyUser);
    on<LoggedIn>(_logIn);
    on<SignedUp>(_signUp);
    on<SignedOut>(_logout);
    add(const VerifiedUser());
  }

  Future<void> _verifyUser(VerifiedUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await getUserFromTokenUseCase.execute(null);
    if (result.isSuccessful) {
      emit(Authenticated(result.unwrap()));
    } else {
      emit(AuthState());
    }
  }

  Future<void> _logIn(LoggedIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await loginUseCase
        .execute(LoginDto(email: event.email, password: event.password));
    if (result.isSuccessful) {
      emit(Authenticated(result.unwrap()));
    } else {
      emit(AuthError(result.error.message));
    }
  }

  Future<void> _signUp(SignedUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await signUpUseCase.execute(SignUpDto(
      email: event.email,
      password: event.password,
      fullName: event.fullName,
      phoneNumber: event.phoneNumber,
    ));
    if (result.isSuccessful) {
      emit(Authenticated(result.unwrap()));
    } else {
      emit(AuthError(result.error.message));
    }
  }

  void _logout(SignedOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await logoutUseCase.execute(null);
    if (result.isSuccessful) {
      emit(AuthState());
    }
  }
}
