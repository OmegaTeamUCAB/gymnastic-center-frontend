import 'package:flutter/material.dart';
import 'package:gymnastic_center/infrastructure/screens/profile/profile_app_bar.dart';
import 'package:gymnastic_center/infrastructure/screens/profile/statistics_profile.dart';
import 'package:gymnastic_center/presentation/widgets/common/carousel_header.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 230), child: ProfileAppBar()),
      body: Column(
        children: [
          const SizedBox(height: 10,),
          CarouselHeader(title: 'Statistics', onButtonPressed: () {}),
          const SizedBox(height: 10,),
      
          //const StatisticsChart(),
        ],
      )
    );
  }
}
