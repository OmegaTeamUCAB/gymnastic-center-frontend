import 'package:flutter/material.dart';
import 'package:gymnastic_center/infrastructure/screens/disability/disability_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/home/home_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/notifications/notifications_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/settings/settings_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_bottom_navbar.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_lightning_button.dart';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  final int pageIndex;
  const MainScreen({this.pageIndex = 0, super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final screens = <Widget>[
    HomeScreen(),
    const DisabilityScreen(),
    const SettingsScreen(),
    const NotificationsScreen(),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: CustomNavigationBar(
        tabIndex: selectedIndex,
        onTap: (newScreenIndex) {
          setState(() {
            selectedIndex = newScreenIndex;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomFloatingLightningButton(
        onPressed: () {},
      ),
    );
  }
}
