import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/providers/group_chat_provider.dart';
import 'package:valo_chat_app/app/data/providers/profile_provider.dart';

import 'add_member_controller.dart';

class AddMemberBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AddMemberController>(AddMemberController(
        groupChatProvider: GroupChatProvider(),
        profileProvider: ProfileProvider()));
  }
}
