part of 'follow_trainer_bloc.dart';

sealed class FollowTrainerState extends Equatable {
  const FollowTrainerState();
  
  @override
  List<Object> get props => [];
}

final class FollowTrainerLoading extends FollowTrainerState {}

class FollowTrainerSuccess extends FollowTrainerState {
  const FollowTrainerSuccess();

}

class FollowTrainerFailed extends FollowTrainerState {
  final String message;

  const FollowTrainerFailed({required this.message});

  @override
  List<Object> get props => [message];
}
