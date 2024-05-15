import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';
import 'package:gymnastic_center/presentation/widgets/training/course_option_page_view.dart';

class NewTrainingScreen extends StatefulWidget {
  const NewTrainingScreen({super.key});

  @override
  State<NewTrainingScreen> createState() => _NewTrainingScreenState();
}

class _NewTrainingScreenState extends State<NewTrainingScreen> {
  final PageController controller = PageController();
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
              controller: controller,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              children: const <Widget>[
                CourseOptionPageView(),
                CourseOptionPageView(),
                CourseOptionPageView(),
              ],
            ),
          ),
          // Title
          const Positioned(
            top: 80, // adjust the value as needed
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Choose a workout:',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 140,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  3,
                  (index) => Container(
                        margin: const EdgeInsets.all(4.0),
                        width: 12.0,
                        height: 12.0,
                        decoration: BoxDecoration(
                          // takes a while when going from one page to another
                          color: currentPage == index
                              ? Colors.deepPurple
                              : Theme.of(context).colorScheme.outline,
                          shape: BoxShape.circle,
                        ),
                      )),
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
