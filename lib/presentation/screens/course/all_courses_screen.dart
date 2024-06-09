import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/all_courses/all_courses_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_back_button.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';
import 'package:gymnastic_center/presentation/widgets/common/no_results.dart';
import 'package:gymnastic_center/presentation/widgets/home/course_tile.dart';

class AllCoursesScreen extends StatelessWidget {
  const AllCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final allCoursesBloc = GetIt.instance<AllCoursesBloc>();
    allCoursesBloc.add(AllCoursesRequested());
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 100),
          child: CustomAppBar(
            content: Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: Row(
                  children: [
                    BrandBackButton(),
                    Text(
                      'All Courses',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
          ),
        ),
        body: BlocProvider<AllCoursesBloc>.value(
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
        ));
  }
}
