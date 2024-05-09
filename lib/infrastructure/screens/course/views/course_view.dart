import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/course/course_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gymnastic_center/presentation/widgets/course/course_card.dart';
import 'package:gymnastic_center/infrastructure/screens/course/course_detail_screen.dart';

class CourseView extends StatelessWidget {
  final String? categoryId;
  const CourseView({super.key, this.categoryId});

  @override
  Widget build(BuildContext context) {
    final courseList = context.watch<CourseBloc>().state.currentCourses;
    final isLoading = context.watch<CourseBloc>().state.isLoading;
    final currentCategory = context.watch<CourseBloc>().state.currentCategory;

    if (isLoading)
      return Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      );
    if (courseList.isEmpty)
      return Center(
        child: Text('No hay cursos para esta categoria'),
      );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Courses', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 30))),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              itemCount: courseList.length,
              itemBuilder: (context, index) {
                final course = courseList[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CourseDetailScreen(courseId: course.id)),
              );
                  },
                  child: CourseCard(
                    courseId: course.id,
                    courseImageUrl: course.imageUrl,
                  ),
                );
              },
            ),
          ))
        ],
      ),
    );
  }
}
