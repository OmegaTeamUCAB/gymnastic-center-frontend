import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final String courseId;
  final String courseImageUrl;
  const CourseCard({
    super.key,
    required this.courseId,
    required this.courseImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(courseImageUrl, fit: BoxFit.cover, height: 150,
              loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress != null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return child;
            }
          }),
        ),
        Positioned.fill(
            child: Container(
            width: 150,
            height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.7),
                Colors.black.withOpacity(0.3),
              ],
            ),
          ),
          child: const Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.play_circle_outline_rounded,
              size: 60,
              color: Colors.white,
            ),
          ),
        )),
      ],
    );
  }
}
