import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/application/blocs/sign_up/sign_up_bloc.dart';
import 'package:flutter_template/infrastructure/presentation/screens/auth/verify_account_screen.dart';
import 'package:flutter_template/presentation/widgets/ui/brand_button.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name = '';
  String phone = '';
  String email = '';
  String password = '';
  bool? isTermsChecked = false;

  @override
  Widget build(BuildContext context) {
    final signUpBloc = context.watch<SignUpBloc>();
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Sign Up",
            style: TextStyle(
                color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 25),
          TextFormField(
            cursorColor: Colors.white,
            style: const TextStyle(fontSize: 16, color: Colors.white),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Required Field';
              if (value.trim().isEmpty) return 'Required Field';
              if (value.length < 3) return '3 characters minimum';

              return null;
            },
            onChanged: (value) {
              signUpBloc.add(NameChanged(value));
            },
            decoration: InputDecoration(
              errorStyle: TextStyle(color: Colors.red[100]),
              labelStyle: const TextStyle(fontSize: 18, color: Colors.white),
              hintStyle: const TextStyle(color: Color(0xFFC4C4C4)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: const BorderSide(color: Colors.white),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 35),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(100),
              ),
              labelText: 'Full Name',
              hintText: 'Enter your name',
            ),
          ),
          const SizedBox(height: 25),
          TextFormField(
            cursorColor: Colors.white,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(fontSize: 16, color: Colors.white),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Required Field';
              if (value.trim().isEmpty) return 'Required Field';
              final emailRegExp = RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              );
              if (!emailRegExp.hasMatch(value)) return 'Should be an email';
              return null;
            },
            onChanged: (value) {
              signUpBloc.add(EmailChanged(value));
            },
            decoration: InputDecoration(
              errorStyle: TextStyle(color: Colors.red[100]),
              labelStyle: const TextStyle(fontSize: 18, color: Colors.white),
              hintStyle: const TextStyle(color: Color(0xFFC4C4C4)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: const BorderSide(color: Colors.white),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 35),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(100),
              ),
              labelText: 'Email',
              hintText: 'email@email.com',
            ),
          ),
          const SizedBox(height: 25),
          TextFormField(
            cursorColor: Colors.white,
            keyboardType: TextInputType.phone,
            style: const TextStyle(fontSize: 16, color: Colors.white),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Required Field';
              if (value.trim().isEmpty) return 'Required Field';

              return null;
            },
            onChanged: (value) {
              signUpBloc.add(PhoneChanged(value));
            },
            decoration: InputDecoration(
              errorStyle: TextStyle(color: Colors.red[100]),
              labelStyle: const TextStyle(fontSize: 18, color: Colors.white),
              hintStyle: const TextStyle(color: Color(0xFFC4C4C4)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: const BorderSide(color: Colors.white),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 35),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(100),
              ),
              labelText: 'Phone',
              hintText: '0412 3333333',
            ),
          ),
          const SizedBox(height: 25),
          TextFormField(
            cursorColor: Colors.white,
            obscureText: true,
            style: const TextStyle(fontSize: 16, color: Colors.white),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Required Field';
              if (value.trim().isEmpty) return 'Required Field';
              if (value.length < 6) return '6 characters minimum';

              return null;
            },
            onChanged: (value) {
              signUpBloc.add(PasswordChanged(value));
            },
            decoration: InputDecoration(
              errorStyle: TextStyle(color: Colors.red[100]),
              labelStyle: const TextStyle(fontSize: 18, color: Colors.white),
              hintStyle: const TextStyle(color: Color(0xFFC4C4C4)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: const BorderSide(color: Colors.white),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 35),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(100),
              ),
              labelText: 'Password',
              hintText: '6 digits minimum',
            ),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                  value: isTermsChecked,
                  checkColor: Colors.white,
                  activeColor: Colors.transparent,
                  side: MaterialStateBorderSide.resolveWith(
                    (states) =>
                        const BorderSide(width: 1.0, color: Colors.white),
                  ),
                  onChanged: (bool? newValue) {
                    setState(() {
                      isTermsChecked = newValue;
                    });
                  }),
              const Text(
                'Yes! Agree all ',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Terms & Conditions',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
          const SizedBox(height: 25),
          BrandButton(
              isDarkMode: true,
              width: double.infinity,
              onPressed: () {
                final isValid = _formKey.currentState!.validate();
                if (!isValid) return;
                signUpBloc.add(FormSubmitted(email, password, name, phone));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const VerifyAccountScreen()),
                );
              },
              child: const Text("Sign up",
                  style: TextStyle(fontSize: 20, color: Color(0xFF4F14A0))))
        ],
      ),
    );
  }
}
