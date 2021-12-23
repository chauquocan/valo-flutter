part of 'theme.dart';

//theme
class AppTheme {
  AppTheme._();

  static final ThemeData dark = ThemeData.dark().copyWith(
    backgroundColor: Colors.black87,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 2,
    ),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: Colors.blue),
  );

  static final ThemeData light = ThemeData.light().copyWith(
    backgroundColor: Colors.white,
  );
}
