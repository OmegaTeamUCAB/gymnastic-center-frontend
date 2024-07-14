import 'dart:convert';

import 'package:flutter/material.dart';

class ProfileAvatar extends StatefulWidget {
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
  ProfileAvatarState createState() => ProfileAvatarState();
}

class ProfileAvatarState extends State<ProfileAvatar> {
  @override
  Widget build(BuildContext context) {
    Widget avatar;
    if (widget.urlImage != null) {
      // If urlImage is provided, use NetworkImage
      avatar = CircleAvatar(
        backgroundImage: NetworkImage(widget.urlImage!),
        radius: widget.radius,
      );
    } else if (widget.image != null) {
      // If image is provided, assume it's base64 and use MemoryImage
      avatar = CircleAvatar(
        backgroundImage: MemoryImage(
          base64Decode(widget.image!),
        ),
        radius: widget.radius,
      );
    } else {
      // Default avatar with initials
      avatar = CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.surfaceTint,
        radius: widget.radius,
        child: Text(
          widget.fullName.split(' ').map((l) => l[0]).take(2).join(),
          style: TextStyle(
              fontSize: widget.radius! * 0.8,
              color: Theme.of(context).colorScheme.primary),
        ),
      );
    }

    return widget.onPressed != null
        ? InkWell(
            onTap: widget.onPressed,
            child: avatar,
          )
        : avatar;
  }
}
