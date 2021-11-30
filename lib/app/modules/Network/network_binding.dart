import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/Network/network_controller.dart';

class NetworkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NetworkController());
  }
}
