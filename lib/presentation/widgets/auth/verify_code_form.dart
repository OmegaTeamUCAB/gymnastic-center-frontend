import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:gymnastic_center/application/blocs/auth/auth_bloc.dart';
import 'package:gymnastic_center/presentation/screens/auth/reset_password_screen.dart';
import 'package:pinput/pinput.dart';

class VerifyCodeForm extends StatefulWidget {
  final String email;
  const VerifyCodeForm({super.key, required this.email});

  @override
  State<VerifyCodeForm> createState() => _VerifyCodeFormState();
}

class _VerifyCodeFormState extends State<VerifyCodeForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String verificationCode = '';
  @override
  Widget build(BuildContext context) {
    final authBloc = context.watch<AuthBloc>();
    const defaultPinTheme = PinTheme(
        width: 60,
        height: 60,
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        textStyle: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4F14A0),
        ));
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Verification Code",
            style: TextStyle(
                color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 25),
          Column(
            children: [
              const Text(
                'Please type the verification code sent to',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Text(
                widget.email,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Pinput(
            length: 4,
            defaultPinTheme: defaultPinTheme,
            onChanged: (value) {
              verificationCode = value;
            },
            onCompleted: (value) {
              authBloc.add(CodeVerified(email: widget.email, code: value));
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ResetPasswordScreen(email: widget.email)),
              );
              print('THIS IS THE CODE: $verificationCode ');
            },
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'I did not receive a code! ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {},
                child: const Text("Please resend",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
