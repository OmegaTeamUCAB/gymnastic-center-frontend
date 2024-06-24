import 'dart:convert';

import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String fullName;
  final String? image;
  final String? urlImage;
  final double? radius;
  final dynamic onPressed;

  const ProfileAvatar(
      {super.key,
      required this.fullName,
      this.image,
      this.urlImage,
      this.radius = 35,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    Widget avatar;
    if (urlImage != null) {
      // If urlImage is provided, use NetworkImage
      avatar = CircleAvatar(
        backgroundImage: NetworkImage(urlImage!),
        radius: radius,
      );
    } else if (image != null) {
      // If image is provided, assume it's base64 and use MemoryImage
      avatar = CircleAvatar(
        backgroundImage: MemoryImage(
          base64Decode(image!),
        ),
        radius: radius,
      );
    } else {
      // Default avatar with initials
      avatar = CircleAvatar(
        backgroundColor: const Color(0xFFe3dff1),
        radius: radius,
        child: Text(
          fullName.split(' ').map((l) => l[0]).take(2).join(),
          style: const TextStyle(fontSize: 20),
        ),
      );
    }

    return onPressed != null
        ? InkWell(
            onTap: onPressed,
            child: avatar,
          )
        : avatar;
  }
}
