import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/screens/profile/update_profile_screen.dart';
import 'package:gymnastic_center/presentation/screens/settings/about_screen.dart';
import 'package:gymnastic_center/presentation/screens/settings/faq/faq_screen.dart';
import 'package:gymnastic_center/presentation/screens/settings/language_settings_screen.dart';
import 'package:gymnastic_center/presentation/screens/settings/notification_settings_screen.dart';
import 'package:gymnastic_center/presentation/screens/settings/privacy_settings_screen.dart';
import 'package:gymnastic_center/presentation/screens/settings/rate_screen.dart';
import 'package:gymnastic_center/presentation/screens/settings/statistics_screen.dart';
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
        MaterialPageRoute(builder: (context) => const UpdateProfileScreen())),
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
    title: 'FAQ',
    icon: GymnasticCenter.question,
    redirect: (context) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => const FAQScreen())),
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
    title: 'About',
    icon: GymnasticCenter.about,
    redirect: (context) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AboutScreen())),
  ),
];
