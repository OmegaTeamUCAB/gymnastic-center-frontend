part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final ThemeData themeData;
  final bool isDarkMode;

  const ThemeState({
    required this.themeData, 
    required this.isDarkMode
  });

  ThemeState copyWith({
    ThemeData? themeData, 
    bool? isDarkMode
  }) => ThemeState(
      themeData: themeData ?? this.themeData,
      isDarkMode: isDarkMode ?? this.isDarkMode
    );

  static ThemeState get lightTheme => ThemeState(
      themeData: AppTheme.getTheme(), 
      isDarkMode: false
    );

  static ThemeState get darkTheme => ThemeState(
      themeData: AppTheme.getDarkTheme(), 
      isDarkMode: true
    );

  @override
  List<Object> get props => [themeData, isDarkMode];
}
