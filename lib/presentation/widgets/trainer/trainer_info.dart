import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/screens/blog/all_blogs_screen.dart';
import 'package:gymnastic_center/presentation/screens/course/all_courses_screen.dart';
import 'package:gymnastic_center/presentation/widgets/home/blog_carousel.dart';
import 'package:gymnastic_center/presentation/widgets/common/content_header.dart';
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
            ContentHeader(
                title: 'Sasha\'s Courses',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AllCoursesScreen()),
                  );
                }),
            const HomeCourseCarousel(),
            ContentHeader(
                title: 'Sasha\'s Blogs',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AllBlogsScreen()),
                  );
                }),
            const HomeBlogCarousel(),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
