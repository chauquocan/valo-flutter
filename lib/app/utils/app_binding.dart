import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/providers/auth_provider.dart';
import 'package:valo_chat_app/app/data/providers/profile_provider.dart';
import 'package:valo_chat_app/app/modules/auth/auth.dart';
import 'package:valo_chat_app/app/modules/home/home.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => AuthController(authProvider: AuthProvider()));
    Get.lazyPut(
      () => HomeController(
          provider: Get.put(
        ProfileProvider(),
      )),
    );
  }
}
