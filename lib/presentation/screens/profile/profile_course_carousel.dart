import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/viewed_courses/viewed_courses_state.dart';
import 'package:gymnastic_center/presentation/widgets/common/no_results.dart';
import 'package:gymnastic_center/presentation/widgets/course/courses_page_view.dart';
import 'package:gymnastic_center/application/blocs/viewed_courses/viewed_courses_bloc.dart';

class ProfileCourseCarousel extends StatelessWidget {
  const ProfileCourseCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final allCoursesBloc = GetIt.instance<ViewedCoursesBloc>();
    allCoursesBloc.add(const ViewedCoursesRequested(1));

    return SizedBox(
      height: 260,
      child: BlocProvider<ViewedCoursesBloc>.value(
        value: allCoursesBloc,
        child: BlocBuilder<ViewedCoursesBloc, ViewedCoursesState>(
          builder: (context, state) {
            if (state is ViewedCoursesLoading) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (state is ViewedCoursesFailed) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is ViewedCoursesSuccess) {
              if (state.courses.isEmpty) {
                return const Center(
                  child: NoResults(message: 'No courses found'),
                );
              }

              return CoursesPageView(courses: state.courses);
            } else {
              return const Center(
                child: Text('Error'),
              );
            }
          },
        ),
      ),
    );
  }
}
