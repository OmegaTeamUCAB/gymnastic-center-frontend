import 'package:flutter/material.dart';
import 'package:gymnastic_center/infrastructure/screens/settings/about_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/settings/account_settings_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/settings/faq_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/settings/language_settings_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/settings/notification_settings_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/settings/privacy_settings_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/settings/rate_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/settings/statistics_screen.dart';
import 'package:gymnastic_center/presentation/widgets/icons/gymnastic_center_icons.dart';

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
    icon: GymnasticCenter.account,
    redirect: (context) => Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AccountSettingsScreen())),
  ),
  MenuItem(
    title: 'Notifications',
    icon: Icons.notifications_on,
    redirect: (context) => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const NotificationSettingsScreen())),
  ),
  MenuItem(
    title: 'Privacy',
    icon: GymnasticCenter.lock,
    redirect: (context) => Navigator.push(context,
        MaterialPageRoute(builder: (context) => const PrivacySettingsScreen())),
  ),
  MenuItem(
    title: 'FAQ',
    icon: GymnasticCenter.question,
    redirect: (context) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => const FAQScreen())),
  ),
  MenuItem(
    title: 'Statistics',
    icon: GymnasticCenter.statistics,
    redirect: (context) => Navigator.push(context,
        MaterialPageRoute(builder: (context) => const StatisticsScreen())),
  ),
  MenuItem(
    title: 'Language',
    icon: Icons.translate,
    redirect: (context) => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const LanguageSettingsScreen())),
  ),
  MenuItem(
    title: 'Rate Us',
    icon: GymnasticCenter.rate,
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
