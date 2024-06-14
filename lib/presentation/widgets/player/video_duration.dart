import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/video_player/video_player_bloc.dart';

class VideoDuration extends StatelessWidget {
  const VideoDuration({super.key});

Stream<Duration> _videoProgressStream(BuildContext context) {
  return Stream.periodic(const Duration(microseconds: 200), (_) {
    return context.read<VideoPlayerBloc>().getVideoPosition();
  }).takeWhile((progress) => progress < context.read<VideoPlayerBloc>().state.videoDuration);
}

  @override
  Widget build(BuildContext context) {
    return 
    BlocProvider.value(
      value: context.read<VideoPlayerBloc>(), 
      child: BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
      builder: (context, state) {
        if(state.videoStatus == PlayerStatus.streaming) {
          return StreamBuilder<Duration>(
      stream: _videoProgressStream(context),
      builder: (context, snapshot) {
        Duration position = snapshot.connectionState == ConnectionState.done ? context.read<VideoPlayerBloc>().state.videoDuration : (snapshot.data ?? Duration.zero);
        return Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${position.inMinutes.remainder(60).toString().padLeft(2, '0')}:${position.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    );
      },
    );
        } 
        return Container();
      },
    ));
  }
}

