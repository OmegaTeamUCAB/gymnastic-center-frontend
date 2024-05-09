import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/search/search_bloc.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/presentation/widgets/icons/gymnastic_center_icons.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final searchBloc = context.watch<SearchBloc>();
    List<Course> courses = searchBloc.state.results.courses;
    List<Blog> blogs = searchBloc.state.results.blogs;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF2F2F2),
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: const Color(0xff2D2D3A).withOpacity(0.2),
                offset: const Offset(0, 2),
                blurRadius: 4.0,
              ),
            ],
          ),
          child: TextFormField(
            style: const TextStyle(fontSize: 16, color: Colors.black),
            cursorColor: const Color(0xFF4F14A0),
            onChanged: (value) {
              searchBloc.add(QueryStringChanged(value));
            },
            decoration: const InputDecoration(
              hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
              suffixIconColor: Colors.grey,
              hintText: 'Search',
              suffixIcon: Icon(
                GymnasticCenter.search,
                size: 15,
              ),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
        ),
        Container(
          color: Colors.blue,
          child: courses.length + blogs.length == 0
              ? const Text('No results')
              : ListView.builder(
                  itemCount: courses.length + blogs.length,
                  itemBuilder: (context, index) {
                    if (index < courses.length) {
                      // Render Course ListTile
                      return ListTile(
                        title: Text(courses[index].name),
                        subtitle: Text(courses[index].description),
                      );
                    } else {
                      // Render Blog ListTile
                      int blogIndex = index - courses.length;
                      return ListTile(
                        title: Text(blogs[blogIndex].title),
                        subtitle: Text(blogs[blogIndex].description),
                      );
                    }
                  },
                ),
        )
      ],
    );
  }
}
