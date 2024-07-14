import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/player/buttons/custom_play_button.dart';

class CustomPauseView extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomPauseView({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.2),
              Colors.black.withOpacity(0.2),
            ],
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 20),
              CustomPlayButton(),
              const SizedBox(width: 20),
            ],
          ),
        ));
  }
}
