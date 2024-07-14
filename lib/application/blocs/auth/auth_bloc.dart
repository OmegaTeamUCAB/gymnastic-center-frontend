import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/use_cases/auth/get_user_from_token.use_case.dart';
import 'package:gymnastic_center/application/use_cases/auth/login.use_case.dart';
import 'package:gymnastic_center/application/use_cases/auth/logout.use_case.dart';
import 'package:gymnastic_center/application/use_cases/auth/request_code.use_case.dart';
import 'package:gymnastic_center/application/use_cases/auth/reset_password.use_case.dart';
import 'package:gymnastic_center/application/use_cases/auth/sign_up.use_case.dart';
import 'package:gymnastic_center/application/use_cases/auth/verify_code.use_case.dart';
import 'package:gymnastic_center/domain/auth/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LogoutUseCase logoutUseCase;
  final LoginUseCase loginUseCase;
  final SignUpUseCase signUpUseCase;
  final GetUserFromTokenUseCase getUserFromTokenUseCase;
  final RequestCodeUseCase requestCodeUseCase;
  final VerifyCodeUseCase verifyCodeUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  AuthBloc({
    required this.logoutUseCase,
    required this.loginUseCase,
    required this.signUpUseCase,
    required this.getUserFromTokenUseCase,
    required this.requestCodeUseCase,
    required this.verifyCodeUseCase,
    required this.resetPasswordUseCase,
  }) : super(AuthState()) {
    on<VerifiedUser>(_verifyUser);
    on<LoggedIn>(_logIn);
    on<SignedUp>(_signUp);
    on<SignedOut>(_logout);
    on<CodeRequested>(_requestCode);
    on<CodeVerified>(_verifyCode);
    on<PasswordReset>(_resetPassword);
    add(const VerifiedUser());
  }

  Future<void> _verifyUser(VerifiedUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await getUserFromTokenUseCase.execute(null);
    if (result.isSuccessful) {
      emit(Authenticated(result.unwrap()));
    } else {
      emit(AuthError('Could not verify user'));
    }
  }

  Future<void> _logIn(LoggedIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await loginUseCase
        .execute(LoginDto(email: event.email, password: event.password));
    if (result.isSuccessful) {
      emit(Authenticated(result.unwrap()));
    } else {
      emit(AuthError('Invalid credentials'));
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
      print('Signed up');
      emit(Authenticated(result.unwrap()));
    } else {
      emit(AuthError('Sign up failed'));
    }
  }

  void _logout(SignedOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await logoutUseCase.execute(null);
    if (result.isSuccessful) {
      emit(Unauthenticated());
    } else {
      print('Logout failed');
      emit(AuthError(result.error.message));
    }
  }

  void _requestCode(CodeRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result =
        await requestCodeUseCase.execute(RequestCodeDto(email: event.email));
    if (result.isSuccessful) {
      emit(CodeRequestedSuccess());
    } else {
      emit(AuthError(result.error.message));
    }
  }

  void _verifyCode(CodeVerified event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await verifyCodeUseCase.execute(VerifyCodeDto(
      email: event.email,
      code: event.code,
    ));
    if (result.unwrap().success == true) {
      emit(CodeVerifiedSuccess());
    } else {
      emit(AuthError(result.error.message));
    }
  }

  void _resetPassword(PasswordReset event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await resetPasswordUseCase.execute(ResetPasswordDto(
      email: event.email,
      newPassword: event.newPassword,
      code: event.code,
    ));
    if (result.unwrap().success == true) {
      emit(PasswordResetSuccess());
    } else {
      emit(AuthError(result.error.message));
    }
  }
}
