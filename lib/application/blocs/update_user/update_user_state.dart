part of 'update_user_bloc.dart';

sealed class UpdateUserState extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateUserLoading extends UpdateUserState{}

class UpdateUserInitial extends UpdateUserState {}

class UpdateUserSuccess extends UpdateUserState {}

class UpdateUserFailed extends UpdateUserState {
  final String message;

  UpdateUserFailed({required this.message});

  @override
  List<Object> get props => [message];
}
