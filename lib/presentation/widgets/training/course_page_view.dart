import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/presentation/screens/course/course_detail_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_back_button.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';
import 'package:gymnastic_center/presentation/widgets/training/course_option_page_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CoursePageView extends StatefulWidget {
  final List<Course> courses;

  const CoursePageView({super.key, required this.courses});

  @override
  CoursePageViewState createState() => CoursePageViewState();
}

class CoursePageViewState extends State<CoursePageView> {
  late final PageController _pageController;
  int _currentPage = 0;

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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          children: widget.courses
              .map((course) =>
                  SizedBox(child: CourseOptionPageView(course: course)))
              .toList(),
        ),

        // back button
        Positioned(
          top: 60,
          left: 5,
          child: Row(
            children: [
              BrandBackButton(
                color: Theme.of(context).colorScheme.onPrimary,
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
        Positioned(
          bottom: 140,
          left: 0,
          right: 0,
          child: Center(
            child: SmoothPageIndicator(
              controller: _pageController,
              count: widget.courses.length,
              onDotClicked: (index) => _pageController.animateToPage(index,
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CourseDetailScreen(
                          courseId: widget.courses[_currentPage].id),
                    ),
                  );
                },
                text: 'Select',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
