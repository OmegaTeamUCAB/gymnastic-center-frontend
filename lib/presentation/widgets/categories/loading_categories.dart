import 'package:flutter/material.dart';

class LoadingCategories extends StatelessWidget {
  const LoadingCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.only(left: 15, right: index == 3 ? 15 : 0),
              decoration: BoxDecoration(
                color:
                    Theme.of(context).colorScheme.surfaceTint.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ));
        },
      ),
    );
  }
}
