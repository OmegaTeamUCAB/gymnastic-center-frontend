import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/course/course_bloc.dart';
import 'package:gymnastic_center/application/blocs/auth/auth_bloc.dart';
import 'package:gymnastic_center/application/blocs/theme/theme_bloc.dart';
import 'package:gymnastic_center/infrastructure/config/DI/ioc_container.dart';
import 'package:gymnastic_center/presentation/screens/auth/welcome_screen.dart';
import 'package:gymnastic_center/application/blocs/notifications/notifications_bloc.dart';

void main() async {
  await IoCContainer.init();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt.get<AuthBloc>()),
        BlocProvider(
          create: (context) => getIt.get<NotificationsBloc>(),
        ),
        BlocProvider(create: (context) => getIt.get<ThemeBloc>()),
        BlocProvider(create: (context) => getIt.get<CourseBloc>()),
        // BlocProvider(create: (context) => PlayerBloc())
      ],
      child: const App(),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;
    final userTheme = MediaQuery.of(context).platformBrightness;
    (userTheme == Brightness.dark)
        ? context.watch<ThemeBloc>().add(ToggleToDark())
        : context.watch<ThemeBloc>().add(ToggleToLight());
    return MaterialApp(
      theme: getIt.get<ThemeBloc>().state.themeData,
      debugShowCheckedModeBanner: false,
      title: 'Gymnastic Center',
      home: const WelcomeScreen(),
    );
  }
}
