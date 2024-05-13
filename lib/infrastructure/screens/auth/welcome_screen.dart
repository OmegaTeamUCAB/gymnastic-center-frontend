import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/auth/auth_bloc.dart';
import 'package:gymnastic_center/infrastructure/screens/auth/login_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/auth/sign_up_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/home/main_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.watch<AuthBloc>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (authBloc.state is Authenticated) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      }
    });
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Theme.of(context).brightness == Brightness.dark
                ? 'assets/logo_white.png'
                : 'assets/logo_color.png',
            width: 200,
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            'Your new fitness companion',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: authBloc.state is AuthLoading
                  ? [const CircularProgressIndicator()]
                  : [
                      Expanded(
                        child: BrandButton(
                            buttonText: 'Login',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                              );
                            }),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                color: Theme.of(context).colorScheme.background,
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? const [
                                        BoxShadow(
                                          color: Color.fromRGBO(
                                              114, 79, 227, 0.17),
                                          blurRadius: 22.0,
                                          spreadRadius: 0.0,
                                          offset: Offset(0, 14.0),
                                        ),
                                      ]
                                    : null),
                            child: TextButton(
                              style: const ButtonStyle(),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen()),
                                );
                              },
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                    fontSize: 20,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                            )),
                      ),
                    ],
            ),
          ),
        ],
      ),
    );
  }
}
