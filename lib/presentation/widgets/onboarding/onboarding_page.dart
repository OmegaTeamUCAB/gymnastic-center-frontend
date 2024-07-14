import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/onboarding/custom_call_to_action_button.dart';
import 'package:gymnastic_center/presentation/widgets/onboarding/onboarding_info.dart';

class OnBoardingPage extends StatelessWidget {
  final OnboardingInfo onBoardingInfo;
  final void Function()? onTap;
  final bool lastPage;

  const OnBoardingPage(
      {super.key,
      required this.onBoardingInfo,
      required this.onTap,
      required this.lastPage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: 280,
          width: double.infinity,
          child: Image.asset(
            onBoardingInfo.image,
            height: 280,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          onBoardingInfo.title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.normal,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          onBoardingInfo.subtitle,
          style: const TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            onBoardingInfo.descriptions,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 17, color: Theme.of(context).colorScheme.onSecondary),
          ),
        ),
        const SizedBox(
          height: 35,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomCallToActionButton(
              onTap: onTap,
              content: (lastPage) ? 'Get Started' : 'Next',
              icon: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
                size: 13,
              )),
        )
      ]),
    );
  }
}
