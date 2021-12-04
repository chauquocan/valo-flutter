import 'package:get/get.dart';

import 'add_friend_controller.dart';

class AddFriendBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddFriendController());
  }
}
