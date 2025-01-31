import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/auth/auth_bloc.dart';
import 'package:gymnastic_center/application/blocs/sign_up/sign_up_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/icons/gymnastic_center_icons.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool? isTermsChecked = false;
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    final signUpBloc = context.watch<SignUpBloc>();
    final authBloc = context.watch<AuthBloc>();
    void onSubmit() {
      final isValid = _formKey.currentState!.validate();
      if (!isValid) return;
      authBloc.add(SignedUp(
          fullName: signUpBloc.state.fullName,
          email: signUpBloc.state.email,
          phoneNumber: signUpBloc.state.phoneNumber,
          password: signUpBloc.state.password));
    }

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.signUp,
            style: const TextStyle(
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
              signUpBloc.add(FullNameChanged(value));
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
              labelText: AppLocalizations.of(context)!.name,
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
              prefixIcon: const Padding(
                padding: EdgeInsets.only(
                    left: 35, right: 15), // add padding to adjust icon
                child: Icon(
                  GymnasticCenter.email,
                  size: 15,
                ),
              ),
              prefixIconColor: const Color.fromARGB(106, 255, 255, 255),
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
              labelText: AppLocalizations.of(context)!.email,
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
              signUpBloc.add(PhoneNumberChanged(value));
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
              labelText: AppLocalizations.of(context)!.phone,
              hintText: '0412 3333333',
            ),
          ),
          const SizedBox(height: 25),
          TextFormField(
            cursorColor: Colors.white,
            obscureText: isObscured,
            style: const TextStyle(fontSize: 16, color: Colors.white),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Required Field';
              if (value.trim().isEmpty) return 'Required Field';
              if (value.length < 8) return '8 characters minimum';
              return null;
            },
            onChanged: (value) {
              signUpBloc.add(PasswordChanged(value));
            },
            decoration: InputDecoration(
              errorStyle: TextStyle(color: Colors.red[100]),
              labelStyle: const TextStyle(fontSize: 18, color: Colors.white),
              hintStyle: const TextStyle(color: Color(0xFFC4C4C4)),
              suffixIconColor: Colors.white,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isObscured = !isObscured;
                    });
                  },
                  icon: Icon(
                      isObscured ? Icons.visibility : Icons.visibility_off)),
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
              labelText: AppLocalizations.of(context)!.password,
              hintText: '8 digits minimum',
            ),
          ),
          const SizedBox(height: 35),
          authBloc.state is AuthLoading
              ? const CircularProgressIndicator()
              : BrandButton(
                  isVariant: true,
                  onPressed: onSubmit,
                  text: 'Sign up',
                )
        ],
      ),
    );
  }
}
