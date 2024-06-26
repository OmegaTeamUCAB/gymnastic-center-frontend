import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/search/search_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/icons/gymnastic_center_icons.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchBloc = context.watch<SearchBloc>();

    return TextFormField(
      controller: searchController,
      style: TextStyle(
          fontSize: 16, color: Theme.of(context).colorScheme.onPrimary),
      cursorColor: const Color(0xFF4F14A0),
      onChanged: (value) {
        searchBloc.add(QueryStringChanged(value));
      },
      textInputAction: TextInputAction.go,
      onFieldSubmitted: (value) async {
        searchBloc.add(const FormSubmitted());
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8)),
        suffixIconColor: Theme.of(context).colorScheme.outline,
        hintText: 'What are you looking for?',
        contentPadding: const EdgeInsets.symmetric(vertical: 6),
        suffixIcon: searchController.text.isNotEmpty
            ? IconButton(
                icon: Icon(
                  Icons.cancel_rounded,
                  size: 20,
                  color:
                      Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
                ),
                onPressed: () {
                  searchController.clear();
                  searchBloc.add(const QueryStringChanged(''));
                },
              )
            : null,
        prefixIcon: const Icon(
          GymnasticCenter.search,
          size: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
