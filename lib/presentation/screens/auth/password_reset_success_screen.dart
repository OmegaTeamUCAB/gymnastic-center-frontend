import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/screens/auth/login_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_gradient.dart';

class PasswordResetSuccessScreen extends StatelessWidget {
  const PasswordResetSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(gradient: brandGradient),
            child: Stack(alignment: Alignment.bottomCenter, children: [
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Password Changed',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Your password has been changed successfully.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        )),
                    const SizedBox(
                      height: 50,
                    ),
                    const CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.check_rounded,
                        color: Colors.deepPurple,
                        size: 80,
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    BrandButton(
                      isVariant: true,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      text: 'Back to Login',
                    )
                  ],
                ),
              ),
            ])));
  }
}
