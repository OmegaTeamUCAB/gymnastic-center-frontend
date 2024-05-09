import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/search/search_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/icons/gymnastic_center_icons.dart';
import 'package:gymnastic_center/presentation/widgets/search/search_results_list.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final searchBloc = context.watch<SearchBloc>();
    final courses = searchBloc.state.results.courses;
    final blogs = searchBloc.state.results.blogs;
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
        const SizedBox(
          height: 10,
        ),
        SearchResultsList(
          courses: courses,
          blogs: blogs,
        ),
      ],
    );
  }
}
