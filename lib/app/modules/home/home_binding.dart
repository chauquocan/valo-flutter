part of 'home.dart';

//binding controllers used in Home view
class HomeBinding implements Bindings {
  @override
  void dependencies() {
    //home
    Get.lazyPut(() => HomeController(provider: ProfileProvider()));
    // tabs
    // Get.lazyPut(() => TabProfileController(provider: ProfileProvider()));
    // Get.lazyPut(() => TabContactController(
    //     contactProvider: ContactProvider(), userProvider: ProfileProvider()));
    // Get.lazyPut(() => TabConversationController(
    //     chatProvider: ChatProvider(), userProvider: ProfileProvider()));
    Get.put<TabProfileController>(TabProfileController(
        userProvider: ProfileProvider(), authProvider: AuthProvider()));
    Get.put<TabContactController>(TabContactController(
        contactProvider: ContactProvider(), userProvider: ProfileProvider()));
    Get.put<TabConversationController>(TabConversationController(
        chatProvider: ChatProvider(), userProvider: ProfileProvider()));
  }
}
