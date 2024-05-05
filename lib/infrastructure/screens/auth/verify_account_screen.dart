import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/auth/verify_account_form.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_gradient.dart';

class VerifyAccountScreen extends StatelessWidget {
  const VerifyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color:
                Theme.of(context).colorScheme.primary, //change your color here
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
                top: 0,
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
            Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: -70,
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
                            child: const Stack(
                              children: [
                                SingleChildScrollView(
                                  child: VerifyAccountForm(),
                                ),
                              ],
                            )),
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
