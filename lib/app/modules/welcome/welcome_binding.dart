import 'package:get/get.dart';
import 'package:valo_chat_app/app/lang/lang.dart';
import 'package:valo_chat_app/app/modules/welcome/welcome_controller.dart';

class WelcomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WelcomeController>(() => WelcomeController());
  }
}
