import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/ui/custom_app_bar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 100),
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
        )),
      ),
    );
  }
}
