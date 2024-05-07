import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/login/login_bloc.dart';
import 'package:gymnastic_center/domain/auth/repository/auth_repository.dart';
import 'package:gymnastic_center/infrastructure/screens/auth/sign_up_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/home/main_screen.dart';
import 'package:gymnastic_center/presentation/widgets/icons/gymnastic_center_icons.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_text_input.dart';

class LoginForm extends StatefulWidget {
  final IAuthRepository authRepository;
  const LoginForm({super.key, required this.authRepository});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String email = '';
  final String password = '';
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.watch<LoginBloc>();
    void onSubmit(IAuthRepository authRepository) {
      final isValid = _formKey.currentState!.validate();
      if (!isValid) return;
      final loginState = loginBloc.state;
      authRepository.login({
        'email': loginState.email,
        'password': loginState.password,
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    }

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Login",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 40),
          CustomTextInput(
            onChanged: (value) {
              loginBloc.add(EmailChanged(value));
            },
            validator: (value) {
              if (value == null || value.isEmpty) return 'Required Field';
              if (value.trim().isEmpty) return 'Required Field';
              final emailRegExp = RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              );
              if (!emailRegExp.hasMatch(value)) return 'Should be an email';
              return null;
            },
            prefixIcon: const Padding(
              padding: EdgeInsets.only(
                  left: 35, right: 15), // add padding to adjust icon
              child: Icon(
                GymnasticCenter.email,
                size: 15,
              ),
            ),
            labelText: 'Email',
            hintText: 'email@gmail.com',
          ),
          const SizedBox(height: 25),
          CustomTextInput(
            onChanged: (value) {
              loginBloc.add(PasswordChanged(value));
            },
            validator: (value) {
              if (value == null || value.isEmpty) return 'Required Field';
              if (value.trim().isEmpty) return 'Required Field';
              if (value.length < 6) return '6 characters minimum';

              return null;
            },
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isObscured = !isObscured;
                  });
                },
                icon:
                    Icon(isObscured ? Icons.visibility : Icons.visibility_off)),
            labelText: 'Password',
            hintText: 'Enter your password',
            obscureText: isObscured,
          ),
          const SizedBox(height: 25),
          BrandButton(
              buttonText: 'Login', onPressed: () => onSubmit(authRepository)),
          TextButton(
            onPressed: () {
              // Handle forgot password link
            },
            child: const Text("Forgot your password?",
                style: TextStyle(fontSize: 15)),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account? ",
                  style: TextStyle(fontSize: 18)),
              TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpScreen()),
                  );
                },
                child: const Text("Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
