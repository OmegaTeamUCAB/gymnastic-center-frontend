import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/models/user.dart';
import 'package:gymnastic_center/infrastructure/config/local-storage/secure_storage.dart';
import 'package:gymnastic_center/infrastructure/services/auth/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authenticationService = AuthService();

  AuthBloc() : super(const AuthState()) {
    on<VerifiedUser>(_verifyUser);
    // on<SignedIn>(_signIn);
    on<SignedOut>(_signOut);
  }

  void _verifyUser(VerifiedUser event, Emitter<AuthState> emit) async {
    final user = await authenticationService.verifyUser();
    emit(state.copyWith(user: user));
  }

  void _signIn() {}

  void _signOut(SignedOut event, Emitter<AuthState> emit) {
    emit(state.copyWith(user: null));
    SecureStorage().deleteSecureData;
  }
}
