import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';
import 'package:gymnastic_center/presentation/widgets/search/custom_search_bar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 130,
            child: CustomAppBar(
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
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: CustomSearchBar(),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text('Here is some content')
        ],
      ),
    );
  }
}
