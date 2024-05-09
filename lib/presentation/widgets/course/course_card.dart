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
          child: FadeInImage(
            fit: BoxFit.cover,
            placeholder: const AssetImage('assets/loader.gif'), 
            height: 150,
            image: NetworkImage(courseImageUrl)
          ),
        ),

        Positioned.fill(
          child: Container(
            decoration:  BoxDecoration(
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
            child: Align(
              alignment: Alignment.center,
              child: Icon(Icons.play_circle_outline_rounded, size: 60, color: Colors.white,),
            ),
          ) 
        ),
      ],
    );
  }
}