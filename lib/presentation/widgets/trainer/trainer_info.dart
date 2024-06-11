import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/screens/blog/all_blogs_screen.dart';
import 'package:gymnastic_center/presentation/screens/course/all_courses_screen.dart';
import 'package:gymnastic_center/presentation/widgets/blog/blog_carousel.dart';
import 'package:gymnastic_center/presentation/widgets/home/home_course_carousel.dart';

class TrainerInfo extends StatelessWidget {
  final String trainer;
  final ScrollController scrollController;
  const TrainerInfo(
      {super.key, required this.trainer, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        margin: const EdgeInsets.only(top: 365),
        child: Column(
          children: [
            const Center(child: Text('Sasha fitness')),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Text(
                    'Sasha\'s Courses',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AllCoursesScreen()),
                      );
                    },
                    child: const Text(
                      'Show all',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
            const HomeCourseCarousel(),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Text(
                    'Sasha\'s Blogs',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AllBlogsScreen()),
                      );
                    },
                    child: const Text(
                      'Show all',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
            const BlogCarousel(),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
