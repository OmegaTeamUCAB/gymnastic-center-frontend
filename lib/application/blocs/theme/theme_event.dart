part of 'theme_bloc.dart';

sealed class ThemeEvent {
  const ThemeEvent();
}

class ToggleDarkMode extends ThemeEvent {}

