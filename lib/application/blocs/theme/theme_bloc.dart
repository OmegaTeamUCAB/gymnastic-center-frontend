import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/infrastructure/presentation/config/theme/app_theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.lightTheme) {
    on<ToggleDarkMode>(_onToggleDarkMode);
  }

  _onToggleDarkMode(ToggleDarkMode event, Emitter<ThemeState> emit) {
    final isDarkMode = !state.isDarkMode;
    emit(state.copyWith(
        isDarkMode: isDarkMode,
        themeData: isDarkMode ? AppTheme.getDarkTheme() : AppTheme.getTheme()));
  }
}
