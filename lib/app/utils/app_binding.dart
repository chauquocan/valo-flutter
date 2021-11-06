import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/providers/user_provider.dart';
import 'package:valo_chat_app/app/modules/auth/auth.dart';
import 'package:valo_chat_app/app/modules/home/home.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => HomeController(provider: Get.put(UserProvider())));
  }
}
