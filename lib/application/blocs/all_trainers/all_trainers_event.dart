part of 'all_trainers_bloc.dart';

sealed class AllTrainersEvent {
  const AllTrainersEvent();
}

class AllTrainersRequested extends AllTrainersEvent {
  final int page;
  const AllTrainersRequested(this.page);
}