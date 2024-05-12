import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/search/search_bloc.dart';
import 'package:gymnastic_center/infrastructure/screens/course/course_detail_screen.dart';
import 'package:gymnastic_center/presentation/widgets/blog/blog_detail.dart';
import 'package:gymnastic_center/presentation/widgets/search/result_tile.dart';

class SearchResultsList extends StatelessWidget {
  final List<dynamic> courses;
  final List<dynamic> blogs;
  const SearchResultsList(
      {super.key, this.courses = const [], this.blogs = const []});

  @override
  Widget build(BuildContext context) {
    final searchTerm = context.watch<SearchBloc>().state.searchTerm;
    final isLoading = context.watch<SearchBloc>().state.isLoading;

    if (searchTerm.isEmpty) return const SizedBox.shrink();
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
      child: isLoading
          ? const Center(
              child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: CircularProgressIndicator(),
            ))
          : courses.length + blogs.length == 0
              ? const SizedBox(
                  width: 500,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                    child: Text(
                      'No results',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                )
              : ConstrainedBox(
                  constraints: const BoxConstraints(
                      minWidth: 500, minHeight: 100, maxHeight: 400),
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    itemCount: courses.length +
                        blogs.length +
                        (courses.isNotEmpty ? 1 : 0) +
                        1, // Adjusted for the titles
                    itemBuilder: (context, index) {
                      if (index == 0 && courses.isNotEmpty) {
                        // Render 'Courses' title
                        return const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          child: Text(
                            'Courses',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF4F14A0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      } else if (index <= courses.length &&
                          courses.isNotEmpty) {
                        // Render Course ListTile
                        return ResultTile(
                          title: courses[index - 1].title,
                          description: courses[index - 1].description,
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
                        return ResultTile(
                          title: blogs[blogIndex].title,
                          description: blogs[blogIndex].description,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlogDetail(
                                  blogId:
                                      blogs[blogIndex].id, // Corrected index
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
    );
  }
}
