import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/screens/profile/update_profile_screen.dart';
import 'package:gymnastic_center/presentation/about/about_screen.dart';
import 'package:gymnastic_center/presentation/screens/settings/faq/faq_screen.dart';
import 'package:gymnastic_center/presentation/screens/settings/language_settings_screen.dart';
import 'package:gymnastic_center/presentation/screens/settings/notification_settings_screen.dart';
import 'package:gymnastic_center/presentation/widgets/icons/gymnastic_center_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MenuItem {
  final String Function(BuildContext) title;
  final IconData icon;
  final void Function(BuildContext) redirect;

  const MenuItem(
      {required this.title, required this.icon, required this.redirect});
}

final appMenuItems = <MenuItem>[
  MenuItem(
    title: (context) => AppLocalizations.of(context)!.account,
    icon: GymnasticCenter.account,
    redirect: (context) => Navigator.push(context,
        MaterialPageRoute(builder: (context) => const UpdateProfileScreen())),
  ),
  MenuItem(
    title: (context) => AppLocalizations.of(context)!.notifications,
    icon: Icons.notifications_on,
    redirect: (context) => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const NotificationSettingsScreen())),
  ),
  MenuItem(
    title: (context) => AppLocalizations.of(context)!.faq,
    icon: GymnasticCenter.question,
    redirect: (context) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => const FAQScreen())),
  ),
  MenuItem(
    title: (context) => AppLocalizations.of(context)!.language,
    icon: Icons.translate,
    redirect: (context) => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const LanguageSettingsScreen())),
  ),
  MenuItem(
    title: (context) => AppLocalizations.of(context)!.about,
    icon: GymnasticCenter.about,
    redirect: (context) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AboutScreen())),
  ),
];
