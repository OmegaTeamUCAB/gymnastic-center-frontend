part of 'video_player_bloc.dart';

@immutable
sealed class VideoPlayerEvent {}

class InitializePlayer extends VideoPlayerEvent {
  final String video;

  InitializePlayer({required this.video});

}
