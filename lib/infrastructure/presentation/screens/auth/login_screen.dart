import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/application/blocs/login/login_bloc.dart';
import 'package:flutter_template/presentation/widgets/auth/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  final LinearGradient gradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4F14A0), Color(0xFF8066FF)],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(gradient: gradient),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                    top: 90,
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/logo_white.png',
                        width: 205,
                      ),
                    )),
                Positioned(
                    top: 0,
                    left: 0,
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/particles.png',
                        width: 420,
                      ),
                    )),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      bottom: -160,
                      right: -140,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 50, horizontal: 150),
                        width: 685.0,
                        height: 685.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                        child: SingleChildScrollView(
                            child: BlocProvider(
                          create: (context) => LoginBloc(),
                          child: const LoginForm(),
                        )),
                      ),
                    ),
                  ],
                )
              ],
            )));
  }
}
