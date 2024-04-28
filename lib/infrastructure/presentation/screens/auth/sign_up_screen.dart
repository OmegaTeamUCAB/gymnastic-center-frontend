import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/application/blocs/sign_up/sign_up_bloc.dart';
import 'package:flutter_template/presentation/widgets/auth/sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  final LinearGradient gradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4F14A0), Color(0xFF8066FF)],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
            top: 100,
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                Theme.of(context).brightness == Brightness.dark
                    ? 'assets/logo_white.png'
                    : 'assets/logo_color.png',
                width: 120,
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
              bottom: -70,
              child: Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 170),
                        width: 720.0,
                        height: 720.0,
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage('assets/particles.png'),
                              alignment: Alignment.topRight,
                            ),
                            shape: BoxShape.circle,
                            gradient: gradient),
                        child: Stack(
                          children: [
                            BlocProvider(
                              create: (context) => SignUpBloc(),
                              child: const SingleChildScrollView(
                                child: SignUpForm(),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    ));
  }
}
