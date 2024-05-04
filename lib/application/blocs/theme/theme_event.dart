part of 'theme_bloc.dart';

sealed class ThemeEvent {
  const ThemeEvent();
}

class Toggle extends ThemeEvent {}
class ToggleToLight extends ThemeEvent {}
class ToggleToDark extends ThemeEvent {}
