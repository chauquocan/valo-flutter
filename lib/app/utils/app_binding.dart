import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/providers/user_provider.dart';
import 'package:valo_chat_app/app/modules/auth/auth.dart';
import 'package:valo_chat_app/app/modules/home/home.dart';
import 'package:valo_chat_app/app/modules/home/tabs/contact/tab_contact_controller.dart';
import 'package:valo_chat_app/app/modules/home/tabs/conversation/tab_conversations_controller.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/tab_profile_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => HomeController(provider: Get.put(UserProvider())));
    Get.lazyPut(() => TabContactController());
    Get.lazyPut(() => TabConversationController());
    Get.lazyPut(() => TabProfileController());
  }
}
