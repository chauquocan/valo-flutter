import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/auth/auth.dart';
import 'package:valo_chat_app/app/modules/add_friend/add_friend_binding.dart';
import 'package:valo_chat_app/app/modules/add_friend/add_friend_screen.dart';
import 'package:valo_chat_app/app/modules/add_friend/friend_request_screen.dart';
import 'package:valo_chat_app/app/modules/chat/chat.dart';
import 'package:valo_chat_app/app/modules/group_chat/group.dart';
import 'package:valo_chat_app/app/modules/home/home.dart';
import 'package:valo_chat_app/app/modules/auth/login/login.dart';
import 'package:valo_chat_app/app/modules/auth/register/register.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/profile.dart';
import 'package:valo_chat_app/app/modules/settings/setting_binding.dart';
import 'package:valo_chat_app/app/modules/settings/setting_screen.dart';
import 'package:valo_chat_app/app/modules/welcome/welcome_screen.dart';
import 'package:valo_chat_app/app/utils/app_binding.dart';

part './app_routes.dart';

abstract class AppPages {
  AppPages._();
  static final pages = [
    GetPage(
      name: Routes.WELCOME,
      page: () => WelcomeScreen(),
      binding: AppBinding(),
    ),
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
      page: () => RegisterScreen(
        numberPhone: '',
      ),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.EDITPROFILE,
      page: () => EditProfileScreen(),
    ),
    GetPage(
      name: Routes.CREATEGROUP,
      page: () => CreateGroupChatScreen(),
      binding: CreateGroupChatBinding(),
    ),
    GetPage(
      name: Routes.NEWFRIEND,
      page: () => AddFriendScreen(),
      binding: AddFriendBinding(),
    ),
    GetPage(
      name: Routes.FRIENDREQUEST,
      page: () => FriendRequestScreen(),
      binding: AddFriendBinding(),
    ),
    GetPage(
      name: Routes.CHAT,
      page: () => ChatScreen(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: Routes.SETTING,
      page: () => SettingScreen(),
      binding: SettingBinding(),
    ),
  ];
}
