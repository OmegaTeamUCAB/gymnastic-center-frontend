import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/screens/profile/profile_app_bar.dart';
import 'package:gymnastic_center/presentation/screens/profile/profile_course_carousel.dart';
import 'package:gymnastic_center/presentation/widgets/common/content_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, 200), child: ProfileAppBar()),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              ContentHeader(
                title: 'My Courses',
              ),
              ProfileCourseCarousel(),
            ],
          ),
        ));
  }
}
