import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/chat/chat_detail/media/media_controller.dart';

class MediaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MediaController());
  }
}
