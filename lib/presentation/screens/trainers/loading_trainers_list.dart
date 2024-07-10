import 'package:flutter/material.dart';

class LoadingTrainersList extends StatelessWidget {
  const LoadingTrainersList({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: 0.3,
      duration: const Duration(milliseconds: 1000),
      child: ListView.builder(
        itemCount: 2,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onBackground,
              borderRadius: BorderRadius.circular(10),
            ),
          );
        },
      ),
    );
  }
}
