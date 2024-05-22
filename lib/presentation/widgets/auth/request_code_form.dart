import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/auth/auth_bloc.dart';
import 'package:gymnastic_center/application/blocs/login/login_bloc.dart';
import 'package:gymnastic_center/presentation/screens/auth/sign_up_screen.dart';
import 'package:gymnastic_center/presentation/widgets/icons/gymnastic_center_icons.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_text_input.dart';

class RequestCodeForm extends StatefulWidget {
  const RequestCodeForm({super.key});

  @override
  State<RequestCodeForm> createState() => _RequestCodeFormState();
}

class _RequestCodeFormState extends State<RequestCodeForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.watch<LoginBloc>();
    final authBloc = context.watch<AuthBloc>();
    void onSubmit() {
      final isValid = _formKey.currentState!.validate();
      if (!isValid) return;
      authBloc.add(LoggedIn(
          email: loginBloc.state.email, password: loginBloc.state.password));
    }

    return Form(
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
                "Please enter your email address. You will get a link to create new password by email.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 17,
                )),
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
              hintText: 'yourEmail@gmail.com',
            ),
            const SizedBox(height: 30),
            authBloc.state is AuthLoading
                ? const CircularProgressIndicator()
                : BrandButton(
                    onPressed: onSubmit,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        'Send New Password',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 20),
                      ),
                    )),
          ],
        ),
      ),
    );
  }
}
