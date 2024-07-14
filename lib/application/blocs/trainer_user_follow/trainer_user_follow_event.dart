part of 'trainer_user_follow_bloc.dart';

sealed class TrainerUserFollowEvent {
  const TrainerUserFollowEvent();
}

class TrainerUserFollowRequested extends TrainerUserFollowEvent {
  final int count;

  const TrainerUserFollowRequested({required this.count});
}
