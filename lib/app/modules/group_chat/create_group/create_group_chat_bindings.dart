part of '../group.dart';

class CreateGroupChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateGroupChatController(
        userProvider: ProfileProvider(),
        contactProvider: ContactProvider(),
        groupChatProvider: GroupChatProvider()));
    Get.lazyPut(() => AddMemberController(
        groupChatProvider: GroupChatProvider(),
        profileProvider: ProfileProvider()));
  }
}
