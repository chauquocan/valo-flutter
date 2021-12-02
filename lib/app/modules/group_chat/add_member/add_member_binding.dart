
part of '../group.dart';
class AddMemberBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AddMemberController>(AddMemberController(
        groupChatProvider: GroupChatProvider(),
        profileProvider: ProfileProvider()));
  }
}
