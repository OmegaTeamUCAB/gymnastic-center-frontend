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
  VideoPlayerBloc() : super(VideoPlayerLoading()) {
    on<InitializePlayer>(_initializePlayer);
  }

  Future<Result<bool>> _loadVideo() async {
    try {
      await videoPlayerController.initialize();
      return Result.success<bool>(true);
    } catch (e) {
      return Result.failure<bool>(const UnknownException());
    }
  }

  void pause() {
    videoPlayerController.pause();
  }

  Future<void> _initializePlayer(InitializePlayer event, Emitter<VideoPlayerState> emit) async {
    if(state is VideoPlayerLoaded)
    videoPlayerController.pause();
    emit(VideoPlayerLoading());
      videoPlayerController =  CachedVideoPlayerController.network(event.video);
    final result = await _loadVideo();
        videoPlayerController
      ..setLooping(false)
      ..play();
    if(result.isSuccessful){
      emit(VideoPlayerLoaded(
        video: videoPlayerController.dataSource,
        currentSpeed: videoPlayerController.value.playbackSpeed,
        isMuted: videoPlayerController.value.volume == 0,
        isPlaying: videoPlayerController.value.isPlaying,
        videoDuration: videoPlayerController.value.duration,
      ));
    }
    else {
      emit(VideoPlayerError(message: result.error.message));
    }
  }

}
