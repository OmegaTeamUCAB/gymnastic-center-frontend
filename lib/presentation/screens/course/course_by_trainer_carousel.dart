import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/all_course_by_trainer/all_course_by_trainer_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/course/courses_page_view.dart';

class CourseByTrainerCarousel extends StatelessWidget {
  final String trainerId;
  const CourseByTrainerCarousel(this.trainerId, {super.key});

  @override
  Widget build(BuildContext context) {
    final allCourseByTrainerBloc = GetIt.instance<AllCourseByTrainerBloc>();
    allCourseByTrainerBloc.add(AllCourseByTrainerRequested(trainerId, 1));

    return SizedBox(
        height: 270,
        width: double.maxFinite,
        child: BlocProvider<AllCourseByTrainerBloc>.value(
          value: allCourseByTrainerBloc,
          child: BlocBuilder<AllCourseByTrainerBloc, AllCourseByTrainerState>(
              builder: (context, state) {
            if (state is AllCourseByTrainerLoading) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (state is AllCourseByTrainerFailed) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is AllCoursesByTrainerSuccess) {
              return CoursesPageView(courses: state.courses);
            } else {
              return const Center(
                child: Text('Error'),
              );
            }
          }),
        ));
  }
}
