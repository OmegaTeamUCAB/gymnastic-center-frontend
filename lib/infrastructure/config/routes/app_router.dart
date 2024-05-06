import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/infrastructure/screens/about_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/account_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/faq_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/language_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/privacy_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/rate_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/setting_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/statistics_screen.dart';

import '../../screens/notifications_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: PruebaScreen.name,
      builder: (context, state) => const PruebaScreen(),
    ),
    GoRoute(
      path: '/account',
      name: AccountScreen.name,
      builder: (context, state) => const AccountScreen(),
    ),
    GoRoute(
      path: '/notifications',
      name: NotificationsScreen.name,
      builder: (context, state) => const NotificationsScreen(),
    ),
    GoRoute(
      path: '/privacy',
      name: PrivacyScreen.name,
      builder: (context, state) => const PrivacyScreen(),
    ),
    GoRoute(
      path: '/faq',
      name: FAQScreen.name,
      builder: (context, state) => const FAQScreen(),
    ),
    GoRoute(
      path: '/statistics',
      name: StatisticsScreen.name,
      builder: (context, state) => const StatisticsScreen(),
    ),
    GoRoute(
      path: '/language',
      name: LanguageScreen.name,
      builder: (context, state) => const LanguageScreen(),
    ),
    GoRoute(
      path: '/rate_us',
      name: RateUsScreen.name,
      builder: (context, state) => const RateUsScreen(),
    ),
    GoRoute(
      path: '/about',
      name: AboutScreen.name,
      builder: (context, state) => const AboutScreen(),
    ),
  ],
);
