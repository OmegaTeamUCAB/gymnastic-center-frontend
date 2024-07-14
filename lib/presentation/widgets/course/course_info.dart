import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/lesson/lesson_bloc.dart';
import 'package:gymnastic_center/application/blocs/progress/progress_bloc.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/presentation/screens/trainer_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_progress_indicator.dart';
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

  void _jumpToIndex(int index) {
    const double itemHeight = 50;
    scrollController.jumpTo(index * itemHeight);
  }

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
                    label: AppLocalizations.of(context)!
                        .level(course.level.toString()),
                    iconData: Icons.menu,
                  ),
                  CourseDetailInfoCard(
                    label: AppLocalizations.of(context)!
                        .weeks(course.weeks.toString()),
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
              BlocBuilder<ProgressBloc, ProgressState>(
                builder: (context, state) {
                  if (state.progressStatus == ProgressStatus.loaded ||
                      (state.progress.lessonProgress.isNotEmpty)) {
                    return TweenAnimationBuilder(
                      tween: Tween<double>(
                          begin: 0,
                          end: context
                              .watch<ProgressBloc>()
                              .state
                              .progress
                              .percent),
                      duration: const Duration(milliseconds: 900),
                      builder: (context, double value, child) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            CustomProgressIndicator(
                              size: 45,
                              percent: value,
                            ),
                            FadeIn(
                                child: Text(
                              'Completed',
                              style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  color: Theme.of(context).colorScheme.primary),
                            )),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        );
                      },
                    );
                  }
                  if (state.progressStatus == ProgressStatus.unitialized) {
                    return BrandButton(
                      text: AppLocalizations.of(context)!.startCourse,
                      onPressed: () async {
                        await GetIt.instance<ProgressBloc>().startCourse(
                            StartCourse(courseId: course.id),
                            course.lessons!.first.id);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              settings: const RouteSettings(name: "/lesson"),
                              builder: (context) => LessonScreen(
                                    lessonId: course.lessons!.first.id,
                                  )),
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
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
              Text(
                  AppLocalizations.of(context)!
                      .lessons(course.lessons!.length.toString()),
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onPrimary)),
              const SizedBox(
                height: 24,
              ),
              LessonList(
                lessons: GetIt.instance<LessonBloc>().state.courseLessons,
                onTap: (index) {},
              ),
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
