import 'package:flutter/material.dart';

class NewChip extends StatelessWidget {
  const NewChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: const Color(0xFF4F14A0),
            borderRadius: BorderRadius.circular(15)),
        child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
            child: Text(
              "New",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            )));
  }
}
