import 'package:flutter/material.dart';
import 'package:gymnastic_center/infrastructure/screens/home/main_screen.dart';
import 'package:gymnastic_center/presentation/data/dummy_courses.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';
import 'package:gymnastic_center/presentation/widgets/training/course_option_page_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NewTrainingScreen extends StatefulWidget {
  const NewTrainingScreen({super.key});

  @override
  State<NewTrainingScreen> createState() => _NewTrainingScreenState();
}

class _NewTrainingScreenState extends State<NewTrainingScreen> {
  final PageController pageController = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              //TODO: should come from backend
              children: dummyCourses
                  .map((course) => CourseOptionPageView(course: course))
                  .toList(),
            ),
          ),
          // back button
          Positioned(
            top: 60,
            left: 5,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainScreen()));
                  },
                  icon: Icon(Icons.arrow_back_ios,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
                const Text(
                  'Choose a workout',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          // center this dots
          Positioned(
            bottom: 140,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: dummyCourses.length,
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
            ),
          ),
          // Button
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 330,
                height: 60,
                child: BrandButton(
                  onPressed: () {},
                  child: Text(
                    'Start!',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 24),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
