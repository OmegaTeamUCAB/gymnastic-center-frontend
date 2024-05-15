import 'package:flutter/material.dart';

class CourseOptionPageView extends StatelessWidget {
  const CourseOptionPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 140),
          const Text(
            'Abdominales para enamorar a las chicas de la playa',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            '1 h  |  Juan Hedderich',
            style: TextStyle(
                fontSize: 18, color: Theme.of(context).colorScheme.onSecondary),
          ),
          const SizedBox(height: 24), // Add some space
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              'https://hips.hearstapps.com/hmg-prod/images/strong-muscular-man-abs-six-pack-sea-beach-swimwear-royalty-free-image-488881048-1558374527.jpg?crop=0.667xw:1.00xh;0.333xw,0&resize=1200:*',
              height: 390,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
