import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/providers/auth_provider.dart';
import 'package:valo_chat_app/app/modules/Network/network_controller.dart';
import 'package:valo_chat_app/app/modules/auth/auth.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => AuthProvider());
    Get.lazyPut(() => AuthController());
    Get.put(NetworkController(), permanent: true);
  }
}
