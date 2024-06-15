import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/screens/blog/all_blogs_screen.dart';
import 'package:gymnastic_center/presentation/screens/course/all_courses_screen.dart';
import 'package:gymnastic_center/presentation/screens/search_screen.dart';
import 'package:gymnastic_center/presentation/widgets/home/home_blog_carousel.dart';
import 'package:gymnastic_center/presentation/widgets/common/content_header.dart';

import 'package:gymnastic_center/presentation/widgets/home/category_carousel.dart';
import 'package:gymnastic_center/presentation/widgets/home/home_course_carousel.dart';
import 'package:gymnastic_center/presentation/widgets/icons/gymnastic_center_icons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/particles.png'),
                alignment: Alignment.bottomLeft,
                fit: BoxFit.cover),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xFF4F14A0), Color(0xFF8066FF)],
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(
            Icons.menu_rounded,
            size: 30,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
            icon: const Icon(
              GymnasticCenter.search,
              size: 25,
              color: Colors.white,
            ),
          )
        ],
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Image.asset(
            'assets/app-launcher/app_icon.png',
            width: 45,
            fit: BoxFit.contain,
          ),
        ),
        // title: const Text('Gymnastic Center',
        //     style: TextStyle(
        //         fontSize: 20,
        //         fontWeight: FontWeight.bold,
        //         color: Colors.white)),
      ),
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
          const SizedBox(
            height: 15,
          ),
          ContentHeader(
              title: 'Trending Courses',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AllCoursesScreen()),
                );
              }),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: HomeCourseCarousel(),
          ),
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
          const SizedBox(
            height: 10,
          ),
          const HomeBlogCarousel(),
          const SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }
}
