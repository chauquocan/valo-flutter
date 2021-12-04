import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/chat/chat.dart';
import 'package:valo_chat_app/app/modules/chat/chat_controller.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/widgets/profile_friend_controller.dart';

class ChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ChatController>(ChatController());
    Get.lazyPut(
        () => ProfileFriendController());
  }
}
