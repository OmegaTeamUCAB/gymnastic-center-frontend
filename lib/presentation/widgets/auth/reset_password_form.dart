import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/auth/auth_bloc.dart';
import 'package:gymnastic_center/presentation/screens/auth/password_reset_success_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_text_input.dart';

class ResetPasswordForm extends StatefulWidget {
  final String email;
  final String code;
  const ResetPasswordForm({super.key, required this.email, required this.code});

  @override
  State<ResetPasswordForm> createState() => ResetPasswordFormState();
}

class ResetPasswordFormState extends State<ResetPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isObscuredFirst = true;
  bool isObscuredSecond = true;
  String newPassword = '';
  String newPasswordRepeat = '';

  @override
  Widget build(BuildContext context) {
    final authBloc = context.watch<AuthBloc>();
    void onSubmit() {
      final isValid = _formKey.currentState!.validate();
      if (!isValid) return;
      authBloc.add(PasswordReset(
          email: widget.email, newPassword: newPassword, code: widget.code));
    }

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is PasswordResetSuccess) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const PasswordResetSuccessScreen(),
              ));
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Reset Password",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 15),
              Text(
                  "Set a new password for your account. Make sure it's at least 8 characters long.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontSize: 17,
                  )),
              const SizedBox(height: 40),
              CustomTextInput(
                onChanged: (value) {
                  newPassword = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required Field';
                  if (value.trim().isEmpty) return 'Required Field';
                  if (value.length < 8) return '8 characters minimum';

                  return null;
                },
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isObscuredFirst = !isObscuredFirst;
                      });
                    },
                    icon: Icon(isObscuredFirst
                        ? Icons.visibility
                        : Icons.visibility_off)),
                labelText: 'New Password',
                hintText: 'Enter your password',
                obscureText: isObscuredFirst,
              ),
              const SizedBox(height: 35),
              CustomTextInput(
                onChanged: (value) {
                  newPasswordRepeat = value;
                },
                validator: (value) {
                  if (value != newPassword) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isObscuredSecond = !isObscuredSecond;
                      });
                    },
                    icon: Icon(isObscuredSecond
                        ? Icons.visibility
                        : Icons.visibility_off)),
                labelText: 'Confirm Password',
                hintText: 'Enter your password',
                obscureText: isObscuredSecond,
              ),
              const SizedBox(height: 35),
              authBloc.state is AuthLoading
                  ? const CircularProgressIndicator()
                  : BrandButton(
                      onPressed: onSubmit,
                      text: 'Save',
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
