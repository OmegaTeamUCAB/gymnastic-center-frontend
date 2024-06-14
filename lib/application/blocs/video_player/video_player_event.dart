part of 'video_player_bloc.dart';

@immutable
sealed class VideoPlayerEvent {}

class VideoInitialized extends VideoPlayerEvent {
  final String video;

  VideoInitialized({required this.video});

}

class VideoPaused extends VideoPlayerEvent {}
class VideoPlayed extends VideoPlayerEvent {}
class VideoSpeedChanged extends VideoPlayerEvent {}
class VideoMuted extends VideoPlayerEvent {}
class VideoUnmuted extends VideoPlayerEvent {}
class VideoCompleted extends VideoPlayerEvent {}
class VideoStreamed extends VideoPlayerEvent {}
class VideoPositionChanged extends VideoPlayerEvent {}
class VideoPositionUpdated extends VideoPlayerEvent {}
