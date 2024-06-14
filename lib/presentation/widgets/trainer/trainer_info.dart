import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/screens/blog/all_blogs_by_trainer_screen.dart';
import 'package:gymnastic_center/presentation/screens/blog/blog_by_trainer_carousel.dart';
import 'package:gymnastic_center/presentation/screens/course/all_courses_by_trainer_screen.dart';
import 'package:gymnastic_center/presentation/screens/course/course_by_trainer_carousel.dart';
import 'package:gymnastic_center/presentation/widgets/common/content_header.dart';

class TrainerInfo extends StatelessWidget {
  final Map trainer;
  final ScrollController scrollController;
  const TrainerInfo(
      {super.key, required this.trainer, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    String id = trainer['id'];
    String name = trainer['name'];

    return SingleChildScrollView(
      controller: scrollController,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        margin: const EdgeInsets.only(top: 365),
        child: Column(
          children: [
            Center(child: Text(' $name\'s fitness')),
            const SizedBox(height: 25),
            ContentHeader(
                title: '$name\'s Courses',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AllCoursesByTrainerScreen(trainer: trainer)),
                  );
                }),
            CourseByTrainerCarousel(trainerId: id),
            ContentHeader(
                title: '$name\'s Blogs',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AllBlogsByTrainerScreen(trainer: trainer)),
                  );
                }),
            BlogByTrainerCarousel(trainerId: id),
            const SizedBox(
              height: 210,
            ),
          ],
        ),
      ),
    );
  }
}
