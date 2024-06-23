import 'dart:convert';

import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String fullName;
  final String? image;
  final double? radius;

  const ProfileAvatar(
      {super.key, required this.fullName, this.image, this.radius = 35});

  @override
  Widget build(BuildContext context) {
    return image != null
        ? CircleAvatar(
            backgroundImage: MemoryImage(
              base64Decode(image.toString()),
            ),
            radius: radius,
          )
        : CircleAvatar(
            backgroundColor: const Color(0xFFe3dff1),
            radius: radius,
            child: Text(fullName.split(' ').map((l) => l[0]).take(2).join(),
                style: TextStyle(
                    color: const Color(0xFF4F14A0),
                    fontSize: radius! / 1.2,
                    fontWeight: FontWeight.bold)),
          );
  }
}
