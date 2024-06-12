import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/screens/blog/all_blogs_screen.dart';
import 'package:gymnastic_center/presentation/screens/course/all_courses_screen.dart';
import 'package:gymnastic_center/presentation/widgets/home/blog_carousel.dart';
import 'package:gymnastic_center/presentation/widgets/common/content_header.dart';

import 'package:gymnastic_center/presentation/widgets/home/category_carousel.dart';
import 'package:gymnastic_center/presentation/widgets/home/home_app_bar.dart';
import 'package:gymnastic_center/presentation/widgets/home/home_course_carousel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 170), child: HomeAppBar()),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              'Categories',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
          const CategoryCarousel(),
          const SizedBox(height: 25),
          ContentHeader(
              title: 'Trending Courses',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AllCoursesScreen()),
                );
              }),
          const HomeCourseCarousel(),
          const SizedBox(
            height: 25,
          ),
          ContentHeader(
              title: 'Popular Blogs',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AllBlogsScreen()),
                );
              }),
          const HomeBlogCarousel(),
          const SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }
}
