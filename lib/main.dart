import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/infrastructure/presentation/screens/auth/login_screen.dart';
import 'package:flutter_template/infrastructure/presentation/screens/home_screen.dart';
import 'package:flutter_template/infrastructure/services/firebase/firebase_handler.dart';
import 'package:flutter_template/infrastructure/services/firebase/firebase_options.dart';
import 'package:flutter_template/infrastructure/presentation/config/theme/app_theme.dart';
import 'package:flutter_template/application/blocs/notifications/notifications_bloc.dart';
import 'package:flutter_template/infrastructure/services/notifications/notification_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => NotificationsBloc(
            handler: NotificationHandler()..initializeLocalNotifications()),
      )
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: AppTheme().getDarkTheme(),
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const HomeScreen(),
    );
  }
}
