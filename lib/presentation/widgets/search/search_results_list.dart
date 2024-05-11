import 'package:flutter/material.dart';
import 'package:gymnastic_center/infrastructure/screens/course/course_detail_screen.dart';

class SearchResultsList extends StatelessWidget {
  final List<dynamic> courses;
  final List<dynamic> blogs;
  const SearchResultsList(
      {super.key, this.courses = const [], this.blogs = const []});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff2D2D3A).withOpacity(0.1),
              spreadRadius: 0.5,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        child: courses.length + blogs.length == 0
            ? const SizedBox(
                width: 500,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                  child: Text(
                    'No results',
                    style: TextStyle(color: Colors.grey),
                  ),
                ))
            : SizedBox(
                width: 500,
                height: 400,
                child: ListView.builder(
                  itemCount: courses.length +
                      blogs.length +
                      (courses.isNotEmpty ? 1 : 0) +
                      1, // Adjusted for the titles
                  itemBuilder: (context, index) {
                    if (index == 0 && courses.isNotEmpty) {
                      // Render 'Courses' title
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'Courses',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF4F14A0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    } else if (index <= courses.length && courses.isNotEmpty) {
                      // Render Course ListTile
                      return ListTile(
                        title: Text(courses[index - 1].title), // Adjusted index
                        titleTextStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          courses[index - 1].description, // Adjusted index
                        ),
                        subtitleTextStyle: const TextStyle(
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.black),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CourseDetailScreen(
                                courseId:
                                    courses[index - 1].id, // Adjusted index
                              ),
                            ),
                          );
                        },
                      );
                    } else if (index ==
                        courses.length + (courses.isNotEmpty ? 1 : 0)) {
                      // Render 'Blogs' title
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'Blogs',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF4F14A0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    } else {
                      // Render Blog ListTile
                      int blogIndex = index -
                          courses.length -
                          (courses.isNotEmpty ? 1 : 0) -
                          1; // Adjusted index
                      return ListTile(
                        title: Text(blogs[blogIndex].title),
                        titleTextStyle: const TextStyle(
                          color: Colors.black,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 16,
                        ),
                        subtitle: Text(blogs[blogIndex].description),
                        tileColor: Colors.grey[200],
                        subtitleTextStyle: const TextStyle(
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.black),
                      );
                    }
                  },
                ),
              ));
  }
}
