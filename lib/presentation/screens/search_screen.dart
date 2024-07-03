import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/course/course_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gymnastic_center/application/blocs/search/search_bloc.dart';
import 'package:gymnastic_center/presentation/screens/blog/blog_detail_screen.dart';
import 'package:gymnastic_center/presentation/screens/course/course_detail_screen.dart';
import 'package:gymnastic_center/presentation/widgets/search/custom_search_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/search/search_chips.dart';
import 'package:gymnastic_center/presentation/widgets/search/search_results_list.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchBloc = GetIt.instance<SearchBloc>();
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
                    AppLocalizations.of(context)!.cancel,
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
              Divider(
                color: Theme.of(context).colorScheme.surfaceTint,
              ),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  return BlocListener<SearchBloc, SearchState>(
                    listener: (context, state) {
                      if (state.isSubmitted) {
                        if (state.results.courses.isNotEmpty) {
                          final courseBloc =
                              BlocProvider.of<CourseBloc>(context);
                          courseBloc.add(CourseClicked(
                              courseId: state.results.courses.first.id));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CourseDetailScreen(
                                  courseId: state.results.courses.first.id),
                            ),
                          );
                        } else if (state.results.blogs.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlogDetailScreen(
                                  blogId: state.results.blogs.first.id),
                            ),
                          );
                        }
                      }
                    },
                    child: SearchResultsList(
                        courses: state.results.courses,
                        blogs: state.results.blogs),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
