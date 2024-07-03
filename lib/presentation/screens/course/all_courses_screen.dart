import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/feature_courses/feature_courses_bloc.dart';
import 'package:gymnastic_center/presentation/utils/pagination_controller.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_back_button.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';
import 'package:gymnastic_center/presentation/widgets/common/no_results.dart';
import 'package:gymnastic_center/presentation/widgets/course/courses_list.dart';

class AllCoursesScreen extends StatefulWidget {
  const AllCoursesScreen({super.key});

  @override
  State<AllCoursesScreen> createState() => _AllCoursesScreenState();
}

class _AllCoursesScreenState extends State<AllCoursesScreen> {
  final featureCoursesBloc = GetIt.instance<FeatureCoursesBloc>();
  late final PaginationController paginationController;

  @override
  void initState() {
    super.initState();
    //! Buggy as hell
    paginationController = PaginationController(
      requestNextPage: (page) => featureCoursesBloc.add(FeatureCoursesRequested(page)),
    );
  }

  @override
  void dispose() {
    paginationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        body: BlocProvider<FeatureCoursesBloc>.value(
          value: featureCoursesBloc,
          child: BlocBuilder<FeatureCoursesBloc, FeatureCoursesState>(
            builder: (context, state) {
              if (state is FeatureCoursesLoading) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 25),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (state is FeatureCoursesFailed) {
                return Center(
                  child: Text(state.message),
                );
              }
              if (state is FeatureCoursesSuccess) {
                if (state.courses.isEmpty) {
                  return const Center(
                    child: NoResults(),
                  );
                }
                return CoursesList(
                  courses: state.courses,
                  controller: paginationController.scrollController,
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
