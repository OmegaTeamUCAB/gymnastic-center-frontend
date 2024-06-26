import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/search/search_bloc.dart';
import 'package:gymnastic_center/application/models/search_filter.dart';
import 'package:gymnastic_center/presentation/widgets/search/search_filter_chip.dart';

final filterChips = [
  const SearchFilter(label: 'Prenatal', value: 'prenatal'),
  const SearchFilter(label: 'For Women', value: 'for_women'),
  const SearchFilter(label: 'Training', value: 'training'),
  const SearchFilter(label: 'Courses', value: 'courses'),
  const SearchFilter(label: 'Videos', value: 'videos'),
  const SearchFilter(label: 'Morning', value: 'yoga'),
  const SearchFilter(label: 'Recent Post', value: 'recent_post'),
  const SearchFilter(label: 'Most Popular', value: 'most_popular'),
];

class SearchChips extends StatelessWidget {
  const SearchChips({super.key});

  @override
  Widget build(BuildContext context) {
    final searchBloc = context.watch<SearchBloc>();
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filterChips.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 8,
              ),
              child: SearchFilterChip(
                filter: filterChips[index],
                searchBloc: searchBloc,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: SearchFilterChip(
              filter: filterChips[index],
              searchBloc: searchBloc,
            ),
          );
        },
      ),
    );
  }
}
