import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/icons/gymnastic_center_icons.dart';

class CustomNavigationBar extends StatelessWidget {
  final int tabIndex;
  final double iconsSize;
  final ValueChanged<int>? onTap;

  const CustomNavigationBar({
    required this.tabIndex,
    this.iconsSize = 30,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorAppBar = Theme.of(context).colorScheme.tertiaryContainer;

    return BottomAppBar(
      surfaceTintColor: colorAppBar,
      color: colorAppBar,
      shape: const CircularNotchedRectangle(),
      clipBehavior: Clip.antiAlias,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: colorAppBar,
        elevation: 0,
        selectedFontSize: 0,
        onTap: onTap,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Theme.of(context).colorScheme.onPrimaryContainer,
        currentIndex: tabIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: iconsSize,
        items: [
          const BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: Icon(GymnasticCenter.home),
            ),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(right: 30),
              child: Icon(GymnasticCenter.wheelchair),
            ),
            label: 'Wheelchair',
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin: const EdgeInsets.symmetric(horizontal: 50),
              child: const Icon(
                GymnasticCenter.settings,
              ),
            ),
            label: 'Settings',
          ),
          const BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: Icon(Icons.notification_add_outlined),
            ),
            label: 'Notifications',
          ),
        ],
      ),
    );
  }
}
