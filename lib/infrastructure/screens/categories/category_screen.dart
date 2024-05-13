import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryName;
  final String categoryId;
  const CategoryScreen(
      {super.key, required this.categoryName, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 100),
        child: CustomAppBar(
          content: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.chevron_left,
                      size: 30, color: Colors.white)),
              Text(
                categoryName,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
