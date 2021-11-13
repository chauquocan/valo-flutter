part of 'home.dart';

//binding controllers used in Home view
class HomeBinding implements Bindings {
  @override
  void dependencies() {
    //home
    Get.lazyPut(() => HomeController(provider: ProfileProvider()));
    //tabs
    // Get.lazyPut(() => TabProfileController(provider: UserProvider()));
    // Get.lazyPut(() => TabContactController(
    //     friendProvider: FriendProvider(), userProvider: UserProvider()));
    // Get.lazyPut(() => TabConversationController(
    //     chatProvider: ChatProvider(), userProvider: UserProvider()));
    Get.put<TabProfileController>(
        TabProfileController(provider: ProfileProvider()));
    Get.put<TabContactController>(TabContactController(
        contactProvider: ContactProvider(), userProvider: ProfileProvider()));
    Get.put<TabConversationController>(TabConversationController(
        chatProvider: ChatProvider(), userProvider: ProfileProvider()));
  }
}
