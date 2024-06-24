import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/search/search_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/search/custom_search_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/search/search_chips.dart';
import 'package:gymnastic_center/presentation/widgets/search/search_results_list.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchBloc = GetIt.instance<SearchBloc>();
    final courses = searchBloc.state.results.courses;
    final blogs = searchBloc.state.results.blogs;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16),
                  )),
            ),
          ],
          title: BlocProvider.value(
            value: searchBloc,
            child: const CustomSearchBar(),
          ),
        ),
        body: BlocProvider.value(
          value: searchBloc,
          child: Column(
            children: [
              const SizedBox(height: 10),
              const SearchChips(),
              SearchResultsList(courses: courses, blogs: blogs),
            ],
          ),
        ),
      ),
    );
  }
}
