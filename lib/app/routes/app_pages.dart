import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/auth/auth.dart';
import 'package:valo_chat_app/app/modules/chat/create_group_chat/create_group_chat_bindings.dart';
import 'package:valo_chat_app/app/modules/chat/create_group_chat/create_group_chat_screen.dart';
import 'package:valo_chat_app/app/modules/home/home.dart';
import 'package:valo_chat_app/app/modules/auth/login/login.dart';
import 'package:valo_chat_app/app/modules/auth/register/register.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/profile.dart';
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
      name: Routes.AUTH,
      page: () => AuthScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.OTP,
      page: () => OtpScreen(
        phoneNumber: '',
      ),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.EDITPROFILE,
      page: () => EditProfileScreen(),
    ),
    GetPage(
        name: Routes.CREATEGROUP,
        page: () => CreateGroupChatScreen(),
        binding: CreateGroupChatBinding()),
  ];
}
