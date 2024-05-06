import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String link;
  final IconData icon;

  const MenuItem({required this.title, required this.link, required this.icon});
}

const appMenuItems = <MenuItem>[
  MenuItem(title: 'Account', link: '/account', icon: Icons.person),
  MenuItem(
      title: 'Notifications',
      link: '/notifications',
      icon: Icons.notifications_on),
  MenuItem(title: 'Privacy', link: '/privacy', icon: Icons.privacy_tip_rounded),
  MenuItem(title: 'FAQ', link: '/faq', icon: Icons.question_mark),
  MenuItem(title: 'Statistics', link: '/statistics', icon: Icons.analytics),
  MenuItem(title: 'Language', link: '/language', icon: Icons.language_rounded),
  MenuItem(title: 'Rate Us', link: '/rate_us', icon: Icons.star_rate_rounded),
  MenuItem(title: 'About', link: '/about', icon: Icons.abc_outlined),
];
