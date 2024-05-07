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
  MenuItem(title: 'Privacy', link: '/privacy', icon: Icons.lock),
  MenuItem(title: 'FAQ', link: '/faq', icon: Icons.help_outlined),
  MenuItem(title: 'Statistics', link: '/statistics', icon: Icons.equalizer),
  MenuItem(title: 'Language', link: '/language', icon: Icons.translate),
  MenuItem(title: 'Rate Us', link: '/rate_us', icon: Icons.groups_rounded),
  MenuItem(title: 'About', link: '/about', icon: Icons.people_sharp),
];
