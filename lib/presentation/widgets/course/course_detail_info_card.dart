import 'package:flutter/material.dart';

class CourseDetailInfoCard extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String captionNumber;
  const CourseDetailInfoCard({
    super.key,
    required this.iconData,
    required this.title,
    required this.captionNumber,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            height: double.infinity,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.surfaceTint,
            ),
            child: Icon(
              iconData,
              color: Colors.deepPurple,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(title), Text(captionNumber)],
          )
        ],
      ),
    );
  }
}
