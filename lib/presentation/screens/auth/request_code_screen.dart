import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/auth/request_code_form.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_back_button.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_gradient.dart';

class RequestCodeScreen extends StatelessWidget {
  const RequestCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(gradient: brandGradient),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                    top: 90,
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/logo_white.png',
                        width: 205,
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
                const Positioned(
                    top: 50,
                    left: 0,
                    child: BrandBackButton(color: Colors.white)),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                        bottom: -210,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 50, horizontal: 150),
                            width: 685.0,
                            height: 685.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                            child: const SingleChildScrollView(
                              child: RequestCodeForm(),
                            ),
                          ),
                        )),
                  ],
                )
              ],
            )));
  }
}
