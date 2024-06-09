import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/courses_by_category/courses_by_category_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/common/no_results.dart';
import 'package:gymnastic_center/presentation/widgets/home/course_tile.dart';

class CoursesByCategoryList extends StatelessWidget {
  final String categoryId;

  const CoursesByCategoryList({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final coursesByCategoryBloc = GetIt.instance<CoursesByCategoryBloc>();
    coursesByCategoryBloc
        .add(CoursesByCategoryRequested(categoryId: categoryId));
    return BlocProvider<CoursesByCategoryBloc>.value(
      value: coursesByCategoryBloc,
      child: BlocBuilder<CoursesByCategoryBloc, CoursesByCategoryState>(
        builder: (context, state) {
          if (state is CoursesByCategoryLoading) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 25),
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is CoursesByCategoryFailed) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is CoursesByCategorySuccess) {
            if (state.courses.isEmpty) {
              return const Center(
                child: NoResults(),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    '${state.courses.length} Courses',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.courses.length,
                    itemBuilder: (context, index) {
                      return CourseTile(course: state.courses[index]);
                    },
                  ),
                ),
                const SizedBox(
                  height: 60,
                )
              ],
            );
          } else {
            return const Center(
              child: Text('Error'),
            );
          }
        },
      ),
    );
  }
}
