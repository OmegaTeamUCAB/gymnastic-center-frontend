import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/data/dummy_plan_setup_step.dart';
import 'package:gymnastic_center/presentation/screens/auth/welcome_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';
import 'package:gymnastic_center/presentation/widgets/plan-setup/plan_setup_step.dart';
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
    final List<String> imagePaths = [
      'assets/plan-setup/goals.png',
      'assets/plan-setup/interests.png',
      'assets/plan-setup/weights.png',
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WelcomeScreen()));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.primary,
            )),
      ),
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
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 15,
                ),
                Image.asset(imagePaths[index], height: 250),
                const Spacer(),
                PlanSetupStep(
                    options: step['options'], isRadio: step['type'] == 'radio'),
                const SizedBox(height: 110),
              ],
            );
          },
        ),
      ),
    );
  }
}