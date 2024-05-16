import 'package:flutter/material.dart';
import 'package:gymnastic_center/infrastructure/screens/home/main_screen.dart';
import 'package:gymnastic_center/presentation/data/dummy_courses.dart';
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
          // Title
          Positioned(
            bottom: 140,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                dummyCourses.length, //TODO: should come from backend
                (index) => Container(
                  margin: const EdgeInsets.all(4.0),
                  width: 12.0,
                  height: 12.0,
                  decoration: BoxDecoration(
                    color: currentPage == index
                        ? Colors.deepPurple
                        : Theme.of(context).colorScheme.outline,
                    shape: BoxShape.circle,
                  ),
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
