import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/video_player/video_player_bloc.dart';

class VideoPlayerView extends StatelessWidget {
  const VideoPlayerView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final videoBloc = context.read<VideoPlayerBloc>();
    return BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
      buildWhen: (previous, current) {
           return previous.videoStatus != current.videoStatus;
         },
        builder: (context, state) {
          if(state.videoStatus == PlayerStatus.loading){
            return const Scaffold(
              body: Center(
                  child: CircularProgressIndicator(
            strokeWidth: 4,
          )));
          }
          if(state.videoStatus == PlayerStatus.error) {
            return Center(child: Text('${state.message}'));
          }

          // if(state.videoStatus == PlayerStatus.completed){}

          if(state.videoStatus == PlayerStatus.streaming){
            return AspectRatio(
              aspectRatio: videoBloc.videoPlayerController.value.aspectRatio,
              child: CachedVideoPlayer(videoBloc.videoPlayerController),
            );
          } else return CircularProgressIndicator();

        },);
          
  }
}