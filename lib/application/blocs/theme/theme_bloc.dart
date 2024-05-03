import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_template/infrastructure/presentation/config/theme/app_theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.lightTheme) {
    on<Toggle>(_onToggleDarkMode);
    on<ToggleToLight>(_onToggleToLight);
    on<ToggleToDark>(_onToggleToDark);
  }

  _onToggleDarkMode(Toggle event, Emitter<ThemeState> emit) {
    final isDarkMode = !state.isDarkMode;
    emit(state.copyWith(
        isDarkMode: isDarkMode,
        themeData: isDarkMode ? AppTheme.getDarkTheme() : AppTheme.getTheme()));
  }

  _onToggleToLight(ToggleToLight event, Emitter<ThemeState> emit) {
    final isDark = state.isDarkMode;
    if (!isDark) return;
    _onToggleDarkMode(Toggle(), emit);
  }
  
  _onToggleToDark(ToggleToDark event, Emitter<ThemeState> emit) {
    final isDark = state.isDarkMode;
    if (isDark) return;
    _onToggleDarkMode(Toggle(), emit);
  }
  
}
