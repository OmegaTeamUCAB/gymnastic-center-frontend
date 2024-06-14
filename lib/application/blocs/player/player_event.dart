part of 'player_bloc.dart';


class PlayerEvent {

  const PlayerEvent();
}

class InitializePlayer extends PlayerEvent {
  final String videoUrl;
  final bool? playOnStart;

  InitializePlayer({
    required this.videoUrl,
    this.playOnStart = true,
  });
}

class ToggleMute extends PlayerEvent {}
class TogglePlaying extends PlayerEvent {}
class ResetPlayer extends PlayerEvent {}
class DisposePlayer extends PlayerEvent {}
class FinishedVideo extends PlayerEvent {}
class ChangeVideoSpeed extends PlayerEvent {
  final double speed;

  ChangeVideoSpeed({required this.speed});
}

class UpdateCurrentPosition extends PlayerEvent {
  final int minutes;
  final int seconds;

  UpdateCurrentPosition({required this.minutes, required this.seconds});

}

