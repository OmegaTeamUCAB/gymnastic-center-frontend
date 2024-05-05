import 'package:flutter/material.dart';
import 'package:gymnastic_center/infrastructure/screens/disability/disability_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/home/home_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/notifications/notifications_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/settings/settings_screen.dart';
import 'package:gymnastic_center/presentation/widgets/ui/custom_bottom_navbar.dart';
import 'package:gymnastic_center/presentation/widgets/ui/custom_lightning_button.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  final int pageIndex;
  MainScreen({
    this.pageIndex = 0, 
    super.key});

  final viewRoutes = <Widget>[
    HomeScreen(),
    const DisabilityScreen(),
    const SettingsScreen(),
    const NotificationsScreen(),
  ];

  void onTap(int value, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MainScreen(
                pageIndex: value,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomNavigationBar(
        tabIndex: pageIndex,
        onTap: (value) => onTap(value, context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomFloatingLightningButton(
        onPressed: () {},
      ),
    );
  }
}
