import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/presentation/screens/course/course_content_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';
import 'package:gymnastic_center/presentation/widgets/course/course_detail_info_card.dart';

class CourseInfo extends StatelessWidget {
  final Course course;
  final ScrollController scrollController;
  const CourseInfo(
      {super.key, required this.course, required this.scrollController});

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
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      course.name,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      'John Doe',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CourseDetailInfoCard(
                    label: 'Level ${course.level.toString()}',
                    iconData: Icons.menu,
                  ),
                  CourseDetailInfoCard(
                    label: '${course.weeks.toString()} Weeks',
                    iconData: Icons.calendar_month_sharp,
                  ),
                  CourseDetailInfoCard(
                    label: '${course.minutes.toString()} mins',
                    iconData: Icons.watch_later_outlined,
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              BrandButton(
                text: 'Start course',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CourseContentScreen(course: course)),
                  );
                },
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                course.description!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const Divider(
                height: 30,
              ),
              Text('15 Lessons',
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onPrimary)),
              const SizedBox(
                height: 12,
              ),
              const Placeholder(
                fallbackHeight: 800,
                fallbackWidth: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
