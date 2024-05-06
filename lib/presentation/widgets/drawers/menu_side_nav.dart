import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/infrastructure/config/menu/menu_items.dart';

class MenuSideNav extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const MenuSideNav({super.key, required this.scaffoldKey});

  @override
  State<MenuSideNav> createState() => _MenuSideNavState();
}

class _MenuSideNavState extends State<MenuSideNav> {
  // int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;

    return NavigationDrawer(
      // selectedIndex: navDrawerIndex,
      backgroundColor: ThemeData().primaryColor,
      onDestinationSelected: (value) {
        setState(() {
          // navDrawerIndex = value;
        });

        final menuItem = appMenuItems[value];
        context.push(menuItem.link);
        widget.scaffoldKey.currentState?.closeDrawer();
      },
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(28, hasNotch ? 50 : 15, 18, 10),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(28, hasNotch ? 50 : 200, 18, 10),
        ),
        ...appMenuItems.map(
          (item) => NavigationDrawerDestination(
            icon: Icon(item.icon),
            label: Text(item.title,
                style: const TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 100, 0, 80),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.logout),
          label: Text('Logout',
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
      ],
    );
  }
}
