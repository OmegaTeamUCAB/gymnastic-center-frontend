import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/search/search_bloc.dart';
import 'package:gymnastic_center/application/models/search_filter.dart';

final filterChips = [
  //todo: should come from backend
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
    return Wrap(
      children: filterChips.map((filter) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: FilterChip(
              backgroundColor: Theme.of(context).colorScheme.surfaceTint,
              selectedColor: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              showCheckmark: false,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: searchBloc.state.filters.contains(filter.value)
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.surfaceTint,
                  ),
                  borderRadius: BorderRadius.circular(60)),
              label: Text(
                filter.label,
              ),
              labelStyle: TextStyle(
                color: searchBloc.state.filters.contains(filter.value)
                    ? Theme.of(context).colorScheme.onSurface
                    : Theme.of(context).colorScheme.primary,
              ),
              selected: searchBloc.state.filters.contains(filter.value),
              onSelected: (bool selected) {
                if (selected) {
                  BlocProvider.of<SearchBloc>(context)
                      .add(FilterSelected(filter.value));
                } else {
                  BlocProvider.of<SearchBloc>(context)
                      .add(FilterDeselected(filter.value));
                }
              }),
        );
      }).toList(),
    );
  }
}
