part of 'video_player_bloc.dart';

sealed class VideoPlayerState extends Equatable {
  @override
  List<Object> get props => [];
}

class VideoPlayerLoaded extends VideoPlayerState {
  final bool isPlaying;
  final bool isMuted;
  final Duration videoDuration;
  final double currentSpeed;
  final String video;
  VideoPlayerLoaded({
    this.isPlaying = false, 
    this.isMuted = false, 
    this.videoDuration = Duration.zero, 
    this.currentSpeed = 1, 
    this.video = '', 
    });

}
class VideoPlayerCompleted extends VideoPlayerState {}

class VideoPlayerError extends VideoPlayerState {
  final String message;

  VideoPlayerError({required this.message});
  
  @override
  List<Object> get props => [message];

}
class VideoPlayerLoading extends VideoPlayerState {}