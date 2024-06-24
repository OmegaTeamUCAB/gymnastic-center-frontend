import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/auth/auth_bloc.dart';
import 'package:gymnastic_center/application/blocs/login/login_bloc.dart';
import 'package:gymnastic_center/presentation/screens/home/main_screen.dart';
import 'package:gymnastic_center/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:gymnastic_center/presentation/widgets/auth/login_form.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_gradient.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          body: Container(
              decoration: const BoxDecoration(gradient: brandGradient),
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
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 50, horizontal: 150),
                          width: 660.0,
                          height: 660.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                          child: SingleChildScrollView(
                              child: BlocProvider(
                            create: (context) => LoginBloc(),
                            child: BlocListener<AuthBloc, AuthState>(
                              listener: (context, state) {
                                if (state is Authenticated) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            (GetIt.instance.get<bool>() == false) ? OnBoardingPageScreen() : const MainScreen()),
                                  );
                                }
                                if (state is AuthError) {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(state.message),
                                    backgroundColor: Colors.red,
                                    duration: const Duration(milliseconds: 300),
                                  ));
                                }
                              },
                              child: const LoginForm(),
                            ),
                          )),
                        ),
                      ),
                    ],
                  )
                ],
              ))),
    );
  }
}
