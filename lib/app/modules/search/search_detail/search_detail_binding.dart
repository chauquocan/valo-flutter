import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/search/add_friend/add_friend_controller.dart';
import 'package:valo_chat_app/app/modules/search/search_detail/search_detail_controller.dart';

class SearchDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchDetailController());
    Get.lazyPut(() => AddFriendController());
  }
}
