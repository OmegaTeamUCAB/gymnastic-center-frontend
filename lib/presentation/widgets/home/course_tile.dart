import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/course/course_bloc.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/presentation/screens/course/course_detail_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_progress_indicator.dart';
import 'package:gymnastic_center/presentation/widgets/common/new_chip.dart';

class CourseTile extends StatelessWidget {
  final Course course;
  final bool showBorder;
  const CourseTile({super.key, required this.course, this.showBorder = false});

  @override
  Widget build(BuildContext context) {
    final DateTime createdAtDate = DateTime.parse(course.createdAt);
    final daysDifference = DateTime.now().difference(createdAtDate).inDays;
    return Container(
      padding: const EdgeInsets.only(right: 20),
      child: InkWell(
        onTap: () {
          final courseBloc = BlocProvider.of<CourseBloc>(context);
          courseBloc.add(CourseClicked(courseId: course.id));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseDetailScreen(courseId: course.id),
            ),
          );
        },
        splashColor: Theme.of(context).colorScheme.surfaceTint,
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          height: 130,
          decoration: showBorder
              ? BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                      width: 0.5,
                    ),
                  ),
                )
              : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(course.imageUrl,
                          height: 110, width: 120, fit: BoxFit.cover),
                    ),
                    //Validador de si el curso es nue
                    if (daysDifference < 2)
                      const Positioned(
                        bottom: 5,
                        left: 5,
                        child: NewChip(),
                      ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        course.trainer,
                      ),
                      Text(
                        course.category,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                course.percent != null
                    ? CustomProgressIndicator(
                        percent: course.percent!,
                        size: 40,
                      )
                    : const Icon(
                        Icons.chevron_right,
                        size: 30,
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
