part of 'theme.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData dark = ThemeData(
    textTheme: const TextTheme(
      bodyText2: TextStyle(color: Colors.white),
      headline6: TextStyle(color: Colors.white),
      subtitle1: TextStyle(color: Colors.white),
    ),
  );

  static final ThemeData light = ThemeData();
}
