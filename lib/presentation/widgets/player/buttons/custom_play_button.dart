import 'package:flutter/material.dart';

class CustomPlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 120, 49, 220).withOpacity(0.3),
            shape: BoxShape.circle,
            boxShadow: [
            ],
          ),
        ),
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 122, 47, 226),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
      ],
    );
  }
}