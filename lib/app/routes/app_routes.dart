part of './app_pages.dart';

//Routes
abstract class Routes {
  //
  static const WELCOME = '/';
  static const HOME = '/home';

  //auth
  static const AUTH = '/auth';
  static const OTP = '/otp';
  static const LOGIN = '/login';
  static const REGISTER = '/register';

  //tabs
  static const PROFILE = '/profile';
  static const CONTACT = '/contact';

  static const CHAT = '/chat';

  static const CREATEGROUP = '/creategroup';
  static const NEWFRIEND = '/newfriend';
  static const FRIENDREQUEST = '/friendrequest';
  static const SETTING = '/setting';
}
