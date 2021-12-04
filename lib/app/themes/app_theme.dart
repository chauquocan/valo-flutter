part of 'theme.dart';

//theme
class AppTheme {
  AppTheme._();

  static final ThemeData dark = ThemeData.dark().copyWith();

  static final ThemeData light = ThemeData.light().copyWith(
    backgroundColor: Colors.lightBlue,
  );
}
