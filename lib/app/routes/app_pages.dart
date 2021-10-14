import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/home/home_screen.dart';

part './app_routes.dart';

abstract class AppPages {
  AppPages._();
  static final pages = [
    GetPage(name: Routes.HOME, page: () => HomeScreen()),
  ];
}
