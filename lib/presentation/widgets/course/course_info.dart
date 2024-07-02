import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/presentation/screens/trainer_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';
import 'package:gymnastic_center/presentation/widgets/course/course_detail_info_card.dart';
import 'package:gymnastic_center/presentation/widgets/course/lesson_list.dart';
import 'package:gymnastic_center/presentation/screens/course/lesson_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gymnastic_center/presentation/widgets/profile/profile_avatar.dart';

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
          color: Theme.of(context).colorScheme.surface,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ProfileAvatar(
                            radius: 20,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TrainerScreen(
                                      trainerId: course.trainer['id']),
                                ),
                              );
                            },
                            fullName: course.trainer['name'],
                            urlImage: course.trainer['image'],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TrainerScreen(
                                      trainerId: course.trainer['id']),
                                ),
                              );
                            },
                            child: Text(
                              course.trainer['name'],
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
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
                text: AppLocalizations.of(context)!.startCourse,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LessonScreen(
                              lessonId: course.lessons!.first.id,
                            )),
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
              Text('${course.lessons!.length} Lessons',
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onPrimary)),
              const SizedBox(
                height: 24,
              ),
              LessonList(lessons: course.lessons!),
              const SizedBox(
                height: 120,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
