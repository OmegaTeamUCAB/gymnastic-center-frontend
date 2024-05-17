import 'package:flutter/material.dart';
import 'package:gymnastic_center/infrastructure/screens/auth/welcome_screen.dart';
import 'package:gymnastic_center/presentation/data/dummy_plan_setup_step.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';
import 'package:gymnastic_center/presentation/widgets/plan-setup/plan_setup_step.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:gymnastic_center/presentation/widgets/onboarding/onboarding_items.dart';

class PlanSetupScreen extends StatefulWidget {
  const PlanSetupScreen({super.key});

  @override
  State<PlanSetupScreen> createState() => _PlanSetupScreenState();
}

class _PlanSetupScreenState extends State<PlanSetupScreen> {
  final pages = OnboardingItems();
  final _pageController = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Theme.of(context).colorScheme.background,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: isLastPage
            ? BrandButton(
                child: Text(
                  'Get Started',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WelcomeScreen()));
                },
              )
            : BrandButton(
                child: Text(
                  'Next',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 20),
                ),
                onPressed: () {
                  if (_pageController.hasClients &&
                      _pageController.page! < dummyPlanSetupSteps.length - 1) {
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut);
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WelcomeScreen()),
                    );
                  }
                },
              ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(), // Disable scrolling
          itemCount: dummyPlanSetupSteps.length,
          itemBuilder: (context, index) {
            var step = dummyPlanSetupSteps[index];
            return Column(
              children: <Widget>[
                Text(step['title'],
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                PlanSetupStep(
                    options: step['options'], isRadio: step['type'] == 'radio'),
              ],
            );
          },
        ), //use the dummy plan setup steps
      ),
    );
  }
}
