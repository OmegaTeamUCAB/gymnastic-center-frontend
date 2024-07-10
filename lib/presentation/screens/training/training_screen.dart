import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/plan_courses/plan_courses_bloc.dart';
import 'package:gymnastic_center/application/blocs/plan_courses/plan_courses_event.dart';
import 'package:gymnastic_center/application/blocs/plan_courses/plan_courses_state.dart';
import 'package:gymnastic_center/application/blocs/select_data_source/select_data_source_bloc.dart';
import 'package:gymnastic_center/presentation/screens/loading_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';
import 'package:gymnastic_center/presentation/widgets/training/plan_courses_page_view.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  final PageController pageController = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectDataSourceBloc = GetIt.instance<SelectDataSourceBloc>();

    final dataSourceIndex = selectDataSourceBloc.state.dataSourceIndex;
    final planCoursesBloc = GetIt.instance<PlanCoursesBloc>();
    if (dataSourceIndex == 0) {
      planCoursesBloc
          .add(const PlanCoursesRequested(page: 1, filter: 'RECOMMENDED'));
    }
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          image: const DecorationImage(
            image: AssetImage("assets/particles.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: dataSourceIndex == 0
            ? BlocProvider<PlanCoursesBloc>.value(
                value: planCoursesBloc,
                child: BlocBuilder<PlanCoursesBloc, PlanCoursesState>(
                  builder: (context, state) {
                    if (state is PlanCoursesLoading) {
                      return const LoadingScreen();
                    }
                    if (state is PlanCoursesFailed) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    if (state is PlanCoursesSuccess) {
                      return PlanCoursesPageView(courses: state.courses);
                    } else {
                      return const Center(
                        child: Text('Unexpected error'),
                      );
                    }
                  },
                ),
              )
            : Center(
                child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/triste.png',
                      height: 150,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'Sorry!',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    const Text(
                      'Course recommendations are only available in Omega.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BrandButton(
                        isVariant: true,
                        text: 'Back to Home',
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ],
                ),
              )),
      ),
    );
  }
}
