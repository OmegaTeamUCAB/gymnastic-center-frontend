import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/course/course_bloc.dart';
import 'package:gymnastic_center/application/blocs/search/search_bloc.dart';
import 'package:gymnastic_center/application/repositories/search/search_results.dart';
import 'package:gymnastic_center/presentation/screens/course/course_detail_screen.dart';
import 'package:gymnastic_center/presentation/screens/blog/blog_detail_screen.dart';
import 'package:gymnastic_center/presentation/widgets/search/result_tile.dart';

class SearchResultsList extends StatelessWidget {
  final List<SearchHit> courses;
  final List<SearchHit> blogs;
  const SearchResultsList(
      {super.key, this.courses = const [], this.blogs = const []});

  @override
  Widget build(BuildContext context) {
    final searchTerm = context.watch<SearchBloc>().state.searchTerm;
    if (searchTerm.isEmpty) return const SizedBox.shrink();
    final totalItems = courses.length + blogs.length;

    if (totalItems == 0) {
      return const SizedBox(
        width: 500,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: Text(
            'No results',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            if (courses.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12),
                    child: Text(
                      'Courses',
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      return ResultTile(
                        title: courses[index].title,
                        description: courses[index].trainer,
                        image: courses[index].image,
                        category: courses[index].category,
                        isFirst: index == 0,
                        onTap: () {
                          final courseBloc =
                              BlocProvider.of<CourseBloc>(context);
                          courseBloc
                              .add(CourseClicked(courseId: courses[index].id));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CourseDetailScreen(
                                courseId: courses[index].id,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            if (blogs.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12),
                    child: Text(
                      'Blogs',
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: blogs.length,
                    itemBuilder: (context, index) {
                      return ResultTile(
                        title: blogs[index].title,
                        description: blogs[index].trainer,
                        image: blogs[index].image,
                        category: blogs[index].category,
                        isFirst: index == 0 && courses.isEmpty,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlogDetailScreen(
                                blogId: blogs[index].id,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
