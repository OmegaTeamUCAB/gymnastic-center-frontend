import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/search/search_bloc.dart';
import 'package:gymnastic_center/application/models/search_filter.dart';

class SearchFilterChip extends StatelessWidget {
  final SearchFilter filter;
  final SearchBloc searchBloc;
  const SearchFilterChip(
      {super.key, required this.filter, required this.searchBloc});

  @override
  Widget build(BuildContext context) {
    return FilterChip(
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
        });
  }
}
