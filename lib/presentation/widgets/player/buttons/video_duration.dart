import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/video_player/video_player_bloc.dart';

class VideoDuration extends StatelessWidget {
  const VideoDuration({super.key});

  Stream<Duration> _videoProgressStream(BuildContext context) {
    return Stream.periodic(const Duration(microseconds: 200), (_) {
      return context.read<VideoPlayerBloc>().getVideoPosition();
    }).takeWhile((progress) =>
        progress < context.read<VideoPlayerBloc>().state.videoDuration);
  }

  @override
  Widget build(BuildContext context) {
    final videoBloc = GetIt.instance<VideoPlayerBloc>();
    
    return BlocProvider.value(
        value: videoBloc,
        child: BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
          builder: (context, state) {
            if (state.videoStatus == PlayerStatus.streaming) {
              return StreamBuilder<Duration>(
                stream: _videoProgressStream(context),
                builder: (context, snapshot) {
                  Duration position =
                      snapshot.connectionState == ConnectionState.done
                          ? GetIt.instance<VideoPlayerBloc>().state.videoDuration
                          : (snapshot.data ?? Duration.zero);
                  return Text(
                      '${position.inMinutes.remainder(60).toString().padLeft(2, '0')}:${position.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold));
                },
              );
            }
            return Container();
          },
        ));
  }
}
