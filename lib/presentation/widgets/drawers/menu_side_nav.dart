import 'package:flutter/material.dart';
import 'package:gymnastic_center/infrastructure/config/menu/menu_items.dart';
import 'package:gymnastic_center/infrastructure/screens/about_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/account_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/auth/welcome_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/faq_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/language_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/notifications/notifications_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/privacy_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/rate_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/statistics_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_gradient.dart';

class MenuSideNav extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const MenuSideNav({super.key, required this.scaffoldKey});

  @override
  State<MenuSideNav> createState() => _MenuSideNavState();
}

class _MenuSideNavState extends State<MenuSideNav> {
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;

    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(100),
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
            gradient: brandGradient), // Cambia esto a tu color deseado
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, hasNotch ? 70 : 50, 0, 10),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.cancel_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              for (var i = 0; i < appMenuItems.length; i++)
                ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                  title: Text(appMenuItems[i].title,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 20)),
                  leading: Icon(appMenuItems[i].icon, color: Colors.white),
                  onTap: () {
                    setState(() {
                      navDrawerIndex = i;
                    });
                    Navigator.pop(context);
                    switch (navDrawerIndex) {
                      case 0:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AccountScreen()),
                        );
                        break;
                      case 1:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const NotificationsScreen()),
                        );
                        break;
                      case 2:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PrivacyScreen()),
                        );
                        break;
                      case 3:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FAQScreen()),
                        );
                        break;
                      case 4:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StatisticsScreen()),
                        );
                        break;
                      case 5:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LanguageScreen()),
                        );
                        break;
                      case 6:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RateUsScreen()),
                        );
                        break;
                      case 7:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutScreen()),
                        );
                        break;
                    }
                  },
                ),
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(15, 100, 15, 10),
                title: const Text('Logout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                leading: const Icon(Icons.logout, color: Colors.white),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const WelcomeScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
