import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/chat/chat_detail/chat_detail_controller.dart';

class ChatDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatDetailController());
  }
}
