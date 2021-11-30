part of 'home.dart';

//binding controllers used in Home view
class HomeBinding implements Bindings {
  @override
  void dependencies() {
    //home
    Get.lazyPut(() => HomeController(provider: ProfileProvider()));
    // tabs
    Get.put<TabProfileController>(TabProfileController(
        userProvider: ProfileProvider(), authProvider: AuthProvider()));
    Get.put<TabContactController>(TabContactController(
        contactProvider: ContactProvider(), userProvider: ProfileProvider()));
    Get.put<TabConversationController>(TabConversationController(
        chatProvider: ChatProvider(), userProvider: ProfileProvider()));
  }
}
