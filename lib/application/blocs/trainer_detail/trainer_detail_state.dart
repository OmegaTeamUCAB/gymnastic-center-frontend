part of 'trainer_detail_bloc.dart';

sealed class TrainerDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class TrainerDetailLoading extends TrainerDetailState {}

class TrainerDetailLoaded extends TrainerDetailState {
  final dynamic trainer;

  TrainerDetailLoaded({required this.trainer});

  @override
  List<Object> get props => [trainer];
}

class TrainerDetailFailed extends TrainerDetailState {
  final String message;

  TrainerDetailFailed({required this.message});

  @override
  List<Object> get props => [message];
}
