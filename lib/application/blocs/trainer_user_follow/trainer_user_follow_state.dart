part of 'trainer_user_follow_bloc.dart';

sealed class TrainerUserFollowState extends Equatable {
  @override
  List<Object> get props => [];
}

class TrainerUserFollowLoading extends TrainerUserFollowState {}

class TrainerUserFollowSuccess extends TrainerUserFollowState {
  final int count;

  TrainerUserFollowSuccess({required this.count});
}

class TrainerUserFollowFailed extends TrainerUserFollowState {
  final String message;

  TrainerUserFollowFailed({required this.message});

  @override
  List<Object> get props => [message];
}
