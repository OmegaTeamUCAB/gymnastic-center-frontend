part of 'trainer_detail_bloc.dart';

sealed class TrainerDetailEvent {
  const TrainerDetailEvent();
}

class TrainerDetailRequested extends TrainerDetailEvent {
  final String trainerId;

  TrainerDetailRequested({required this.trainerId});
}
