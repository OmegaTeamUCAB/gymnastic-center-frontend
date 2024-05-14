import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/course/course_bloc.dart';
import 'package:gymnastic_center/infrastructure/config/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/datasources/http/http_manager_impl.dart';
import 'package:gymnastic_center/infrastructure/services/blogs/blogs_service.dart';
import 'package:gymnastic_center/infrastructure/services/categories/category_service.dart';
import 'package:gymnastic_center/presentation/widgets/categories/blog_carousel.dart';
import 'package:gymnastic_center/presentation/widgets/course/course_carrusel.dart';
import 'package:gymnastic_center/presentation/widgets/home/category_carousel.dart';
import 'package:gymnastic_center/presentation/widgets/home/home_app_bar.dart';
import 'package:gymnastic_center/presentation/widgets/home/home_course_carousel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final popularCourses = context.watch<CourseBloc>().state.popularCourses;

    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 170), child: HomeAppBar()),
      body: ListView(
        children: [
          CategoryCarousel(categoryRepository: CategoryService()),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Text(
                  'Trending Courses',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Show all',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
          ),
          const HomeCourseCarousel(),
          // CourseCarrusel(
          //   courses: popularCourses,
          // ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              'Popular Blogs',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
          ImprovedBlogCarousel(
              blogRepository: BlogsService(HttpManagerImpl(
            baseUrl: Environment.getApiUrl(),
          ))),
          const SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }
}
