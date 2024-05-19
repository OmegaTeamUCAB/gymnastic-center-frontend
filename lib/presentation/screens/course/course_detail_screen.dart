import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/course/course_bloc.dart';
import 'package:gymnastic_center/presentation/screens/course/course_content_screen.dart';
import 'package:gymnastic_center/presentation/widgets/course/course_carrusel.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';
import 'package:gymnastic_center/presentation/widgets/course/course_detail_info_card.dart';

class CourseDetailScreen extends StatefulWidget {
  final String courseId;
  const CourseDetailScreen({super.key, required this.courseId});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<CourseBloc>().add(GetCourseById(courseId: widget.courseId));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final courseIsLoading = context.watch<CourseBloc>().state.isLoading;
    final course = context.watch<CourseBloc>().state.course;
    final popularCourses = context.watch<CourseBloc>().state.popularCourses;

    if (courseIsLoading) {
      return const Scaffold(
          body: Center(
              child: CircularProgressIndicator(
        strokeWidth: 2,
      )));
    }
    if (course == null) {
      return const Center(
        child: Text('No existe el curso'),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 350),
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 100),
                child: GestureDetector(
                  onDoubleTap: () {},
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(60)),
                    child: Image.network(
                      course.imageUrl,
                      height: 350,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress != null) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return child;
                        }
                      },
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              CustomAppBar(
                content: Row(
                  children: [
                    IconButton(
                        iconSize: 30,
                        onPressed: () => Navigator.pop(context),
                        color: Colors.white,
                        icon: const Icon(Icons.chevron_left)),
                    Text(
                      course.name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          )),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const Divider(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CourseDetailInfoCard(
                  title: 'Level',
                  captionNumber: course.level.toString(),
                  iconData: Icons.menu,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CourseContentScreen(course: course)),
                    );
                  },
                ),
                CourseDetailInfoCard(
                  title: 'Weeks',
                  onPressed: () {},
                  captionNumber: course.weeks.toString(),
                  iconData: Icons.calendar_month_sharp,
                ),
                CourseDetailInfoCard(
                  title: 'Mins',
                  onPressed: () {},
                  captionNumber: course.minutes.toString(),
                  iconData: Icons.watch_later_outlined,
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            //why is this text centered?
            Text('More Most Popular Courses',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 20)),
            const SizedBox(
              height: 12,
            ),
            CourseCarrusel(
              width: double.infinity,
              courses: popularCourses,
              onTap: (courseId) {
                context
                    .read<CourseBloc>()
                    .add(GetCourseById(courseId: courseId));
              },
            )
          ],
        ),
      ),
    );
  }
}
