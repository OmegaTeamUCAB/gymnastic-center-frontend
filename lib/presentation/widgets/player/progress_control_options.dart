import 'package:flutter/material.dart';
import 'package:gymnastic_center/application/blocs/player/player_bloc.dart';

class PauseControlOptions extends StatelessWidget {
  final PlayerBloc playerBloc;
  final PlayerState playerState;
  const PauseControlOptions({
    super.key,
    required this.playerBloc,
    required this.playerState,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.7),
                Colors.black.withOpacity(0.3),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
            child: Stack(
              children: [
                Column(
                  children: [
                    if (!playerState.isFinished)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 34,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.close_sharp,
                            color: Colors.white,
                            size: 34,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 20),
                      if (!playerState.isFinished)
                      IconButton(
                        onPressed: () async {
                          if (!playerState.isFinished) {
                            return playerBloc.add(TogglePlaying());
                          }
                          playerBloc.cachedVideoPlayerController.pause();
                          await playerBloc.cachedVideoPlayerController
                              .seekTo(Duration.zero);
                          playerBloc.add(ResetPlayer());
                          playerBloc.add(TogglePlaying());
                        },
                        icon: const Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.deepPurple,
                          size: 80,
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
