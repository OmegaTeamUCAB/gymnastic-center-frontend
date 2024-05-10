import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/domain/auth/user.dart';
import 'package:gymnastic_center/infrastructure/config/local-storage/secure_storage.dart';
import 'package:gymnastic_center/infrastructure/services/auth/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authenticationService = AuthService();

  AuthBloc() : super(const AuthState()) {
    on<VerifiedUser>(_verifyUser);
    on<LoggedIn>(_logIn);
    on<SignedUp>(_signUp);
    on<SignedOut>(_signOut);
  }

  Future<void> _verifyUser(VerifiedUser event, Emitter<AuthState> emit) async {
    final userData = await authenticationService.verifyUser();
    SecureStorage().writeSecureData('token', userData['token']);
    emit(state.copyWith(user: userData['user']));
  }

  Future<void> _logIn(LoggedIn event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final loggedUser = await authenticationService
          .login({'email': event.email, 'password': event.password});
      User user = User.fromJson(loggedUser['user']);
      emit(state.copyWith(user: user));
      SecureStorage().writeSecureData('token', loggedUser['token']);
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Invalid email or password'));
    } finally {
      emit(state.copyWith(isLoading: false, errorMessage: null));
    }
  }

  Future<void> _signUp(SignedUp event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final newUser = await authenticationService.signUp({
        'email': event.email,
        'fullName': event.fullName,
        'phoneNumber': event.phoneNumber,
        'password': event.password
      });
      User user = User.fromJson(newUser['user']);
      emit(state.copyWith(isLoading: false, user: user));
      SecureStorage().writeSecureData('token', newUser['token']);
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  void _signOut(SignedOut event, Emitter<AuthState> emit) {
    emit(state.copyWith(user: null));
    SecureStorage().deleteSecureData;
  }
}
