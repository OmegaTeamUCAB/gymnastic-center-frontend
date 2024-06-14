import 'package:bloc/bloc.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/core/exception.dart';
import 'package:gymnastic_center/core/result.dart';
import 'package:meta/meta.dart';

part 'video_player_event.dart';
part 'video_player_state.dart';

class VideoPlayerBloc extends Bloc<VideoPlayerEvent, VideoPlayerState> {
  late CachedVideoPlayerController videoPlayerController;
  VideoPlayerBloc() : super(VideoPlayerState()) {
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
    if(state.videoStatus == PlayerStatus.streaming)
    videoPlayerController.pause();
    emit(state.copyWith(videoStatus: PlayerStatus.loading));
      videoPlayerController =  CachedVideoPlayerController.network(event.video);
    final result = await _loadVideo();
        videoPlayerController
      ..setLooping(false)
      ..play();
    if(result.isSuccessful){
      emit(state.copyWith(
        videoStatus: PlayerStatus.streaming,
        video: videoPlayerController.dataSource,
        currentSpeed: videoPlayerController.value.playbackSpeed,
        isMuted: videoPlayerController.value.volume == 0,
        isPlaying: videoPlayerController.value.isPlaying,
        videoDuration: videoPlayerController.value.duration,
        position: videoPlayerController.value.position
      ));
      videoPlayerController.addListener(updateVideoProgress);
    }
    else {
      emit(state.copyWith(message: result.error.message));
    }
  }

  void _videoCompleted(VideoCompleted event ,Emitter<VideoPlayerState> emit){
    emit(state.copyWith(videoStatus: PlayerStatus.completed));
  }

  void _videoStreamed(VideoStreamed event ,Emitter<VideoPlayerState> emit){
    emit(state.copyWith(videoStatus: PlayerStatus.streaming));
  }

  void _videoPositionUpdated(VideoPositionUpdated event ,Emitter<VideoPlayerState> emit){
    emit(state.copyWith(position: videoPlayerController.value.position));
  }

  double getVideoProgress(){
    return state.position.inMicroseconds / state.videoDuration.inMicroseconds; 
  }

  Duration getVideoPosition(){
    return videoPlayerController.value.position;
  }

    void updateVideoProgress(){
    final currentPosition = videoPlayerController.value.position.inMicroseconds;
    final videoDuration = videoPlayerController.value.duration.inMicroseconds;
    final progress = currentPosition / videoDuration;
    if(progress == 1) add(VideoCompleted());
    if(progress != 1 && state.videoStatus == PlayerStatus.completed) add(VideoStreamed()); 
    add(VideoPositionUpdated());
}

  void play() {
    videoPlayerController.play();
    add(VideoPaused());
  }

  void pause() {
    videoPlayerController.pause();
    add(VideoPaused());
  }

  void mute() {}

  void unmute() {}

  Future<void> seekPosition(Duration position) async {
    await videoPlayerController.seekTo(position);
  }

}
