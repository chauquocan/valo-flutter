import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/home/home.dart';
import 'package:valo_chat_app/app/modules/auth/login/login.dart';
import 'package:valo_chat_app/app/modules/auth/register/register.dart';

part './app_routes.dart';

abstract class AppPages {
  AppPages._();
  static final pages = [
    GetPage(name: Routes.HOME, page: () => HomeScreen()),
    GetPage(name: Routes.LOGIN, page: () => LoginScreen()),
    GetPage(name: Routes.REGISTER, page: () => RegisterScreen())
  ];
}
