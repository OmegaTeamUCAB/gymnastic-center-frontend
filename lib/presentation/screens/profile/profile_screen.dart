import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/screens/profile/profile_app_bar.dart';
import 'package:gymnastic_center/presentation/widgets/profile/statistics_header.dart';
import 'package:gymnastic_center/presentation/widgets/profile/statistics_profile.dart';
import 'package:gymnastic_center/presentation/widgets/course/course_carrusel.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size(double.infinity, 230), child: ProfileAppBar()),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              StatisticsHeader(
                  title: 'Statistics',
                  subtitle: 'This Week',
                  onButtonPressed: () {}),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                      color: colors.surfaceTint,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Calories',
                                  style: TextStyle(
                                      color: colors.onPrimary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  '160,5Kcal',
                                  style: TextStyle(
                                      color: colors.onPrimary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  'Time',
                                  style: TextStyle(
                                      color: colors.onPrimary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  '1:03:56',
                                  style: TextStyle(
                                      color: colors.onPrimary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          const SizedBox(
                            width: 212,
                            height: 180,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 12),
                              child: StatisticsChart(),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'My training',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary),
              ),
              const SizedBox(
                height: 10,
              ),
              const CourseCarrusel(
                courses: [],
              )
            ],
          ),
        ));
  }
}
