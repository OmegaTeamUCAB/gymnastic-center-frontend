part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final User? user;
  final bool isLoading;
  const AuthState({
    this.user,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [user, isLoading];

  AuthState copyWith({
    User? user,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading,
    );
  }
}
