import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/player/player_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/course/full_video_player.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String videoUrl;
  const VideoPlayerScreen({
    super.key,
    required this.videoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlayerBloc>(
      create: (context) {
        final videoPlayerBloc =
            PlayerBloc(CachedVideoPlayerController.network(videoUrl));
        videoPlayerBloc.add(InitializePlayer(videoUrl: videoUrl));
        return videoPlayerBloc;
      },
      child: const FullVideoPlayer(),
    );
  }
}
