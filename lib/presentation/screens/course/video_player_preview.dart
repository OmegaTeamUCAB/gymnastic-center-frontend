import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/lesson/lesson_bloc.dart';
import 'package:gymnastic_center/application/blocs/video_player/video_player_bloc.dart';

class VideoPlayerView extends StatelessWidget {
  const VideoPlayerView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final videoBloc = context.read<VideoPlayerBloc>();
    return BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
        builder: (context, state) {
          if(state is VideoPlayerLoading){
            return const Scaffold(
              body: Center(
                  child: CircularProgressIndicator(
            strokeWidth: 2,
          )));
          }
          if(state is VideoPlayerError) {
            return Center(child: Text('${state.message}'));
          }

          if(state is VideoPlayerCompleted){}

          if(state is VideoPlayerLoaded){
            return AspectRatio(
              aspectRatio: videoBloc.videoPlayerController.value.aspectRatio,
              child: CachedVideoPlayer(videoBloc.videoPlayerController),
            );
          } else return CircularProgressIndicator();

        },);
          
  }
}