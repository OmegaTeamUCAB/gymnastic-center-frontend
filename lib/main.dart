import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/brand_notifications/brand_notifications_bloc.dart';
import 'package:gymnastic_center/application/blocs/course/course_bloc.dart';
import 'package:gymnastic_center/application/blocs/auth/auth_bloc.dart';
import 'package:gymnastic_center/application/blocs/select_data_source/select_data_source_bloc.dart';
import 'package:gymnastic_center/application/blocs/theme/theme_bloc.dart';
import 'package:gymnastic_center/infrastructure/config/DI/ioc_container.dart';
import 'package:gymnastic_center/presentation/screens/auth/auth_options_screen.dart';
import 'package:gymnastic_center/application/blocs/notifications/notifications_bloc.dart';
import 'package:gymnastic_center/presentation/screens/home/main_screen.dart';
import 'package:gymnastic_center/presentation/screens/loading_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  await IoCContainer.init();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MainAppState? state = context.findAncestorStateOfType<_MainAppState>();
    state?.setLocale(newLocale);
  }
}

class _MainAppState extends State<MainApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

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
          BlocProvider(create: (context) => getIt.get<SelectDataSourceBloc>()),
          BlocProvider(
              create: (context) => getIt.get<BrandNotificationsBloc>()),
        ],
        child: Builder(builder: (context) {
          final userTheme = MediaQuery.of(context).platformBrightness;
          (userTheme == Brightness.dark)
              ? context.watch<ThemeBloc>().add(ToggleToDark())
              : context.watch<ThemeBloc>().add(ToggleToLight());
          return MaterialApp(
              theme: getIt.get<ThemeBloc>().state.themeData,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              debugShowCheckedModeBanner: false,
              title: 'Gymnastic Center',
              locale: _locale,
              home: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const LoadingScreen();
                  } else if (state is Authenticated) {
                    return const MainScreen();
                  } else {
                    return const AuthOptionsScreen();
                  }
                },
              ));
        }));
  }
}
