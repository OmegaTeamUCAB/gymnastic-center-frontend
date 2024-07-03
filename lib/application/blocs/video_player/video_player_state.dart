part of 'video_player_bloc.dart';

enum PlayerStatus {
  streaming,
  completed,
  loading,
  error,
}

class VideoPlayerState extends Equatable {
  final String? message;
  final bool isPlaying;
  final bool isMuted;
  final Duration videoDuration;
  final double currentSpeed;
  final PlayerStatus videoStatus;
  final Duration position;
  final String video;
  const VideoPlayerState({
    this.message = '',
    this.isPlaying = false,
    this.isMuted = false,
    this.videoDuration = Duration.zero,
    this.currentSpeed = 1,
    this.videoStatus = PlayerStatus.loading,
    this.position = Duration.zero,
    this.video = '',
  });

  VideoPlayerState copyWith({
    bool? isPlaying,
    bool? isMuted,
    Duration? videoDuration,
    double? currentSpeed,
    PlayerStatus? videoStatus,
    Duration? position,
    String? message,
    String? video,
  }) =>
      VideoPlayerState(
        isPlaying: isPlaying ?? this.isPlaying,
        isMuted: isMuted ?? this.isMuted,
        videoDuration: videoDuration ?? this.videoDuration,
        currentSpeed: currentSpeed ?? this.currentSpeed,
        videoStatus: videoStatus ?? this.videoStatus,
        position: position ?? this.position,
        message: message ?? this.message,
        video: video ?? this.video,
      );

  @override
  // TODO: implement props
  List<Object> get props => [
        isPlaying,
        isMuted,
        videoDuration,
        currentSpeed,
        videoStatus,
        position,
        video
      ];
}
