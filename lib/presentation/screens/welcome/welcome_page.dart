import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/screens/auth/auth_options_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:gymnastic_center/presentation/widgets/onboarding/onboarding_items.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final controller = OnboardingItems();
  final pageController = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Theme.of(context).colorScheme.background,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: isLastPage
            ? BrandButton(
                child: Text(
                  'Get Started',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 20),
                ),
                onPressed: () {
                  // final pres = await SharedPreferences.getInstance();
                  // pres.setBool("onboarding", true);
                  //After we press get started button this onboarding value become true
                  // same key
                  // if(!mounted)return;
                  //
                  //Modify Main.dart for open just one time
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AuthOptionsScreen()));
                },
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Skip Button
                  TextButton(
                      onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AuthOptionsScreen()),
                            )
                          },
                      child: const Text("Skip",
                          style: TextStyle(
                            fontSize: 16,
                          ))),

                  //indicator
                  SmoothPageIndicator(
                    controller: pageController,
                    count: controller.items.length,
                    onDotClicked: (index) => pageController.animateToPage(index,
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeIn),
                    effect: WormEffect(
                      dotHeight: 12,
                      dotWidth: 12,
                      dotColor: Theme.of(context).colorScheme.outline,
                      activeDotColor: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
            onPageChanged: (index) => setState(
                () => isLastPage = controller.items.length - 1 == index),
            itemCount: controller.items.length,
            controller: pageController,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(controller.items[index].image),
                  const SizedBox(height: 10),
                  Text(
                    controller.items[index].title,
                    style: const TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(controller.items[index].subtitle,
                      style: const TextStyle(
                          fontSize: 38, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(controller.items[index].descriptions,
                      style: const TextStyle(fontSize: 17),
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 30,
                  ),
                  index == controller.items.length - 1
                      ? const SizedBox.shrink()
                      : ElevatedButton.icon(
                          onPressed: () => pageController.nextPage(
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeIn,
                          ),
                          label: const Text("Next"),
                          icon: const Icon(
                            Icons.arrow_circle_right_rounded,
                            color: Colors.deepPurple,
                          ),
                        )
                ],
              );
            }),
      ),
    );
  }
}
