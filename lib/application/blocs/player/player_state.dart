part of 'player_bloc.dart';

class PlayerState {
  final bool isPlaying;
  final bool isMuted;
  final Duration videoDuration;
  final bool isInitialized;
  final bool isLoading;
  final bool isFinished;
  final bool isDisposed;
  final int minutes;
  final int seconds;
  final bool startVideoPlaying;
  final double currentSpeed;
  final String currentVideoUrl;

  PlayerState(
      {this.isPlaying = false,
      this.isMuted = false,
      this.videoDuration = Duration.zero,
      this.isInitialized = false,
      this.isDisposed = false,
      this.isLoading = false,
      this.currentSpeed = 0,
      this.startVideoPlaying = true,
      this.minutes = 0,
      this.seconds = 0,
      this.isFinished = false,
      this.currentVideoUrl = ''});

  PlayerState copyWith(
          {bool? isPlaying,
          bool? isFinished,
          bool? isMuted,
          bool? isLoading,
          Duration? videoDuration,
          bool? isInitialized,
          double? currentSpeed,
          bool? isDisposed,
          String? currentVideoUrl,
          int? minutes,
          bool? startVideoPlaying,
          int? seconds}) =>
      PlayerState(
        isPlaying: isPlaying ?? this.isPlaying,
        isMuted: isMuted ?? this.isMuted,
        videoDuration: videoDuration ?? this.videoDuration,
        isInitialized: isInitialized ?? this.isInitialized,
        isLoading: isLoading ?? this.isLoading,
        currentSpeed: currentSpeed ?? this.currentSpeed,
        minutes: minutes ?? this.minutes,
        seconds: seconds ?? this.seconds,
        isDisposed: isDisposed ?? this.isDisposed,
        isFinished: isFinished ?? this.isFinished,
        startVideoPlaying: startVideoPlaying ?? this.startVideoPlaying,
        currentVideoUrl: currentVideoUrl ?? this.currentVideoUrl,
      );
}
