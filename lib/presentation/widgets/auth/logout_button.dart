import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/auth/auth_bloc.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.watch<AuthBloc>();
    return IconButton(
        icon: const Icon(
          Icons.logout,
          color: Colors.red,
        ),
        onPressed: () {
          authBloc.add(const SignedOut());
        });
  }
}
