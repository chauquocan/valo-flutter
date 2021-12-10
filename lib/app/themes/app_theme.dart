part of 'theme.dart';

//theme
class AppTheme {
  AppTheme._();

  static final ThemeData dark = ThemeData.dark().copyWith(
    backgroundColor: Colors.black87,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 2,
    ),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Colors.blue),
  );

  static final ThemeData light = ThemeData.light().copyWith(
    backgroundColor: Colors.white,
  );
}
