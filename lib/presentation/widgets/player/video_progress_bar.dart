import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/video_player/video_player_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/player/custom_progress_bar.dart';

class VideoProgressBar extends StatelessWidget {
  const VideoProgressBar({super.key});

Stream<double> _videoProgressStream(BuildContext context) {
  return Stream.periodic(const Duration(microseconds: 200), (_) {
    return context.read<VideoPlayerBloc>().getVideoProgress();
  }).takeWhile((progress) => progress < 1);
}

  @override
  Widget build(BuildContext context) {
    return 
    BlocProvider.value(
      value: context.read<VideoPlayerBloc>(), 
      child: BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
      builder: (context, state) {
        if(state.videoStatus == PlayerStatus.streaming) {
          return StreamBuilder<double>(
      stream: _videoProgressStream(context),
      builder: (context, snapshot) {
        double progress = snapshot.connectionState == ConnectionState.done ? 1 : (snapshot.data ?? 0);
        return CustomProgressBar(
          progress: progress,
          segments: 20,
          seekPosition: context.read<VideoPlayerBloc>().seekPosition,
        );
      },
    );
        } 
        return Container();
      },
    ));
  }
}