import 'package:flutter/material.dart';

class WatchVideoOverlay extends StatelessWidget {
  const WatchVideoOverlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [Colors.black.withOpacity(0.5), Colors.transparent],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Center(
        child: Icon(Icons.play_circle_outline_rounded, color: Colors.white, size: 40,),
      ),
    ));
  }
}
