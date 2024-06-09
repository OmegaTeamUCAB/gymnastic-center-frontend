import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/courses_by_category/courses_by_category_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/common/no_results.dart';
import 'package:gymnastic_center/presentation/widgets/course/all_courses_list.dart';

class CoursesByCategoryView extends StatelessWidget {
  final String categoryId;

  const CoursesByCategoryView({super.key, required this.categoryId});

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
            return CoursesList(courses: state.courses);
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
