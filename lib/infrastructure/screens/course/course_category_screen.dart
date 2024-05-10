import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/course/course_bloc.dart';
import 'package:gymnastic_center/domain/category/category.dart';
import 'package:gymnastic_center/domain/category/category_repository.dart';
import 'package:gymnastic_center/infrastructure/screens/course/views/course_view.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';

class CourseCategoryScreen extends StatefulWidget {
  final ICategoryRepository categoryRepository;
  const CourseCategoryScreen({
    super.key,
    required this.categoryRepository,
  });

  @override
  State<CourseCategoryScreen> createState() => _CourseCategoryScreenState();
}

class _CourseCategoryScreenState extends State<CourseCategoryScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      context.read<CourseBloc>().add(AddPopularCourses());
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  final widgetList = <Widget>[
    InkWell(
      onTap: () {},
      child: const _TabView(
          textContent: Text(
        'Nutrition',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
      )),
    ),
    InkWell(
      onDoubleTap: () {},
      child: const _TabView(
          textContent: Text(
        'Training',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
      )),
    ),
    InkWell(
      onDoubleTap: () {},
      child: const _TabView(
          textContent: Text(
        'Weight loss',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
      )),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: widget.categoryRepository.getAllCategories(),
      builder: (context, snapshot) {
        return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size(double.infinity, 160),
              child: CustomAppBar(
                  content: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          iconSize: 30,
                          onPressed: () => Navigator.pop(context),
                          color: Colors.white,
                          icon: const Icon(Icons.chevron_left)),
                      const Text(
                        'Courses',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  (snapshot.connectionState != ConnectionState.waiting)
                      ? Expanded(
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  context
                                      .read<CourseBloc>()
                                      .add(AddPopularCourses());
                                },
                                child: const _TabView(
                                  textContent: Text(
                                    'Most popular',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 6,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        context.read<CourseBloc>().add(
                                            AddCoursesByCategory(
                                                categoryId: (snapshot.data !=
                                                        null)
                                                    ? snapshot.data![index].id
                                                    : ''));
                                      },
                                      child: _TabView(
                                          textContent: Text(
                                        snapshot.data![index].name,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      )),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                      : const CircularProgressIndicator()
                ],
              )),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: (snapshot.connectionState == ConnectionState.waiting)
                  ? const Center(child: CircularProgressIndicator())
                  : const CourseView(),
            ));
      },
    );
  }
}

class _TabView extends StatelessWidget {
  final Text textContent;
  const _TabView({
    required this.textContent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 4,
          ),
          const SizedBox(
            width: 4,
          ),
          textContent,
        ],
      ),
    );
  }
}
