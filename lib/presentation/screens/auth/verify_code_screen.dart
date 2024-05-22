import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/auth/verify_code_form.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_gradient.dart';

class VerifyCodeScreen extends StatelessWidget {
  final String email;
  const VerifyCodeScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
                top: 80,
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
            Positioned(
                top: 50,
                left: 0,
                child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Theme.of(context).colorScheme.primary)),
            Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: -80,
                  child: Align(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 60, horizontal: 170),
                          width: 720.0,
                          height: 720.0,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/particles.png'),
                                alignment: Alignment.topRight,
                              ),
                              shape: BoxShape.circle,
                              gradient: brandGradient),
                          child: SingleChildScrollView(
                            child: VerifyCodeForm(email: email),
                          ),
                        ),
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
