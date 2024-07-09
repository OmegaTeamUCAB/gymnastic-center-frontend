import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_progress_indicator.dart';

class CourseProgressCard extends StatelessWidget {
  final String courseImage;
  final String courseName;
  final String instructorName;
  final double percent;

  CourseProgressCard({
    super.key,
    required this.courseImage,
    required this.percent,
    required this.courseName,
    required this.instructorName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      width: 300,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(courseImage), 
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  instructorName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  courseName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child:                 
              CustomProgressIndicator(
                  textColor: Colors.white,
                  indicatorColor: Colors.deepPurple[200],
                  strokeWidth: 3,
                  percent: 40,
                ),
          ),
        ],
      ),
    );
  }
}