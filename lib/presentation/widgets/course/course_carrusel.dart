import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      {this.width, this.height, required this.courses, this.onTap});

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
          if (courses.isEmpty) return const Text('No hay cursos para mostrar');
          return GestureDetector(
            onTap: () => (onTap != null)
                ? onTap!(course.id)
                : _funcionPredeterminada(course.id, context),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: _CourseSlide(course: course),
            ),
          );
        },
      ),
    );
  }
}

class _CourseSlide extends StatelessWidget {
  final Course course;

  const _CourseSlide({required this.course});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              SizedBox(
                width: 180,
                height: 180,
                child: Image.network(
                  course.imageUrl,
                  fit: BoxFit.cover,
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
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Text(
                  course.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        Positioned(
            child: Container(
          width: 60,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          margin: const EdgeInsets.all(8),
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
