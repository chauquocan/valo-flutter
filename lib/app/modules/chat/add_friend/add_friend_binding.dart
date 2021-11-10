import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/providers/friend_request_provider.dart';
import 'package:valo_chat_app/app/data/providers/user_provider.dart';
import 'package:valo_chat_app/app/modules/chat/add_friend/add_friend_controller.dart';

class AddFriendBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddFriendController(
          userProvider: UserProvider(),
          friendProvider: FriendRequestProvider(),
        ));
  }
}
