part of 'follow_trainer_bloc.dart';

sealed class FollowTrainerEvent {}

class FollowRequested extends FollowTrainerEvent {
  final String id;

  FollowRequested({required this.id});
}
