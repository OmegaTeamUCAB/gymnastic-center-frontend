import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/player/player_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/course/video_player.dart';

class FullVideoPlayer extends StatelessWidget {
  const FullVideoPlayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final playerBloc = context.watch<PlayerBloc>();
    final playerState = context.watch<PlayerBloc>().state;
    final controller = context.watch<PlayerBloc>().cachedVideoPlayerController;

    return Center(
      child: (playerState.isInitialized)
          ? VideoPlayer(
              controller: controller,
              playerBloc: playerBloc,
              playerState: playerState,
            )
          : const CircularProgressIndicator(
              strokeWidth: 2,
            ),
    );
  }
}
