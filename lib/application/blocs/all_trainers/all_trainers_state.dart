part of 'all_trainers_bloc.dart';

sealed class AllTrainersState extends Equatable {
  @override
  List<Object> get props => [];
}

final class AllTrainersLoading extends AllTrainersState {}

class AllTrainersSuccess extends AllTrainersState {
  final List<Trainer> trainers;

  AllTrainersSuccess({required this.trainers});

  @override
  List<Object> get props => [trainers];
}

class AllTrainersFailed extends AllTrainersState {
  final String message;

  AllTrainersFailed({required this.message});

  @override
  List<Object> get props => [message];
}