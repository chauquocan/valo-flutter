import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/home/home.dart';
import 'package:valo_chat_app/app/modules/auth/login/login.dart';
import 'package:valo_chat_app/app/modules/auth/register/register.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/tab_profile.dart';
import 'package:valo_chat_app/app/modules/welcome/welcome_screen.dart';
import 'package:valo_chat_app/app/utils/app_binding.dart';

part './app_routes.dart';

abstract class AppPages {
  AppPages._();
  static final pages = [
    GetPage(
        name: Routes.WELCOME,
        page: () => WelcomeScreen(),
        binding: AppBinding()),
    GetPage(
      name: Routes.HOME,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => TabProfile(),
    )
  ];
}
