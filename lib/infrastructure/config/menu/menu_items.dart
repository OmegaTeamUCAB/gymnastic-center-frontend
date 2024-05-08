import 'package:flutter/material.dart';
import 'package:gymnastic_center/infrastructure/screens/about_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/account_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/faq_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/language_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/notifications/notifications_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/privacy_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/rate_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/statistics_screen.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final void Function(BuildContext) redirect;

  const MenuItem(
      {required this.title, required this.icon, required this.redirect});
}

final appMenuItems = <MenuItem>[
  MenuItem(
    title: 'Account',
    icon: Icons.person,
    redirect: (context) => Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AccountScreen())),
  ),
  MenuItem(
    title: 'Notifications',
    icon: Icons.notifications_on,
    redirect: (context) => Navigator.push(context,
        MaterialPageRoute(builder: (context) => const NotificationsScreen())),
  ),
  MenuItem(
    title: 'Privacy',
    icon: Icons.lock,
    redirect: (context) => Navigator.push(context,
        MaterialPageRoute(builder: (context) => const PrivacyScreen())),
  ),
  MenuItem(
    title: 'FAQ',
    icon: Icons.help_outlined,
    redirect: (context) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => const FAQScreen())),
  ),
  MenuItem(
    title: 'Statistics',
    icon: Icons.equalizer,
    redirect: (context) => Navigator.push(context,
        MaterialPageRoute(builder: (context) => const StatisticsScreen())),
  ),
  MenuItem(
    title: 'Language',
    icon: Icons.translate,
    redirect: (context) => Navigator.push(context,
        MaterialPageRoute(builder: (context) => const LanguageScreen())),
  ),
  MenuItem(
    title: 'Rate Us',
    icon: Icons.groups_rounded,
    redirect: (context) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => const RateUsScreen())),
  ),
  MenuItem(
    title: 'About',
    icon: Icons.people_sharp,
    redirect: (context) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AboutScreen())),
  ),
];
