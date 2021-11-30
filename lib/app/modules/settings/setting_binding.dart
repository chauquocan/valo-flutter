import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/settings/setting_controller.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => SettingController());
  }
}
