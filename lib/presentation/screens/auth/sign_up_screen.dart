import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/auth/auth_bloc.dart';
import 'package:gymnastic_center/application/blocs/sign_up/sign_up_bloc.dart';
import 'package:gymnastic_center/presentation/screens/home/main_screen.dart';
import 'package:gymnastic_center/presentation/widgets/auth/sign_up_form.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_gradient.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/particles.png'),
                              alignment: Alignment.topRight,
                            ),
                            shape: BoxShape.circle,
                            gradient: brandGradient),
                        child: Stack(
                          children: [
                            BlocProvider(
                              create: (context) => SignUpBloc(),
                              child: SingleChildScrollView(
                                child: BlocListener<AuthBloc, AuthState>(
                                  listener: (context, state) {
                                    if (state is Authenticated) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MainScreen()),
                                      );
                                    }
                                    if (state is AuthError) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(state.message),
                                        backgroundColor: Colors.red,
                                        duration:
                                            const Duration(milliseconds: 300),
                                      ));
                                    }
                                  },
                                  child: const SignUpForm(),
                                ),
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