import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/infrastructure/screens/course/course_detail_screen.dart';

class CourseCarrusel extends StatelessWidget {
  final double? width;
  final double? height;
  final List<Course>? courses;
  final Function(String courseId)? onTap;
  final Function? fetchData;
  const CourseCarrusel({
    super.key,
    this.width = 150,
    this.height = 150,
    this.courses,
    this.onTap,
    this.fetchData,
  }) : assert(courses != null || fetchData != null,
            'Debe proporcionar una lista de cursos o una función fetchData');
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Popular courses',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
      (fetchData == null)
          ? _CourseBuilder(
              courses: courses!,
              height: height,
              onTap: onTap,
              width: width,
            )
          : FutureBuilder(
              future: fetchData!(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData && snapshot.data is List<Course>) {
                    return _CourseBuilder(
                      courses: snapshot.data as List<Course>,
                      height: height,
                      width: width,
                      onTap: onTap,
                    );
                  } else {
                    return const Text('No hay cursos para mostrar');
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )
    ]);
  }
}

class _CourseBuilder extends StatelessWidget {
  final double? width;
  final double? height;
  final List<Course> courses;
  final Function(String courseId)? onTap;
  const _CourseBuilder(
      {super.key, this.width, this.height, required this.courses, this.onTap});

  void _funcionPredeterminada(String courseId, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CourseDetailScreen(courseId: courseId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        itemCount: courses.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final course = courses[index];
          if (courses.isEmpty) return Text('No hay cursos para mostrar');
          return GestureDetector(
            onTap: () => (onTap != null)
                ? onTap!(course.id)
                : _funcionPredeterminada(course.id, context),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8,0,8,0),
              child: _CourseSlide(
                  width: width, height: height, imgUrl: course.imageUrl),
            ),
          );
        },
      ),
    );
  }
}

class _CourseSlide extends StatelessWidget {
  const _CourseSlide({
    super.key,
    required this.width,
    required this.height,
    required this.imgUrl,
  });

  final double? width;
  final double? height;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              SizedBox(
                width: width,
                height: height,
                child: Image.network(
                  imgUrl,
                  fit: BoxFit.cover,
                  width: width,
                  height: height,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return child;
                    }
                  },
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.4),
                        Colors.black.withOpacity(0.3),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
            child: Container(
          width: 60,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.deepPurple,
          ),
          child: const Text(
            'New',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ))
      ],
    );
  }
}
