import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/screens/trainers/trainers_screen.dart';
import 'package:gymnastic_center/presentation/screens/home/home_screen.dart';
import 'package:gymnastic_center/presentation/screens/notifications/notifications_screen.dart';
import 'package:gymnastic_center/presentation/screens/profile/profile_screen.dart';
import 'package:gymnastic_center/presentation/screens/training/training_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_bottom_navbar.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_lightning_button.dart';
import 'package:gymnastic_center/presentation/widgets/drawers/menu_side_nav.dart';

class MainScreen extends StatefulWidget {
  final int pageIndex;
  const MainScreen({this.pageIndex = 0, super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final screens = <Widget>[
    const HomeScreen(),
    const TrainersScreen(),
    const NotificationsScreen(),
    const ProfileScreen(),
  ];

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Scaffold.of(context).openDrawer();
      },
      child: Scaffold(
        drawerEdgeDragWidth: MediaQuery.of(context).size.width * 0.12,
        key: scaffoldKey,
        extendBody: true,
        body: IndexedStack(
          index: selectedIndex,
          children: screens,
        ),
        drawer: const MenuSideNav(),
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
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const TrainingScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
