import 'package:flutter/material.dart';

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
              height: 250,
              child: ListView.builder(
                itemCount: courses.length + blogs.length,
                itemBuilder: (context, index) {
                  if (index < courses.length) {
                    // Render Course ListTile
                    return ListTile(
                        title: Text(courses[index].title),
                        titleTextStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        subtitle: Text(
                          courses[index].description,
                        ),
                        subtitleTextStyle: const TextStyle(
                            fontSize: 12, color: Color(0xFF677294)));
                  } else {
                    // Render Blog ListTile
                    int blogIndex = index - courses.length;
                    return ListTile(
                        title: Text(blogs[blogIndex].title),
                        titleTextStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        subtitle: Text(blogs[blogIndex].description),
                        subtitleTextStyle: const TextStyle(
                            fontSize: 12, color: Color(0xFF677294)));
                  }
                },
              ),
            ),
    );
  }
}
