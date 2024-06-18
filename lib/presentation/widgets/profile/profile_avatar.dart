import 'package:flutter/material.dart';
import 'package:gymnastic_center/application/blocs/auth/auth_bloc.dart';

class ProfileAvatar extends StatelessWidget {
  final AuthBloc authBloc;
  final double? radius;

  const ProfileAvatar({super.key, required this.authBloc, this.radius = 35});

  @override
  Widget build(BuildContext context) {
    return authBloc.state is Authenticated &&
            (authBloc.state as Authenticated).user.image != null
        ? CircleAvatar(
            backgroundImage: NetworkImage(
              (authBloc.state as Authenticated).user.image!,
            ),
            radius: radius,
          )
        : CircleAvatar(
            backgroundColor: const Color(0xFFe3dff1),
            radius: radius,
            child: Text(
                (authBloc.state as Authenticated)
                    .user
                    .fullName
                    .split(' ')
                    .map((l) => l[0])
                    .take(2)
                    .join(),
                style: const TextStyle(
                    color: Color(0xFF4F14A0),
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
          );
  }
}
