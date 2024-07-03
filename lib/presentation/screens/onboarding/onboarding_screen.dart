import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/infrastructure/data-sources/local/secure_storage.dart';
import 'package:gymnastic_center/presentation/screens/home/main_screen.dart';
import 'package:gymnastic_center/presentation/widgets/onboarding/onboarding_info.dart';
import 'package:gymnastic_center/presentation/widgets/onboarding/onboarding_items.dart';
import 'package:gymnastic_center/presentation/widgets/onboarding/onboarding_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPageScreen extends StatefulWidget {
  const OnBoardingPageScreen({super.key});
  @override
  OnBoardingPageScreenState createState() => OnBoardingPageScreenState();
}

class OnBoardingPageScreenState extends State<OnBoardingPageScreen> {
  final List<OnboardingInfo> onboardingInfo = OnboardingItems().items;
  late final PageController _pageController;
  bool lastPage = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void skipToPage() {
    final pref = GetIt.instance.get<SecureStorage>();
    pref.setKeyValue('onboarding', 'true');
    GetIt.instance.unregister<bool>();
    GetIt.instance.registerSingleton<bool>(true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  void skipToNext() {
    if (!lastPage) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 800), curve: Curves.easeOut);
    } else {
      skipToPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          lastPage = index == onboardingInfo.length - 1;
          setState(() {});
        },
        itemCount: onboardingInfo.length,
        itemBuilder: (context, index) {
          final onBoarding = onboardingInfo[index];
          return OnBoardingPage(
            onBoardingInfo: onBoarding,
            onTap: skipToNext,
            lastPage: lastPage,
          );
        },
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: (lastPage)
            ? const SizedBox()
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Divider(
                      thickness: 0.4,
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: skipToPage,
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.black54
                                  : Colors.white,
                            ),
                          ),
                        ),
                        SmoothPageIndicator(
                          controller: _pageController,
                          count: onboardingInfo.length,
                          onDotClicked: (index) =>
                              _pageController.animateToPage(index,
                                  duration: const Duration(milliseconds: 800),
                                  curve: Curves.easeOut),
                          effect: SwapEffect(
                            dotHeight: 12,
                            dotWidth: 12,
                            dotColor: Theme.of(context).colorScheme.outline,
                            activeDotColor: Colors.deepPurple,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
