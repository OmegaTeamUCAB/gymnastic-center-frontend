import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/all_courses/all_courses_bloc.dart';
import 'package:gymnastic_center/application/blocs/feature_courses/feature_courses_bloc.dart';
import 'package:gymnastic_center/presentation/utils/pagination_controller.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_back_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';
import 'package:gymnastic_center/presentation/widgets/common/no_results.dart';
import 'package:gymnastic_center/presentation/widgets/course/courses_list.dart';

class AllCoursesScreen extends StatefulWidget {
  const AllCoursesScreen({super.key});

  @override
  State<AllCoursesScreen> createState() => _AllCoursesScreenState();
}

class _AllCoursesScreenState extends State<AllCoursesScreen> {
  final allCoursesBloc = GetIt.instance<AllCoursesBloc>();
  late final PaginationController paginationController;

  @override
  void initState() {
    super.initState();
    paginationController = PaginationController(
      requestNextPage: (page) => allCoursesBloc.add(AllCoursesRequested(page)),
    );
    allCoursesBloc.add(const AllCoursesRequested(1));
  }

  @override
  void dispose() {
    paginationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 100),
          child: CustomAppBar(
            content: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  children: [
                    const BrandBackButton(),
                    Text(
                      AppLocalizations.of(context)!.allCourses,
                      style: const TextStyle(
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
