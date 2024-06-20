import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/all_courses/all_courses_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/common/no_results.dart';
import 'package:gymnastic_center/presentation/widgets/course/courses_page_view.dart';

class HomeCourseCarousel extends StatelessWidget {
  const HomeCourseCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final allCoursesBloc = GetIt.instance<AllCoursesBloc>();
    allCoursesBloc.add(const AllCoursesRequested(1));

    return SizedBox(
      height: 260,
      child: BlocProvider<AllCoursesBloc>.value(
        value: allCoursesBloc,
        child: BlocBuilder<AllCoursesBloc, AllCoursesState>(
          builder: (context, state) {
            if (state is AllCoursesLoading) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (state is AllCoursesFailed) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is AllCoursesSuccess) {
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
