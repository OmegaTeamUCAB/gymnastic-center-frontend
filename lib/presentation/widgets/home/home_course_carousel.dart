import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/all_courses/all_courses_bloc.dart';
import 'package:gymnastic_center/application/use_cases/course/get_all_courses.use_case.dart';
import 'package:gymnastic_center/infrastructure/repositories/courses/course_repository.dart';
import 'package:gymnastic_center/presentation/widgets/home/course_tile.dart';

class HomeCourseCarousel extends StatelessWidget {
  late final AllCoursesBloc bloc;
  HomeCourseCarousel({super.key}) {
    bloc = AllCoursesBloc(GetAllCoursesUseCase(CourseRepository()));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      child: BlocProvider(
        create: (context) {
          bloc.add(AllCoursesRequested());
          return bloc;
        },
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
              return PageView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  (state.courses.length / 2)
                      .ceil(), // Calculate the number of columns
                  (index) {
                    // Calculate the indices of the courses for this column
                    int firstCourseIndex = index * 2;
                    int secondCourseIndex = index * 2 + 1;

                    return Column(
                      children: [
                        CourseTile(course: state.courses[firstCourseIndex]),
                        // Check if there is a second course for this column
                        if (secondCourseIndex < state.courses.length)
                          CourseTile(course: state.courses[secondCourseIndex]),
                      ],
                    );
                  },
                ),
              );
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
