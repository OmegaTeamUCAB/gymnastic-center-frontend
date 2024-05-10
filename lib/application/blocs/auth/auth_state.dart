part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final User? user;
  final bool isLoading;
  final bool isAuthenticated;
  const AuthState({
    this.user,
    this.isLoading = false,
    this.isAuthenticated = false,
  });

  @override
  List<Object?> get props => [user, isLoading, isAuthenticated];

  AuthState copyWith({User? user, bool? isLoading, bool? isAuthenticated}) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}
