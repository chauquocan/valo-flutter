import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/providers/chat_provider.dart';
import 'package:valo_chat_app/app/data/providers/contact_provider.dart';
import 'package:valo_chat_app/app/data/providers/group_chat_provider.dart';
import 'package:valo_chat_app/app/data/providers/profile_provider.dart';
import 'package:valo_chat_app/app/modules/chat/chat.dart';
import 'package:valo_chat_app/app/modules/chat/chat_controller.dart';
import 'package:valo_chat_app/app/modules/chat/video/call_controller.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/widgets/profile_friend_controller.dart';

import 'create_group_chat/create_group_chat_controller.dart';

class ChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ChatController>(ChatController(
        chatProvider: ChatProvider(),
        profileProvider: ProfileProvider(),
        groupChatProvider: GroupChatProvider()));
    Get.lazyPut(
        () => ProfileFriendController(profileProvider: ProfileProvider()));
    Get.lazyPut(() => CallController());
  }
}
