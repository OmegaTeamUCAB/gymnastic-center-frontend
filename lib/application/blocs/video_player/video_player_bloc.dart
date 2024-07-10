
// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/core/exception.dart';
import 'package:gymnastic_center/core/result.dart';
import 'package:meta/meta.dart';

part 'video_player_event.dart';
part 'video_player_state.dart';

class VideoPlayerBloc extends Bloc<VideoPlayerEvent, VideoPlayerState> {
  late CachedVideoPlayerController videoPlayerController;
  static const List<double> speeds = [1.0, 2.0];

  VideoPlayerBloc() : super(const VideoPlayerState()) {
    on<VideoInitialized>(_initializePlayer);
    on<VideoCompleted>(_videoCompleted);
    on<VideoStreamed>(_videoStreamed);
    on<VideoPositionUpdated>(_videoPositionUpdated);
  }

  Future<Result<bool>> _loadVideo() async {
    try {
      await videoPlayerController.initialize();
      return Result.success<bool>(true);
    } catch (e) {
      return Result.failure<bool>(const UnknownException());
    }
  }


  Future<void> _initializePlayer(VideoInitialized event, Emitter<VideoPlayerState> emit) async {
    if(state.videoStatus == PlayerStatus.streaming){
      videoPlayerController.pause();
    }
    emit(state.copyWith(videoStatus: PlayerStatus.loading));
    videoPlayerController = CachedVideoPlayerController.network(event.video);
    final result = await _loadVideo();
    if(result.isSuccessful){
      videoPlayerController.setLooping(false);
      await videoPlayerController.seekTo(((event.time == videoPlayerController.value.duration) || (videoPlayerController.value.duration.inSeconds - event.time.inSeconds <= 3 )) ? Duration.zero : event.time);
      await videoPlayerController.play();
      emit(state.copyWith(
          videoStatus: PlayerStatus.streaming,
          video: videoPlayerController.dataSource,
          currentSpeed: videoPlayerController.value.playbackSpeed,
          isMuted: videoPlayerController.value.volume == 0,
          isPlaying: videoPlayerController.value.isPlaying,
          videoDuration: videoPlayerController.value.duration,
          position: videoPlayerController.value.position));
      videoPlayerController.addListener(updateVideoProgress);
    } else {
      emit(state.copyWith(message: result.error.message, videoStatus: PlayerStatus.error));
    }
  }

  void _videoCompleted(VideoCompleted event, Emitter<VideoPlayerState> emit) {
    emit(state.copyWith(videoStatus: PlayerStatus.completed));
  }

  void _videoStreamed(VideoStreamed event, Emitter<VideoPlayerState> emit) {
    emit(state.copyWith(videoStatus: PlayerStatus.streaming));
  }

  void _videoPositionUpdated(
      VideoPositionUpdated event, Emitter<VideoPlayerState> emit) {
    emit(state.copyWith(position: videoPlayerController.value.position));
  }

  void togglePlay() {
    if (state.isPlaying) {
      pause();
    } else {
      play();
    }
  }

  double getVideoProgress() {
    return state.position.inMicroseconds / state.videoDuration.inMicroseconds;
  }

  Duration getVideoPosition() {
    return videoPlayerController.value.position;
  }
  
  Duration getVideoTotalDuration(){
    return videoPlayerController.value.duration;
  }

    void updateVideoProgress(){
      if(isClosed || !videoPlayerController.value.isInitialized) return;
      if(state.videoStatus == PlayerStatus.loading) return;
    final currentPosition = videoPlayerController.value.position.inMicroseconds;
    final videoDuration = videoPlayerController.value.duration.inMicroseconds;
    final progress = currentPosition / videoDuration;
    if (progress == 1) add(VideoCompleted());
    if (progress != 1 && state.videoStatus == PlayerStatus.completed) {
      add(VideoStreamed());
    }
    add(VideoPositionUpdated());
  }

  void play() {
    videoPlayerController.play();
        emit(state.copyWith(isPlaying: true));
  }

  void pause() {
    videoPlayerController.pause();
    emit(state.copyWith(isPlaying: false));
  }

  void toggleMute() {
    videoPlayerController.setVolume(!state.isMuted ? 0 : 1);
    emit(state.copyWith(isMuted: !state.isMuted));
  }

  void setVideoSpeed(double speed) {
    videoPlayerController.setPlaybackSpeed(speed);
    emit(state.copyWith(currentSpeed: speed));
  }

  void unmute() {}

  Future<void> seekPosition(Duration position) async {
    if(videoPlayerController.value.isInitialized)
    await videoPlayerController.seekTo(position);
  }


  Future<void> setToInitialState() async {
    // ignore: unnecessary_null_comparison
    if(videoPlayerController != null){
      videoPlayerController.pause();
      await Future.delayed(const Duration(milliseconds: 20)).then((value) => videoPlayerController?.dispose());
    }     
    emit(VideoPlayerState());
  }

}
