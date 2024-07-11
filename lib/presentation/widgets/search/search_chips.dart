import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/get_search_tags/get_search_tags_bloc.dart';
import 'package:gymnastic_center/application/blocs/search/search_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/search/search_filter_chip.dart';

class SearchChips extends StatefulWidget {
  const SearchChips({super.key});

  @override
  State<SearchChips> createState() => _SearchChipsState();
}

class _SearchChipsState extends State<SearchChips> {
  late GetSearchTagsBloc searchTagsBloc;
  @override
  void initState() {
    searchTagsBloc = GetIt.instance<GetSearchTagsBloc>();
    searchTagsBloc.add(const SearchTagsRequested(1, 15));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchBloc = context.watch<SearchBloc>();
    return BlocProvider.value(
      value: searchTagsBloc,
      child: BlocBuilder<GetSearchTagsBloc, GetSearchTagsState>(
        builder: (context, state) {
          if (state is SearchTagsLoading) {
            return const CircularProgressIndicator();
          }
          if (state is GetSearchTagsSuccess) {
            return SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.searchTags.length,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 8,
                      ),
                      child: SearchFilterChip(
                        filter: state.searchTags[index],
                        searchBloc: searchBloc,
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: SearchFilterChip(
                      filter: state.searchTags[index],
                      searchBloc: searchBloc,
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: Text('Error loading search tags'),
            );
          }
        },
      ),
    );
  }
}
