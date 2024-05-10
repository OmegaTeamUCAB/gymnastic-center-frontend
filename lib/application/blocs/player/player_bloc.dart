import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  CachedVideoPlayerController cachedVideoPlayerController;

  PlayerBloc(this.cachedVideoPlayerController) : super(PlayerState()) {
    on<InitializePlayer>(_onInitializePlayer);
    on<TogglePlaying>(_onPlaying);
    on<ToggleMute>(_onMute);
    on<FinishedVideo>(_onFinishedVideo);
    on<ResetPlayer>(_onResetPlayer);
    on<UpdateCurrentPosition>(_onCurrentPosition);
    on<DisposePlayer>(_onDisposePlayer);
    on<ChangeVideoSpeed>(_onChangeVideoSpeed);
  }

  _onInitializePlayer(InitializePlayer event, Emitter<PlayerState> emit) async {
    emit(state.copyWith(isLoading: true, isInitialized: false));
    await cachedVideoPlayerController.initialize();
    if(event.playOnStart == true){
      cachedVideoPlayerController.play();
    }
    emit(state.copyWith(
        isLoading: false,
        isInitialized: true,
        isDisposed: false,
        currentSpeed: cachedVideoPlayerController.value.playbackSpeed,
        currentVideoUrl: event.videoUrl,
        startVideoPlaying: event.playOnStart,
        isMuted: false,
        isPlaying: true,
        isFinished: false,
        videoDuration: cachedVideoPlayerController.value.duration));
  }

  _onPlaying(TogglePlaying event, Emitter<PlayerState> emit) {
    
    emit(state.copyWith(isPlaying: !state.isPlaying));
    (cachedVideoPlayerController.value.isPlaying == true) ? cachedVideoPlayerController.pause() : cachedVideoPlayerController.play();
  }

  _onMute(ToggleMute event, Emitter<PlayerState> emit) {
    emit(state.copyWith(isMuted: !state.isMuted));
    (cachedVideoPlayerController.value.volume == 0) ? cachedVideoPlayerController.setVolume(1) : cachedVideoPlayerController.setVolume(0);
  }

  _onFinishedVideo(FinishedVideo event, Emitter<PlayerState> emit) {
    emit(state.copyWith(isFinished: true, isPlaying: false));
  }

  _onResetPlayer(ResetPlayer event, Emitter<PlayerState> emit) {
    emit(state.copyWith(
        isLoading: false,
        isInitialized: true,
        currentSpeed: cachedVideoPlayerController.value.playbackSpeed,
        isMuted: false,
        isPlaying: false,
        isFinished: false,
        currentVideoUrl: cachedVideoPlayerController.dataSource,
        minutes: 0,
        seconds: 0,
        videoDuration: cachedVideoPlayerController.value.duration));
    }

  _onCurrentPosition(UpdateCurrentPosition event, Emitter<PlayerState> emit) {
    emit(state.copyWith(minutes: event.minutes, seconds: event.seconds));
  }
  _onChangeVideoSpeed(ChangeVideoSpeed event, Emitter<PlayerState> emit) {
    emit(state.copyWith(currentSpeed: event.speed));
    cachedVideoPlayerController.setPlaybackSpeed(event.speed);
  }
  _onDisposePlayer(DisposePlayer event, Emitter<PlayerState> emit) {
    emit(state.copyWith(isDisposed: true));
  }
  
}

