part of '../group.dart';

class CreateGroupChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateGroupChatController());
    Get.lazyPut(() => AddMemberController());
  }
}
