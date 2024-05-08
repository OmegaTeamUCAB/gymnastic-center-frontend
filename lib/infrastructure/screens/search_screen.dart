import 'package:flutter/material.dart';
import 'package:gymnastic_center/application/models/search_filter.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';
import 'package:gymnastic_center/presentation/widgets/search/custom_search_bar.dart';

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

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                //makes searchBar clickable
                height: 155,
              ),
              CustomAppBar(
                content: Row(
                  children: [
                    IconButton(
                        iconSize: 30,
                        onPressed: () => Navigator.pop(context),
                        color: Colors.white,
                        icon: const Icon(Icons.chevron_left)),
                    const Text(
                      'Popular Search',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const Positioned(
                  bottom: 0,
                  left: 0.0,
                  right: 0.0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: CustomSearchBar(),
                  )),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Wrap(
                children: filterChips.map((filter) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: FilterChip(
                      backgroundColor:
                          Theme.of(context).colorScheme.surfaceTint,
                      selectedColor: Theme.of(context).colorScheme.primary,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Theme.of(context).colorScheme.surfaceTint),
                          borderRadius: BorderRadius.circular(60)),
                      label: Text(
                        filter.label,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      onSelected: (bool value) {},
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
