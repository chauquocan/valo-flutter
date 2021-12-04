import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/widgets/profile_friend_controller.dart';

class ProfileFriendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileFriendController());
  }
}
