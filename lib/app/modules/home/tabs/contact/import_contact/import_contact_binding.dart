import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/home/tabs/contact/import_contact/import_contact_controller.dart';
import 'package:valo_chat_app/app/modules/search/add_friend/add_friend_controller.dart';

class ImportContactBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ImportContactController());
    Get.put(AddFriendController());
  }
}
