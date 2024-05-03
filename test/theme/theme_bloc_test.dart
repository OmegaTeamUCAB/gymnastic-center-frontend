import 'package:bloc_test/bloc_test.dart';
import 'package:gymnastic_center/application/blocs/theme/theme_bloc.dart';
import 'package:gymnastic_center/infrastructure/presentation/config/theme/app_theme.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Theme Bloc Testing', () {
    late ThemeBloc themeBloc;

    setUp(() {
      themeBloc = ThemeBloc();
    });

    blocTest<ThemeBloc, ThemeState>(
      'emits [ThemeState as darkMode] when [ToggleDarkMode] event is added one time.',
      build: () => themeBloc,
      act: (bloc) => bloc.add(ToggleDarkMode()),
      expect: () =>
          [ThemeState(themeData: AppTheme.getDarkTheme(), isDarkMode: true)],
    );

    blocTest<ThemeBloc, ThemeState>(
      'emits [ThemeState as lightMode] when [ToggleDarkMode] event is triggered twice.',
      build: () => themeBloc,
      act: (bloc) => bloc
        ..add(ToggleDarkMode())
        ..add(ToggleDarkMode()),
      expect: () => [
        ThemeState(themeData: AppTheme.getDarkTheme(), isDarkMode: true),
        ThemeState(themeData: AppTheme.getTheme(), isDarkMode: false),
      ],
    );
  });
}
