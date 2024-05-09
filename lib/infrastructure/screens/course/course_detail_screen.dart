import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/course/course_bloc.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/infrastructure/screens/course/course_content_screen.dart';
import 'package:gymnastic_center/presentation/widgets/course/course_carrusel.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';

class CourseDetailScreen extends StatefulWidget {
  final String courseId;
  CourseDetailScreen({
    super.key,
    required this.courseId
  });

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<CourseBloc>().add(GetCourseById(courseId: widget.courseId));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final courseIsLoading = context.watch<CourseBloc>().state.isLoading;
    final course = context.watch<CourseBloc>().state.course;
    final popularCourses = context.watch<CourseBloc>().state.popularCourses;

    if (courseIsLoading) return Scaffold(body: Center(child: CircularProgressIndicator(strokeWidth: 2,)));
    if (course == null) return Center(child: Text('No existe el curso'),);

    List<Course> updatedCourses = popularCourses.where((courses) => courses.id != course.id).toList();
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 350), child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 100),
                child: GestureDetector(
                  onDoubleTap: () {
                    Navigator.push(
                          context,
                          MaterialPageRoute(
                              // TODO: pasarle el curso completo
                              builder: (context) => const CourseContentScreen()),
                        );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(60)),
                    child: FadeInImage(
                      height: 350,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder:  const AssetImage('assets/loader.gif'), 
                      image: NetworkImage(course!.imageUrl)),
                  ),
                ),
              ),
              CustomAppBar(
                content: Row(
                children: [
                  IconButton(
                      iconSize: 30,
                      onPressed: () => Navigator.pop(context),
                      color: Colors.white,
                      icon: const Icon(Icons.chevron_left)),
                  Text(
                    course.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              ),
            ],
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 11),
                    child: Text(
                                  course.description,
                                  maxLines: 3, 
                                  overflow: TextOverflow.ellipsis, 
                                      )),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Divider(),
                  ),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _CouseDetailInfoCard(title: 'Level', captionNumber: course.level.toString(), iconData: Icons.menu,),
                    _CouseDetailInfoCard(title: 'Weeks', captionNumber: course.weeks.toString(), iconData: Icons.calendar_month_sharp,),
                    _CouseDetailInfoCard(title: 'Mins', captionNumber: course.minutes.toString(), iconData: Icons.watch_later_outlined,),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Align(                    
                    alignment: Alignment.centerLeft,
                    child: Text('More Most Popular Courses', style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20)), 
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: CourseCarrusel(courses: popularCourses, width: 180, onTap: (courseId) {
                    context.read<CourseBloc>().add(GetCourseById(courseId: courseId));
                  },))
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}

class _CouseDetailInfoCard extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String captionNumber; 
  _CouseDetailInfoCard({
    
    super.key, required this.iconData, required this.title, required this.captionNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        child: Row(children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 6),
            height: double.infinity,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.surfaceTint,
            ),
            child: Icon(iconData, color: Colors.deepPurple,),
            
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(title),
            Text(captionNumber)
          ],)
        ],),
      );
  }
}
